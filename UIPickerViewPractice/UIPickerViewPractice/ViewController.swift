//
//  ViewController.swift
//  UIPickerViewPractice
//
//  Created by 이지현 on 6/14/24.
//

import UIKit

class ViewController: UIViewController {
    
    let timeUnit = ["시간", "일", "주"]
    
    var timeNum = 1
    var unit = "시간"
    
    private lazy var timePicker = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var timeLabel = {
        let label = UILabel()
        label.text = "\(timeNum) \(unit) 이후"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(timePicker)
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    

}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            30
        } else {
            timeUnit.count
        }
    }
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            String(row + 1)
        } else {
            timeUnit[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        70
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            timeNum = row + 1
        } else {
            unit = timeUnit[row]
        }
        timeLabel.text = "\(timeNum) \(unit) 이후"
    }
}

