//
//  SettingsView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct SettingsView: View {
    // View Properties
    @AppStorage("homeContent") private var homeContent: HomeContent = .featured
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            
            viewItems
            
            Spacer()
        }.padding()
            .background(.appBg)
            .navigationTitle("Settings")
    }
    
    @ViewBuilder
    private var header: some View {
        Text("Settings")
            .font(.title)
            .foregroundStyle(.textPrimary)
            .fontWeight(.bold)
        
        Text("Choose what shows on your home screen")
            .foregroundStyle(.textSecondary)
            .font(.footnote)
            .padding(.bottom)
    }
    
    @ViewBuilder
    private var viewItems: some View {
        contentType(.featured)
        contentType(.bookmarked)
        contentType(.previousResults)
    }
    
    private func contentType(_ type: HomeContent) -> some View {
        Button {
            withAnimation {
                homeContent = type
            }
        } label: {
            let isSelected = homeContent == type
            HStack {
                Image(systemName: type.icon)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .symbolRenderingMode(.multicolor)
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(type.title)
                        .foregroundStyle(.textPrimary)
                        .fontWeight(.bold)
                    
                    Text(type.description)
                        .foregroundStyle(.textSecondary)
                        .font(.footnote)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.textSecondary)
                }
            }.padding()
                .background(isSelected ? .appBlue.opacity(0.1) : .colorPrimary)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(color: .white, radius: 1)
        }
    }
}

#Preview {
    SettingsView()
}
