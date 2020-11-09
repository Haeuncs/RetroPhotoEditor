//
//  UIImage+.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/09.
//

import UIKit

extension UIImage.Orientation {
    var exifOrientation: Int32 {
        switch self {
        case .up: return 1
        case .down: return 3
        case .left: return 8
        case .right: return 6
        case .upMirrored: return 2
        case .downMirrored: return 4
        case .leftMirrored: return 5
        case .rightMirrored: return 7
        @unknown default:
            return 0
        }
    }
}
