//
//  ColorPickerDelegate.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import Foundation
import UIKit.UIColor

protocol ColorPickerDelegate: class {
    func didPickColor(_ color: UIColor)
}
