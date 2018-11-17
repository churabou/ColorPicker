//
//  SaturationBrightnessPickerView.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

protocol SaturationBrightnessPickerDelegate: class {
    func didUpdateColor(_ color: UIColor)
}

final class SaturationBrightnessPickerView: UIView {
    
    private var saturationGradient = CAGradientLayer()
    private var brightnessGradient = CAGradientLayer()
    private var hue: CGFloat = 0
    
    func updateHue(_ hue: CGFloat) {
        self.hue = hue
        let c1 = UIColor(hue: hue, saturation: 0, brightness: 1, alpha: 1)
        let c2 = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
        saturationGradient.colors = [c1, c2].map { $0.cgColor }
    }
    
    func setUp() {
        saturationGradient.frame = bounds
        brightnessGradient.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        saturationGradient.startPoint = .init(x: 0, y: 0.5)
        saturationGradient.endPoint = .init(x: 1, y: 0.5)
        layer.addSublayer(saturationGradient)
        
        brightnessGradient.startPoint = .init(x: 0.5, y: 0)
        brightnessGradient.endPoint = .init(x: 0.5, y: 1)
        brightnessGradient.colors = [UIColor.clear, UIColor.black].map { $0.cgColor }
        layer.addSublayer(brightnessGradient)
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(actionPan))
    
    
    
    @objc private func actionPan(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: self)
        
        let saturation = location.x / bounds.width
        let brightness = 1 - (location.y / bounds.height)
        
        
        
        let color = UIColor.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        
        delegate?.didUpdateColor(color)
        print(saturation, brightness)
        
    }
    
    weak var delegate: SaturationBrightnessPickerDelegate?
}

