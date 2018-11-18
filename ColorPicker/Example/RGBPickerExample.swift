//
//  RGBPickerExample.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

final class RGBPickerExample: UIViewController {

    private lazy var hexLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textAlignment = .center
        l.font = .boldSystemFont(ofSize: 18)
        view.addSubview(l)
        return l
    }()
    
    private lazy var picker: RGBPickerView = {
        let p = RGBPickerView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.delegate = self
        view.addSubview(p)
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NSLayoutConstraint.activate([
            hexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            hexLabel.heightAnchor.constraint(equalToConstant: 30),
            hexLabel.widthAnchor.constraint(equalToConstant: 200),
            ])
        
        NSLayoutConstraint.activate([
            picker.leftAnchor.constraint(equalTo: view.leftAnchor),
            picker.rightAnchor.constraint(equalTo: view.rightAnchor),
            picker.heightAnchor.constraint(equalToConstant: 215),
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}


extension RGBPickerExample: ColorPickerDelegate {
    
    func didPickColor(_ color: UIColor) {
        view.backgroundColor = color
        hexLabel.text = color.rgbString()
    }
}

private extension UIColor {
    
    func rgbString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return "R: \( (Int)(r*255))  G: \( (Int)(g*255))  B \( (Int)(b*255))"
    }
}
