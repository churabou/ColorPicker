//
//  RGBPickerView.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

final class RGBPickerView: BaseView {
    
    weak var delegate: ColorPickerDelegate?
    
    private var scroll = ColorScrollPicker()
    private var slider = RGBSlider()
    private var currentRGB = UIColor.RGB(r: 0, g: 0, b: 0) {
        didSet {
            slider.updateSliderColor(currentRGB)
            doneButton.backgroundColor = UIColor(rgb: currentRGB)
            delegate?.didPickColor(UIColor(rgb: currentRGB))
        }
    }
    
    private lazy var doneButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 30
        b.setTitle("適応", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(actionDone), for: .touchUpInside)
        b.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        b.layer.borderWidth = 2
        return b
    }()
    
    @objc private func actionDone() {
       delegate?.didPickColor(UIColor(rgb: currentRGB))
    }
    
    override func initializeView() {
        backgroundColor = .white
        scroll.delegate = self
        scroll.setColors(ColorScrollPicker.defaultColors)
        scroll.delegate = self
        slider.delegate = self
        addSubview(scroll)
        addSubview(slider)
        addSubview(doneButton)
    }
    
    override func initializeConstraints() {
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scroll.heightAnchor.constraint(equalToConstant: 50),
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.leftAnchor.constraint(equalTo: leftAnchor),
            scroll.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            slider.rightAnchor.constraint(equalTo: doneButton.leftAnchor, constant: -20),
            slider.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            slider.heightAnchor.constraint(equalToConstant: 150),
            slider.topAnchor.constraint(equalTo: scroll.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.widthAnchor.constraint(equalToConstant: 60),
            doneButton.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
            ])
    }
}


extension RGBPickerView: ColorPickerDelegate {
    
    func didPickColor(_ color: UIColor) {
        // update value then update color
        currentRGB = color.rgb
        slider.updateSliders(rgb: color.rgb)
    }
}

extension RGBPickerView: RGBSliderDelegate {
    
    func sliderValueChanged(_ target: RGBComponent, value: CGFloat) {
        switch target {
        case .r: currentRGB.r = value
        case .g: currentRGB.g = value
        case .b: currentRGB.b = value
        }
    }
}
