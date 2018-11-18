//
//  SliderComponent.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit


final class SliderComponent: BaseView {
    
    weak var delegate: RGBSliderDelegate?
    
    // TODO: init
    var target: RGBComponent = .r {
        didSet {
            slider.thumbTintColor = target.color
            gradationLayer.colors = [UIColor.black, target.color].map { $0.cgColor }
        }
    }
    
    private var slider = UISlider()
    private var gradationLayer = CAGradientLayer()
    
    func updateGradation(colors: [CGColor]) {
        gradationLayer.colors = colors
        gradationLayer.locations = [0, NSNumber(value: slider.value), 1]
    }
    
    override func draw(_ rect: CGRect) {
        gradationLayer.frame = bounds.insetBy(dx: 4, dy: 23)
        gradationLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradationLayer.cornerRadius = 2
        gradationLayer.endPoint = CGPoint(x: 1, y: 0.5)
        slider.layer.insertSublayer(gradationLayer, at: 0)
        slider.frame = bounds
    }
    
    override func initializeView() {
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.addTarget(self, action: #selector(actionSlider), for: .valueChanged)
        addSubview(slider)
    }
    
    
    // output slider value
    @objc private func actionSlider(_ sender: UISlider) {
        //delegate
        delegate?.sliderValueChanged(target, value: CGFloat(sender.value))
    }
    
    // input from rgbview
    func updateSliderValue(to value: Float) {

        UIView.animate(withDuration: 0.2) {
            self.slider.setValue(value, animated: true)
        }
    }
}

