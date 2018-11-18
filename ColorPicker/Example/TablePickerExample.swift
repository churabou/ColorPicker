//
//  ColorPickTableView.swift
//  ColorPicker
//
//  Created by chutatsu on 2018/11/18.
//  Copyright © 2018 churabou. All rights reserved.
//

import UIKit

final class TablePickerExample: UIViewController {

    private var saturationSlider = UISlider()
    private var brightnessSlider = UISlider()
    private var tableView = UITableView()

    private var saturation: CGFloat = 1 {
        didSet {
            tableView.reloadData()
        }
    }

    private var brightness: CGFloat = 1 {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        saturationSlider.frame = .init(x: 20, y: 50, width: view.bounds.width/2-40, height: 30)
        saturationSlider.addTarget(self, action: #selector(actionSlider), for: .valueChanged)
        view.addSubview(saturationSlider)

        brightnessSlider.frame = .init(x: view.bounds.width/2+20, y: 50, width: view.bounds.width/2-40, height: 30)
        brightnessSlider.addTarget(self, action: #selector(actionSlider), for: .valueChanged)
        view.addSubview(brightnessSlider)

        tableView.frame = view.bounds.insetBy(dx: 0, dy: 100)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    @objc private func actionSlider(_ sender: UISlider) {
        
        if sender === saturationSlider {
             saturation = CGFloat(sender.value)
        } else if sender === brightnessSlider {
            brightness = CGFloat(sender.value)
        }
    }
}

extension TablePickerExample: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.backgroundColor = UIColor(hue: CGFloat(indexPath.row) / 120, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

extension TablePickerExample: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let color = UIColor(hue: CGFloat(indexPath.row) / 120, saturation: saturation, brightness: brightness, alpha: 1)
        cell.contentView.backgroundColor = color
        cell.textLabel?.text = color.hexString()
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
}

