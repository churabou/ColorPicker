//
//  HSVGridColorPicker.swift
//  ColorPicker
//
//  Created by chutatsu on 2019/01/11.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

final class HSBGridColorPickerView: BaseView {
    
    weak var delegate: ColorPickerDelegate?
    private var hueSlider = HueSlider()
    private var svSquare = SVCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func initializeView() {
        hueSlider.delegate = self
        addSubview(hueSlider)
        addSubview(svSquare)
    }
    
    override func initializeConstraints() {
        
        hueSlider.translatesAutoresizingMaskIntoConstraints = false
        svSquare.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hueSlider.heightAnchor.constraint(equalToConstant: 20),
            hueSlider.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            hueSlider.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            hueSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
        
        NSLayoutConstraint.activate([
            svSquare.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            svSquare.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            svSquare.bottomAnchor.constraint(equalTo: hueSlider.topAnchor, constant: -10),
            svSquare.topAnchor.constraint(equalTo: topAnchor, constant: 10)
            ])
    }
    
    private var hue: CGFloat = 0 {
        didSet {
            svSquare.updateHue(hue)
        }
    }
}

extension HSBGridColorPickerView: HueSliderDelegate {
    
    func hueDidChange(_ hue: CGFloat) {
        self.hue = hue
    }
}


final class SVCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        delegate = self
        dataSource = self
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private var col = 6
    private var row = 8
    
    private var hue: CGFloat = 0 {
        didSet {
            visibleCells.forEach { cell in
                guard let indexPath = self.indexPath(for: cell) else { return }
                let saturation = CGFloat(col - (indexPath.row) % col) / CGFloat(col)
                let brightness = CGFloat(row - Int(indexPath.row / col)) / CGFloat(row)
                cell.contentView.backgroundColor = UIColor(hue: hue, saturation: 1-saturation, brightness: brightness, alpha: 1)
            }
        }
    }
    
    func updateHue(_ hue: CGFloat) {
        self.hue = hue
    }
}

extension SVCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return col * row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let saturation = CGFloat(col - (indexPath.row) % col) / CGFloat(col)
        let brightness = CGFloat(row - Int(indexPath.row / col)) / CGFloat(row)
        cell.contentView.backgroundColor = UIColor(hue: hue, saturation: 1-saturation, brightness: brightness, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        delegate?.didTapCell(at: indexPath.row)
    }
}

extension SVCollectionView: UICollectionViewDelegateFlowLayout {
    
    private var margin: CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (bounds.width-margin) / CGFloat(col)
        let height = (bounds.height-margin) / CGFloat(row)
        return CGSize(width: width-margin, height: height-margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
}
