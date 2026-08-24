//
//  CustomImage.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import SwiftUI
import NukeUI

struct CustomImage: View {
    enum CustomImageTypes {
        case urlAvailable(url: URL)
        case uiImageAvailable(uiImage: UIImage)
        case loadingURL, failure, notFound
    }
    
    // Passed Properties
    let viewType: CustomImageTypes
    var aspectRatio: ContentMode = .fill

    var body: some View {
        switch viewType {
        case .uiImageAvailable(uiImage: let uiImg):
            Image(uiImage: uiImg)
                .resizable()
                .aspectRatio(contentMode: aspectRatio)
        case .urlAvailable(let url):
            LazyImage(url: url) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                } else if state.error != nil {
                    Image(systemName: "photo.badge.exclamationmark")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.colorPrimary)
                } else {
                    LoadingView(.rect(cornerRadius: 16))
                }
            }
        case .loadingURL:
            LoadingView(.rect(cornerRadius: 16))
        case .failure:
            Color.colorPrimary
        case .notFound:
            Image(.personPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.colorPrimary)
        }
    }
}

#Preview {
    CustomImage(viewType: .failure, aspectRatio: .fill)
}
