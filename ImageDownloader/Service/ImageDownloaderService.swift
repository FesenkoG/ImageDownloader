//
//  ImageDownloaderService.swift
//  ImageDownloader
//
//  Created by Георгий Фесенко on 08/08/2022.
//

import Foundation
import UIKit

enum CustomError: Error {
    case cantParseAnImage
    case cantDownloadAnImage
}

protocol ImageDownloaderServiceProtocol {
    @discardableResult
    func downloadImage(
        _ url: URL,
        completion: @escaping (Result<UIImage, CustomError>) -> Void
    ) -> Cancellable
}

typealias ImageDownloadingCompletion = (Result<UIImage, CustomError>) -> Void

final class ImageDownloaderService: ImageDownloaderServiceProtocol {
    private var operationsInProgress: [URL: ImageDownloadingOperation] = [:]
    private var completionsToCall: [URL: [ImageDownloadingCompletion]] = [:]
    
    private let operationQueue = OperationQueue()
    
    func downloadImage(
        _ url: URL,
        completion: @escaping ImageDownloadingCompletion
    ) -> Cancellable {
        if let currentOperation = operationsInProgress[url] {
            completionsToCall[url]?.append(completion)
            return currentOperation
        }
        
        completionsToCall[url] = [completion]
        
        let operation = ImageDownloadingOperation(imageURL: url)
        self.operationsInProgress[url] = operation
        
        operation.completionBlock = { [weak self] in
            self?.operationsInProgress[url] = nil
            
            DispatchQueue.main.async {
                guard let result = operation.downloadedImage else {
                    return completion(.failure(.cantDownloadAnImage))
                }
                
                self?.completionsToCall[url]?.forEach { $0(result) }
                self?.completionsToCall[url] = nil
            }
        }
        
        operationQueue.addOperation(operation)
        
        return operation
    }
}
