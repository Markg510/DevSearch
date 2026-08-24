//
//  SearchDeveloperItem.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct SearchDeveloperItem: View {
    let developer: SearchDeveloper
    
    var body: some View {
        HStack {
            avatar

            developerInfo

            Spacer()

            chevron
        }
        .padding()
        .background(.colorPrimary)
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: .white, radius: 0.5)
    }

    private var avatar: some View {
        Group {
            CustomImage(viewType: .urlAvailable(url: developer.pfpURL))
        }
        .frame(width: 44, height: 44)
        .clipShape(.rect(cornerRadius: 16))
        .padding(.trailing)
    }

    private var developerInfo: some View {
        VStack(alignment: .leading) {
            Text("@\(developer.login)")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)

            HStack(spacing: 0) {
                Text("#")
                Text(developer.id, format: .number)
            }
            .foregroundStyle(.textSecondary)
            .font(.footnote)
        }
    }

    private var chevron: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(.textSecondary)
    }
}

#Preview {
    let dummyDev = SearchDeveloper(
        id: 12232166,
        login: "TorvaldsDB",
        avatar_url: "https://avatars.githubusercontent.com/u/12232166?v=4",
        url: "https://api.github.com/users/TorvaldsDB",
        followers_url: "https://api.github.com/users/TorvaldsDB/followers",
        starred_url: "https://api.github.com/users/TorvaldsDB/starred%7B/owner%7D%7B/repo%7D",
        repos_url: "https://api.github.com/users/TorvaldsDB/repos"

    )
    
    SearchDeveloperItem(developer: dummyDev)
}
