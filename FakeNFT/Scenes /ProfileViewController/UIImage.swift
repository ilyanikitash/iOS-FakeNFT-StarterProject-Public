//
//  UIImage.swift
//  FakeNFT
//
//  Created by Давид Бекоев on 23.03.2025.
//

import UIKit

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
