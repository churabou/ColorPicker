//
//  HSVColorPicker.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/17.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

final class HSBColorPickerExample: UIViewController {
    
    private lazy var pickedColorView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        return v
    }()
    
    private var hexLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = .boldSystemFont(ofSize: 18)
        return l
    }()

    private lazy var picker: HSBColorPickerView = {
        let p = HSBColorPickerView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.delegate = self
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(pickedColorView)
        view.addSubview(hexLabel)
        view.addSubview(picker)
        initializeConstraints()
    }
    
    func initializeConstraints() {
        
        NSLayoutConstraint.activate([
            pickedColorView.heightAnchor.constraint(equalToConstant: 40),
            pickedColorView.widthAnchor.constraint(equalToConstant: 40),
            pickedColorView.leftAnchor.constraint(equalTo: picker.leftAnchor, constant: 20),
            pickedColorView.bottomAnchor.constraint(equalTo: picker.topAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            hexLabel.heightAnchor.constraint(equalToConstant: 40),
            hexLabel.rightAnchor.constraint(equalTo: picker.rightAnchor, constant: -20),
            hexLabel.leftAnchor.constraint(equalTo: pickedColorView.rightAnchor, constant: 20),
            hexLabel.bottomAnchor.constraint(equalTo: picker.topAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            picker.heightAnchor.constraint(equalToConstant: 300),
            picker.leftAnchor.constraint(equalTo: view.leftAnchor),
            picker.rightAnchor.constraint(equalTo: view.rightAnchor),
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            ])
    }
}

extension HSBColorPickerExample: ColorPickerDelegate {
    
    func didPickColor(_ color: UIColor) {
        pickedColorView.backgroundColor = color
        hexLabel.text = color.hexString()
    }
}

