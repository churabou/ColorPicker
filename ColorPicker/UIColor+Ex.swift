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
    
    typealias RGBA = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    
    var rgba: RGBA {
        if let component = cgColor.components {
             return (r: component[0],
                     g: component[component.count == 2 ? 0 : 1],
                     b: component[component.count == 2 ? 0 : 2],
                     a: component[component.count == 2 ? 1 : 3])
        }
        return (r: 0, g: 0, b: 0, a: 0)
    }
}

extension UIColor {
    
    func hexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06X", rgb)
    }

    var saturation: CGFloat {
        var saturation: CGFloat = 0
        getHue(nil, saturation: &saturation, brightness: nil, alpha: nil)
        return saturation
    }
    
    var brightness: CGFloat {
        var brightness: CGFloat = 0
        getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
        return brightness
    }
    
    func updateHue(_ hue: CGFloat) -> UIColor {
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}

