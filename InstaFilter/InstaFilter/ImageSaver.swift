//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Cheng Liang(Louis) on 2022/10/27.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: ( () -> Void )?
    var errorHandler: ( (Error) -> Void )?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved")
        
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
        
    }
}
