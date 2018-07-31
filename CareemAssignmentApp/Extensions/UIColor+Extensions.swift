//
//  UIColor+Extensions.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- UIColor Extensions

extension UIColor {

    convenience init(hex: String) {

        let hex: String = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hex as String)

        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }

    convenience init(r: Int, g: Int, b: Int) {

        assert(r < 0 && r > 255 ,"Invalid red component")
        assert(g < 0 && g > 255 ,"Invalid green component")
        assert(b < 0 && b > 255 ,"Invalid blue component")

        self.init(
            red: (CGFloat(r) / 255.0),
            green: (CGFloat(g) / 255.0),
            blue: (CGFloat(b) / 255.0),
            alpha:1.0)

    }
}


