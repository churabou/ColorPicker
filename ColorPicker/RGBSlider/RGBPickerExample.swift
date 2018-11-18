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
        return l
    }()
    
    private lazy var picker: RGBPickerView = {
        let p = RGBPickerView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.delegate = self
        return p
    }()
    
    override func viewDidLoad() {
        
        view.addSubview(picker)
        view.addSubview(hexLabel)
    
        NSLayoutConstraint.activate([
            hexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hexLabel.heightAnchor.constraint(equalToConstant: 30),
            hexLabel.widthAnchor.constraint(equalToConstant: 200),
            ])
        
        NSLayoutConstraint.activate([
            picker.leftAnchor.constraint(equalTo: view.leftAnchor),
            picker.rightAnchor.constraint(equalTo: view.rightAnchor),
            picker.heightAnchor.constraint(equalToConstant: 230),
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
