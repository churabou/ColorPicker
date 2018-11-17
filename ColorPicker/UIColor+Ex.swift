//
//  UIColor+Ex.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func hex(hexStr: String) -> UIColor{
        let scanner = Scanner(string: hexStr.replacingOccurrences(of: "#", with: ""))
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        } else {
            return .black
        }
    }
}

// https://developer.apple.com/documentation/swift/uint32/2893096

extension UIColor {
    
    typealias RGB = (r: CGFloat, g: CGFloat, b: CGFloat)
    
    var rgb: RGB {
        if let component = cgColor.components {
            if component.count == 2 {
                return (r: component[0], g: component[0], b: component[0])
            }
            return (r: component[0], g: component[1], b: component[2])
        }
        return (r: 0, g: 0, b: 0)
    }
}

