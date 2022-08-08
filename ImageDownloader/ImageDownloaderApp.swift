//
//  ImageDownloaderApp.swift
//  ImageDownloader
//
//  Created by Георгий Фесенко on 08/08/2022.
//

import SwiftUI

@main
struct ImageDownloaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
