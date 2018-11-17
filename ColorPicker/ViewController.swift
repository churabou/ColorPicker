//
//  ViewController.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var squer = SaturationBrightnessPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hueSlier = HueSlider()
        hueSlier.bounds.size.width = view.bounds.width-80
        hueSlier.bounds.size.height = 20
        hueSlier.center = view.center
        hueSlier.center.y += 200
        hueSlier.setup()
        hueSlier.delegate = self
        view.addSubview(hueSlier)
        
        view.addSubview(squer)
        squer.updateHue(0)
        squer.delegate = self
        squer.frame = view.frame.insetBy(dx: 40, dy: 300)
        squer.setUp()
    }
}

extension ViewController: HueSliderDelegate, SaturationBrightnessPickerDelegate {
    
    func hueDidChange(_ hue: CGFloat) {
        squer.updateHue(hue)
    }
    
    func didUpdateColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
