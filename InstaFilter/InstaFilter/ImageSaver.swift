//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Cheng Liang(Louis) on 2022/10/27.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError eeor: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved")
    }
}
