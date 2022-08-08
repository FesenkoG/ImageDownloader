//
//  ContentView.swift
//  ImageDownloader
//
//  Created by Георгий Фесенко on 08/08/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
            viewModel.downloadImage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
