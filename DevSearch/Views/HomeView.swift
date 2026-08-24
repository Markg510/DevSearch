//
//  HomeView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct HomeView: View {
    // View Properties
    @State private var gvm = GeneralVM()
    @State private var vm = HomeVM()
    @State private var showSettingsSheet = false
    @State private var search = ""
    @State private var searchPage = 1
    @State private var isLoadingMore = false

    var body: some View {
        NavigationStack(path: $gvm.path) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ClientsList(
                        search: search,
                        searchPage: $searchPage,
                        isLoadingMore: $isLoadingMore
                    )
                    .environment(gvm)
                    .environment(vm)
                }
                .padding()
                .searchable(text: $search)
                .onSubmit(of: .search) {
                    searchPage = 1
                    isLoadingMore = false

                    Task {
                        do {
                            try await vm.searchUsers(
                                query: search,
                                page: searchPage
                            )
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationTitle("Developers")
            .background(.appBg)
            .navigationDestination(for: SearchDeveloper.self) { dev in
                DeveloperView(login: dev.login)
            }
        }
    }
}

private struct ClientsList: View {
    @Environment(\.isSearching) private var isSearching
    @Environment(GeneralVM.self) private var gvm
    @Environment(HomeVM.self) private var vm

    let search: String
    

    @Binding var searchPage: Int
    @Binding var isLoadingMore: Bool

    var body: some View {
        if isSearching {
            searchClients
        } else {
            savedClients
        }
    }

    @ViewBuilder
    private var searchClients: some View {
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
    
    @ViewBuilder
    private var savedClients: some View {
        
    }

    private func loadNextPage() {
        guard !isLoadingMore else { return }

        isLoadingMore = true
        searchPage += 1

        Task {
            do {
                try await vm.searchUsers(
                    query: search,
                    page: searchPage
                )
            } catch {
                print(error)
            }

            isLoadingMore = false
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
