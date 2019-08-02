//
//  imageSaverClass.swift
//  Pods-Swifty_Note
//
//  Created by user on 8/2/19.
//
import UIKit
import Foundation
class imageSaver{
    //static let shared = ImageController()
    
    static let fileManager = FileManager.default
    static let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static func saveImage(imageObject: UIImage?) -> String? {
        if let image = imageObject{
        let date = String( Date.timeIntervalSinceReferenceDate )
        let imageName = date.replacingOccurrences(of: ".", with: "-") + ".png"
        
        if let imageData = image.pngData() {
            do {
                let filePath = documentsPath.appendingPathComponent(imageName)
                
                try imageData.write(to: filePath)
                
                print("\(imageName) was saved.")
                
                return imageName
            } catch let error as NSError {
                print("\(imageName) could not be saved: \(error)")
                
                return nil
            }
            
        } else {
            print("Could not convert UIImage to png data.")
            
            return nil
        }
        }
        else {
            return ""
        }
    }
    
    static func fetchImage(imageName: String) -> UIImage? {
        let imagePath = documentsPath.appendingPathComponent(imageName).path
        
        guard fileManager.fileExists(atPath: imagePath) else {
            print("Image does not exist at path: \(imagePath)")
            
            return nil
        }
        
        if let imageData = UIImage(contentsOfFile: imagePath) {
            return imageData
        } else {
            print("UIImage could not be created.")
            
            return nil
        }
    }
    static func deleteImage(imageName: String) {
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        guard fileManager.fileExists(atPath: imagePath.path) else {
            print("Image does not exist at path: \(imagePath)")
            
            return
        }
        
        do {
            try fileManager.removeItem(at: imagePath)
            
            print("\(imageName) was deleted.")
        } catch let error as NSError {
            print("Could not delete \(imageName): \(error)")
        }
    }
    
}
