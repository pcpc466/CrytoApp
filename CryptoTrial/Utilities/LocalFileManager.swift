//
//  LocalFileManager.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/18/22.
//

import Foundation
import  SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init () {}
    
    // save image from the instance refrence
    func saveImage(image: UIImage, imageName: String, FolderName: String) {
        
        //create Folder
        createFolderIfNeeded(FolderName: FolderName)
        
        //get path for image
        guard let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, FolderName: FolderName)
              else { return }
        
       //save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving image\(error)")
        }
    }
    
    // get Image image from the instance refrence 
    func getImage (imageName: String, folderName: String) -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, FolderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(FolderName: String) {
        guard let url = getURLForFolder(Foldername: FolderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("error creeating the folder \(error)")
            }
        }
    }
    
    private func getURLForFolder(Foldername: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil
            
        }
        return url.appendingPathComponent(Foldername)
    }
    
    private func getURLForImage(imageName: String, FolderName: String) -> URL? {
       guard  let folderURL = getURLForFolder(Foldername: FolderName) else { return nil}
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
