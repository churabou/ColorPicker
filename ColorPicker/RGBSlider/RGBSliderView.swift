//
//  RGBSliderView.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit


enum RGBComponent {
    case r, g, b
    
    var color: UIColor {
        switch self {
        case .r: return .red
        case .g: return .green
        case .b: return .blue
        }
    }
}

protocol RGBSliderDelegate: class {
    func sliderValueChanged(_ target: RGBComponent, value: CGFloat)
}

final class RGBSlider: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: RGBSliderDelegate? {
        didSet {
            sliders.forEach { $0.delegate = delegate }
        }
    }
    
    private var sliders: [SliderComponent] = []
    
    func initializeView() {
        distribution = .fillProportionally
        axis = .vertical
        
        let colors: [RGBComponent] = [.r, .g, .b]
        colors.forEach { color in
            let slider = SliderComponent()
            slider.target = color
            slider.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(slider)
            sliders.append(slider)
        }
    }
    
    //全部のメモリを合わせる
    func updateSliders(rgb: UIColor.RGB) {
        
        sliders.forEach { slider in
            switch slider.target {
            case .r: slider.updateSliderValue(to: Float(rgb.r))
            case .g: slider.updateSliderValue(to: Float(rgb.g))
            case .b: slider.updateSliderValue(to: Float(rgb.b))
            }
        }
    }
    
    //色を合わせる
    func updateSliderColor(_ rgb: UIColor.RGB) {

        sliders.forEach { slider in

            let target = slider.target

            let minimumColor: UIColor = UIColor(red: target == .r ? 0 : rgb.r ,
                                                green: target == .g ? 0 : rgb.g,
                                                blue: target == .b ? 0 : rgb.b,
                                                alpha: 1)


            let maximumColor: UIColor = UIColor(red: target == .r ? 1 : rgb.r ,
                                                green: target == .g ? 1 : rgb.g,
                                                blue: target == .b ? 1 : rgb.b,
                                                alpha: 1)


            let colors = [minimumColor.cgColor, UIColor(rgb: rgb).cgColor, maximumColor.cgColor]
            slider.updateGradation(colors: colors)
        }
    }
}



