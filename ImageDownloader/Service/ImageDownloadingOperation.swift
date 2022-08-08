//
//  ImageDownloadingOperation.swift
//  ImageDownloader
//
//  Created by Георгий Фесенко on 08/08/2022.
//

import Foundation
import UIKit

final class ImageDownloadingOperation: Operation, Cancellable {
    private let imageURL: URL
    private(set) var downloadedImage: Result<UIImage, CustomError>?
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    override func main() {
        guard !isCancelled else {
            return
        }
        
        guard let imageData = try? Data(contentsOf: imageURL),
            let image = UIImage(data: imageData) else {
                self.downloadedImage = .failure(.cantParseAnImage)
                return
            }
        self.downloadedImage = .success(image)
    }
}
