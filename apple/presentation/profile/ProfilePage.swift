//
//  ProfilePage.swift
//

import SwiftUI

struct ProfilePage: View {
    @Environment(AppEnvironment.self) private var env
    @State private var viewModel: ProfileViewModel?

    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy HH:mm"
        return f
    }()

    var body: some View {
        Group {
            if viewModel?.state.isLoading == true {
                ProgressView()
            } else if let user = viewModel?.state.user {
                content(user: user)
            } else if let err = viewModel?.state.error, !err.isEmpty {
                Text("Error: \(err)").foregroundStyle(.red).padding()
            } else {
                Text("No user data available")
            }
        }
        .navigationTitle("Profile")
        .task {
            if viewModel == nil {
                viewModel = ProfileViewModel(useCase: env.getAppointmentsUseCase)
                viewModel?.load()
            }
        }
    }

    @ViewBuilder
    private func content(user: CurrentUserDTO) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable().scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color.primaryBrand)
                    Text(user.username).font(.title3.bold())
                    Text("User ID: \(user.id)").font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .background(.regularMaterial, in: .rect(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Account Information").font(.headline)
                    Label(user.username, systemImage: "envelope")
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial, in: .rect(cornerRadius: 12))

                if !user.devices.isEmpty {
                    Text("Registered Devices").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(user.devices) { d in
                        VStack(alignment: .leading, spacing: 4) {
                            Label(d.agent, systemImage: "iphone")
                            Text("Created: \(Self.formatter.string(from: d.createdAt))").font(.caption)
                            if let updated = d.updatedAt {
                                Text("Last updated: \(Self.formatter.string(from: updated))").font(.caption)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.regularMaterial, in: .rect(cornerRadius: 12))
                    }
                }
            }
            .padding(16)
        }
    }
}
