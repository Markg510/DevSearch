//
//  ClientsList.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import SwiftUI
import SwiftData

struct ClientsList: View {
    // Environment Properties
    @Environment(\.isSearching) private var isSearching
    @Environment(GeneralVM.self) private var gvm
    @Environment(HomeVM.self) private var vm

    // Passed Properties
    @Binding var viewMode: ViewMode
    @Binding var searchPage: Int
    @Binding var isLoadingMore: Bool
    let search: String
    
    // Swift Data Properties
    @Environment(\.modelContext) private var modelContext
    @Query private var cachedDevelopers: [CachedDeveloper]

    var body: some View {
        if isSearching {
            searchClients
        } else {
            savedClients
        }
    }

    @ViewBuilder
    private var searchClients: some View {
        if viewMode.isLoading && searchPage == 1 {
            ForEach(0...7, id:\.self) { _ in
                LoadingDeveloperItem()
            }
        } else {
            ForEach(vm.searchResults) { developer in
                Button {
                    gvm.path.append(developer)
                } label: {
                    SearchDeveloperItem(developer: developer)
                }
                .onAppear {
                    guard developer.id == vm.searchResults.last?.id else {
                        return
                    }

                    loadNextPage()
                }
            }

            if isLoadingMore {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
    }
    
    @ViewBuilder
    private var savedClients: some View {
        if cachedDevelopers.isEmpty {
            ContentUnavailableView("No Developers Found", image: "text.page.slash", description: Text("You'll find your saved developers here"))
        } else {
            ForEach(cachedDevelopers) { dev in
                Button {
                    gvm.path.append(convertCachedToSearch(dev))
                } label: {
                    SearchDeveloperItem(developer: convertCachedToSearch(dev))
                }
            }
        }
    }
    
    private func convertCachedToSearch(_ cachedDev: CachedDeveloper) -> SearchDeveloper {
        SearchDeveloper(
            id: cachedDev.id,
            login: cachedDev.login,
            avatar_url: cachedDev.avatarURL
        )
    }

    private func loadNextPage() {
        guard !isLoadingMore else { return }

        let nextPage = searchPage + 1
        isLoadingMore = true

        Task {
            do {
                try await vm.searchUsers(
                    query: search,
                    page: nextPage
                )

                searchPage = nextPage
            } catch {
                viewMode = .failure(error: error)
            }

            isLoadingMore = false
        }
    }
}

#Preview {
    ClientsList(
        viewMode: .constant(.success),
        searchPage: .constant(0),
        isLoadingMore: .constant(false),
        search: ""
    )
}
