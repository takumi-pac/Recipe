//
//  ConvertBase64ToImage.swift
//  Recipe
//
//  Created by 松田拓海 on 2022/10/18.
//

import Foundation
import UIKit

func convertBase64ToImage(_ base64String: String) -> UIImage? {
    guard let imageData = Data(base64Encoded: base64String) else { return nil}
    return UIImage(data: imageData)
}
