//
//  ScheduleOverviewPage.swift
//
//  Mirror of Android `presentation/scheduleOverview/ScheduleOverview.kt`.
//

import SwiftUI

struct ScheduleOverviewPage: View {
    @Environment(AppEnvironment.self) private var env
    @Environment(TokenStore.self) private var tokenStore
    @Binding var path: NavigationPath

    @State private var viewModel: ScheduleViewModel?
    @State private var pendingDelete: AppointmentGroupDTO?
    @State private var snackbarText: String?

    var body: some View {
        ZStack {
            List {
                bannerHeader
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                ForEach(viewModel?.state.appointments ?? []) { group in
                    PlaceListOverviewItem(
                        text: text(for: group),
                        fractions: thisWeekFractions(of: group),
                        placeId: group.place?.id ?? "",
                        placePicture: bannerPicture(of: group)
                    ) {
                        path.append(AppRoute.scheduleList(appointmentId: group.id))
                    }
                    .listRowInsets(EdgeInsets())
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            pendingDelete = group
                        } label: { Label("Delete", systemImage: "trash") }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                viewModel?.onAction(.refresh)
            }

            if let snackbarText {
                VStack {
                    Spacer()
                    Text(snackbarText)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.8), in: .capsule)
                        .padding(.bottom, 100)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button { path.append(AppRoute.profile) } label: {
                        Label("Profile", systemImage: "person")
                    }
                    Button { tokenStore.toggleDarkMode() } label: {
                        Label(
                            (tokenStore.isDarkMode ?? false) ? "Light Mode" : "Dark Mode",
                            systemImage: (tokenStore.isDarkMode ?? false) ? "sun.max" : "moon"
                        )
                    }
                    Button(role: .destructive) {
                        tokenStore.clear()
                        path = NavigationPath()
                        path.append(AppRoute.login)
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    Image(systemName: "person.crop.circle")
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                path.append(AppRoute.places)
            } label: {
                Image(systemName: "plus")
                    .font(.title.bold())
                    .frame(width: 56, height: 56)
                    .background(Color.primaryBrand, in: .circle)
                    .foregroundStyle(.white)
                    .shadow(radius: 6, y: 3)
            }
            .padding()
        }
        .alert("Delete entry", isPresented: Binding(
            get: { pendingDelete != nil },
            set: { if !$0 { pendingDelete = nil } }
        )) {
            Button("Yes", role: .destructive) {
                if let id = pendingDelete?.id { viewModel?.onAction(.delete(id: id)) }
                pendingDelete = nil
            }
            Button("No", role: .cancel) { pendingDelete = nil }
        } message: {
            Text("Are you sure you want to delete this entry?")
        }
        .task {
            if viewModel == nil {
                viewModel = ScheduleViewModel(useCase: env.getAppointmentsUseCase)
                viewModel?.onAction(.load)
            }
        }
        .onChange(of: viewModel?.state.snackbar) { _, msg in
            guard let msg else { return }
            withAnimation { snackbarText = msg }
            Task {
                try? await Task.sleep(nanoseconds: 2_500_000_000)
                withAnimation { snackbarText = nil }
                viewModel?.consumeSnackbar()
            }
        }
    }

    @ViewBuilder
    private var bannerHeader: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [Color.primaryBrand, Color.secondaryBrand],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 220)
            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 16, bottomTrailing: 16)))

            Text("InDieTonne")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.5), radius: 3, x: 2, y: 2)
                .padding()
        }
    }

    private func text(for group: AppointmentGroupDTO) -> String {
        let street = group.street?.name ?? ""
        let zip = group.place?.zipCodes.joined(separator: ", ") ?? ""
        let placeName = group.place?.name ?? ""
        return "\(street)\n\(zip) \(placeName)"
    }

    private func thisWeekFractions(of group: AppointmentGroupDTO) -> [FractionDTO] {
        let cal = Calendar(identifier: .iso8601)
        let now = Date()
        guard let interval = cal.dateInterval(of: .weekOfYear, for: now) else { return [] }
        let upcoming = group.appointments.filter {
            interval.contains($0.scheduledDate ?? .distantPast)
        }
        return upcoming.flatMap(\.fractions)
    }

    private func bannerPicture(of group: AppointmentGroupDTO) -> String {
        group.place?.images.first(where: { $0.origin == .placeLogo })?.storedName ?? ""
    }
}
