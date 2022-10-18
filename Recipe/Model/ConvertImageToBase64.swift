//
//  ConvertImageToBase64.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/18.
//

import Foundation
import UIKit

func convertImageToBase64(_ image: UIImage) -> String? {
    guard let imageData = image.jpegData(compressionQuality: 1.0) else {return nil}
    return imageData.base64EncodedString()
}
