//
//  StreetPage.swift
//
//  Mirror of Android `presentation/street/StreetPage.kt`.
//

import SwiftUI

struct StreetPage: View {
    @Environment(AppEnvironment.self) private var env
    @Binding var path: NavigationPath
    let placeId: String

    @State private var viewModel: StreetViewModel?
    @State private var searchText: String = ""

    var body: some View {
        List {
            ForEach(categorized, id: \.title) { category in
                Section(category.title) {
                    ForEach(category.items) { street in
                        Button {
                            path.append(AppRoute.trashSettings(placeId: placeId, streetId: street.id))
                        } label: {
                            HStack {
                                Text(street.name).foregroundStyle(.primary)
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.secondary)
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Streets")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .overlay {
            if viewModel?.state.isLoading == true {
                ProgressView()
            }
        }
        .task(id: placeId) {
            if viewModel == nil {
                viewModel = StreetViewModel(useCase: env.getAppointmentsUseCase)
            }
            viewModel?.load(placeId: placeId)
        }
    }

    private var filtered: [StreetDTO] {
        let all = viewModel?.state.streets ?? []
        return searchText.isEmpty
            ? all
            : all.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    private var categorized: [Category<StreetDTO>] {
        let groups = Dictionary(grouping: filtered) {
            String($0.name.prefix(1)).uppercased()
        }
        return groups
            .map { Category(title: $0.key, items: $0.value.sorted(by: { $0.name < $1.name })) }
            .sorted(by: { $0.title < $1.title })
    }
}
