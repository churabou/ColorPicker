//
//  HueSlider.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

protocol HueSliderDelegate: class {
    func hueDidChange(_ hue: CGFloat)
}

final class HueSlider: UISlider {
    
    weak var delegate: HueSliderDelegate?
    
    private var gradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func setup() {
        gradientLayer.frame = bounds
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let c1 = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
        let c2 = UIColor(red: 255/255, green: 255/255, blue: 0, alpha: 1)
        let c3 = UIColor(red: 0, green: 255/255, blue: 0, alpha: 1)
        let c4 = UIColor(red: 0, green: 255/255, blue: 255/255, alpha: 1)
        let c5 = UIColor(red: 0, green: 0, blue: 255/255, alpha: 1)
        let c6 = UIColor(red: 255/255, green: 0, blue: 255/255, alpha: 1)
        let c7 = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
        
        gradientLayer.startPoint = .init(x: 0, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 0.5)
        gradientLayer.colors = [c1, c2, c3, c4, c5, c6, c7].map { $0.cgColor }
        layer.addSublayer(gradientLayer)
        
        addTarget(self, action: #selector(sliderDidUpdate), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sliderDidUpdate(_ sender: UISlider) {
        delegate?.hueDidChange(CGFloat(sender.value))
    }
}
