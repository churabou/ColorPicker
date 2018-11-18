//
//  SaturationBrightnessPickerView.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

protocol SaturationBrightnessPickerDelegate: class {
    func didPanPicker(_ saturation: CGFloat, _ brightness: CGFloat)
}

final class SaturationBrightnessPickerView: UIView {
    
    weak var delegate: SaturationBrightnessPickerDelegate?
    
    private (set) lazy var circleView: UIView = {
        let v = UIView()
        v.layer.borderWidth = 2
        v.bounds.size = CGSize(width: 20, height: 20)
        v.layer.cornerRadius = 10
        v.layer.borderColor = UIColor.white.cgColor
        v.backgroundColor = .clear
        return v
    }()
    
    private var saturationGradient = CAGradientLayer()
    private var brightnessGradient = CAGradientLayer()
    
    func updateHue(_ hue: CGFloat) {
        let c1 = UIColor(hue: hue, saturation: 0, brightness: 1, alpha: 1)
        let c2 = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
        saturationGradient.colors = [c1, c2].map { $0.cgColor }
    }
    
    override func draw(_ rect: CGRect) {
        saturationGradient.frame = bounds
        brightnessGradient.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let c1 = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)
        let c2 = UIColor(hue: 0, saturation: 1, brightness: 1, alpha: 1)
        saturationGradient.colors = [c1, c2].map { $0.cgColor }
        saturationGradient.startPoint = .init(x: 0, y: 0.5)
        saturationGradient.endPoint = .init(x: 1, y: 0.5)
        layer.addSublayer(saturationGradient)
        
        brightnessGradient.startPoint = .init(x: 0.5, y: 0)
        brightnessGradient.endPoint = .init(x: 0.5, y: 1)
        brightnessGradient.colors = [UIColor.clear, UIColor.black].map { $0.cgColor }
        layer.addSublayer(brightnessGradient)
        
        addGestureRecognizer(panGesture)
        addSubview(circleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(actionPan))
    
    @objc private func actionPan(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: self)

        if !bounds.contains(location) {
            return
        }

        let saturation = location.x / bounds.width
        let brightness = 1 - (location.y / bounds.height)

        circleView.center = location
        delegate?.didPanPicker(saturation, brightness)
    }
}

