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
    @State private var viewMode: ViewMode = .success
    
    // Swift Data Properties
    @Environment(\.modelContext) private var modelContext
    @Query private var cachedDevelopers: [CachedDeveloper]

    var body: some View {
        NavigationStack(path: $gvm.path) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    viewMode.errorView
                    ClientsList(
                        viewMode: $viewMode,
                        searchPage: $searchPage,
                        isLoadingMore: $isLoadingMore,
                        search: search
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
                handleFetchingUsers()
            }
            .navigationTitle("DevSearch")
            .background(.appBg)
            .navigationDestination(for: SearchDeveloper.self) { dev in
                DeveloperView(login: dev.login)
            }
            .onChange(of: vm.searchResults) { _, newResults in
                cacheDevelopers(newResults)
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
            viewMode = .failure(error: PersistenceError.saveFailed)
        }
    }
    
    private func handleFetchingUsers() {
        Task {
            searchPage = 1
            isLoadingMore = false

            do {
                try modelContext.delete(model: CachedDeveloper.self)
                try modelContext.save()
            } catch {
                viewMode = .failure(error: PersistenceError.deleteFailed)
                return
            }

            do {
                viewMode = .loading(label: "Fetching Users")

                try await vm.searchUsers(
                    query: search,
                    page: searchPage
                )

                viewMode = .success
            } catch {
                viewMode = .failure(error: error)
            }
        }
    }
}



#Preview {
    NavigationStack {
        HomeView()
    }
}
