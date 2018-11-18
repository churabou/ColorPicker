//
//  ColorScrollPicker.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

// カラフルなボタンをsrcollViewに並べるクラス
final class ColorScrollPicker: BaseView {
    
    weak var delegate: ColorPickerDelegate?
    
    private let buttonS: CGFloat = 30
    private let margin: CGFloat = 10
    private let heihgt: CGFloat = 50 // このクラスは高さ50で表示されるように設計されています。
    private var scrollView = UIScrollView()
    
    override func initializeView() {
        backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            ])
    }
    
    @objc private func actionButton(_ seneder: UIButton) {
        delegate?.didPickColor(seneder.backgroundColor!)
    }
    
    
    func setColors(_ colors: [UIColor]) {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        scrollView.contentSize = CGSize(width: (margin+buttonS)*CGFloat(colors.count)+margin, height: heihgt)
        colors.enumerated().forEach { index, color in
            let b = UIButton()
            b.backgroundColor = color
            b.layer.cornerRadius = buttonS / 2
            b.bounds.size = CGSize(width: buttonS, height: buttonS)
            b.frame.origin = CGPoint(x: margin+(margin+buttonS)*CGFloat(index), y: margin)
            b.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
            scrollView.addSubview(b)
        }
    }
    
    static var defaultColors: [UIColor] = [
        //昔作ったやつ。ボールペンの色みたいで好み
        "#ff99cc","#A7F1FF" ,"#9BF9CC" ,"#D0B0FF",
        //パステルカラーのWEBから抜いた色。黄色だけ抜いた。
        "#ffbf7f", "#bfff7f", "#7fffbf", "#7fffff", "#7fbfff", "#7f7fff", "#bf7fff", "#ff7fff",
        
        //ビビッとカラーってやつから抜いた
        "#ff007f", "#ff00ff", "#7f00ff", "#0000ff", "#007fff", "#00ffff", "#00F2B6", "#00ff00",  "#ff7f00",
        //Mixクリップから抜いた色 + orangeが茶色っぽいので修正
        //    "#ffc247", "EDE87A", "C5EC78", "8CEBCF", "72A1E8", "7068E6", "9F6CE6", "DE6FA8", "DE746B", "CDA185", "B4B4B4"
        "#F20000", "#191919", "#E6E6E6" //赤白黒
        ].map { UIColor.hex(hexStr: $0) }
}



