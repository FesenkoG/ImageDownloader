//
//  ContentViewModel.swift
//  ImageDownloader
//
//  Created by Георгий Фесенко on 08/08/2022.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var image: UIImage = UIImage()
    private let imageDownloader: ImageDownloaderServiceProtocol
    
    init(imageDownloader: ImageDownloaderServiceProtocol = ImageDownloaderService()) {
        self.imageDownloader = imageDownloader
    }
    
    func downloadImage() {
        imageDownloader.downloadImage(
            URL(
                string: "https://images.unsplash.com/photo-1659780735025-2e69c7e0c556?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1790&q=80"
            )!
        ) { result in
            switch result {
            case .success(let image):
                self.image = image
            case .failure:
                self.image = UIImage()
            }
        }
    }
    
}
