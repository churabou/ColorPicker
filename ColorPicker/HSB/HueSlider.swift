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
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let red: [CGFloat] = [1, 1, 0, 0, 0, 1, 1]
        let green: [CGFloat]  = [0, 1, 1, 1, 0, 0, 0]
        let blue: [CGFloat]  = [0, 0, 0, 1, 1, 1, 0]

        gradientLayer.startPoint = .init(x: 0, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 0.5)
        gradientLayer.colors = (0..<7).map {
            UIColor(red: red[$0],
                    green: green[$0],
                    blue: blue[$0],
                    alpha: 1)
                .cgColor
        }
        layer.addSublayer(gradientLayer)
        addTarget(self, action: #selector(sliderDidUpdate), for: .valueChanged)

        maximumTrackTintColor = .clear
        minimumTrackTintColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sliderDidUpdate(_ sender: UISlider) {
        delegate?.hueDidChange(CGFloat(sender.value))
    }
}
