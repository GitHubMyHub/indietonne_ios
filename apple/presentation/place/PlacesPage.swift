//
//  PlacesPage.swift
//
//  Listet alle verfügbaren Orte, gruppiert nach Anfangsbuchstabe.
//  Äquivalent zu Android `presentation/place/PlacesPage.kt`.
//

import SwiftUI

struct PlacesPage: View {
    @Environment(AppEnvironment.self) private var env
    @Binding var path: NavigationPath
    @State private var viewModel: PlacesViewModel?

    var body: some View {
        List {
            ForEach(categorized, id: \.title) { category in
                Section(category.title) {
                    ForEach(category.items) { place in
                        PlaceListItem(
                            text: place.name,
                            placePicture: place.images.first?.storedName ?? ""
                        ) {
                            path.append(AppRoute.streets(placeId: place.id))
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Places")
        .navigationBarTitleDisplayMode(.large)
        .overlay {
            if viewModel?.state.isLoading == true {
                ProgressView()
            }
        }
        .task {
            if viewModel == nil {
                viewModel = PlacesViewModel(useCase: env.getAppointmentsUseCase)
                viewModel?.load()
            }
        }
    }

    private var categorized: [Category<PlaceDTO>] {
        let groups = Dictionary(grouping: viewModel?.state.places ?? []) {
            String($0.name.prefix(1)).uppercased()
        }
        return groups
            .map { Category(title: $0.key, items: $0.value.sorted(by: { $0.name < $1.name })) }
            .sorted(by: { $0.title < $1.title })
    }
}
