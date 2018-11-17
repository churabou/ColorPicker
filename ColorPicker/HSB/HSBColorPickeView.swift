//
//  HSBColorPickeView.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

final class HSBColorPickerView: BaseView {
    
    weak var delegate: ColorPickerDelegate?
    private var hueSlider = HueSlider()
    private var svSquare = SaturationBrightnessPickerView()
    
    override func initializeView() {
        hueSlider.delegate = self
        svSquare.delegate = self
        addSubview(svSquare)
        addSubview(hueSlider)
    }
    
    override func initializeConstraints() {
        
        hueSlider.translatesAutoresizingMaskIntoConstraints = false
        svSquare.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hueSlider.heightAnchor.constraint(equalToConstant: 20),
            hueSlider.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            hueSlider.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            hueSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            svSquare.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            svSquare.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            svSquare.bottomAnchor.constraint(equalTo: hueSlider.topAnchor, constant: -10),
            svSquare.topAnchor.constraint(equalTo: topAnchor, constant: 10)
            ])
    }
    
    private var hue: CGFloat = 0 {
        didSet {
            svSquare.updateHue(hue)
        }
    }
}

extension HSBColorPickerView: HueSliderDelegate {
    
    func hueDidChange(_ hue: CGFloat) {
        self.hue = hue
    }
}

extension HSBColorPickerView: SaturationBrightnessPickerDelegate {
    
    func didPanPicker(_ saturation: CGFloat, _ brightness: CGFloat) {
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        svSquare.circleView.backgroundColor = color
        delegate?.didPickColor(color)
    }
}
