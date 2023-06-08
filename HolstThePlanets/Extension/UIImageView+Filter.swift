//
//  UIImage+Filter.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import UIKit

extension UIImageView {
    func filter(filterName: String = "CIPhotoEffectNoir") -> UIImage? {
        guard let image = self.image else {
            return nil
        }
        
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: filterName) {
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}
