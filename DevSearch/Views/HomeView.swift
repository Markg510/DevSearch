//
//  HomeView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    // View Properties
    @State private var gvm = GeneralVM()
    @State private var vm = HomeVM()
    @State private var showSettingsSheet = false
    @State private var search = ""
    @State private var searchPage = 1
    @State private var isLoadingMore = false
    @State private var isFirstLaunch = true
    
    // Swift Data Properties
    @Environment(\.modelContext) private var modelContext
    @Query private var cachedDevelopers: [CachedDeveloper]

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
            }
            .searchable(
                text: $search,
                placement: .navigationBarDrawer(displayMode: .automatic)
            )
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
            .navigationTitle("DevSearch")
            .background(.appBg)
            .navigationDestination(for: SearchDeveloper.self) { dev in
                DeveloperView(login: dev.login)
            }
            .onChange(of: vm.searchResults) { _, newResults in
                cacheDevelopers(newResults)
                print(cachedDevelopers.count)
            }
            
        }.overlay {
            if isFirstLaunch {
                LaunchView()
            }
        }.onAppear {
            if isFirstLaunch {
                Task {
                    try await Task.sleep(nanoseconds: 3_500_000_000)
                    withAnimation {
                        isFirstLaunch = false
                    }
                }
            }
        }

    }
    
    // Preserving Data
    private func cacheDevelopers(_ developers: [SearchDeveloper]) {
        do {
            for developer in developers {
                let id = developer.id

                let descriptor = FetchDescriptor<CachedDeveloper>(
                    predicate: #Predicate {
                        $0.id == id
                    }
                )

                guard try modelContext.fetchCount(descriptor) == 0 else {
                    continue
                }

                modelContext.insert(
                    CachedDeveloper(
                        id: developer.id,
                        avatarURL: developer.avatar_url,
                        login: developer.login
                    )
                )
            }

            try modelContext.save()
        } catch {
            print("Failed to cache developers:", error)
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
