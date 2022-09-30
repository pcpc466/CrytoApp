//
//  CoinImageService.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin : CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = " coin_Image"
    private let imageName: String
    
    init (coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if
            let savedImage =
                fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retreived Image from File ")
        } else {
            downlaodCoinImage()
            print("Downloading image")
        }
    }
    
    private func downlaodCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
           
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self ,let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, FolderName: self.folderName)
            })
    }
}
