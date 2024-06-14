//
//  ViewController.swift
//  UIDatePickerPractice
//
//  Created by 이지현 on 6/14/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var datePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.minuteInterval = 5
        picker.locale = Locale(identifier: "ko_KR")
        picker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var dateLabel = {
        let label = UILabel()
        label.text = convertToString(date: datePicker.date)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func convertToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a h:mm"
        return dateFormatter.string(from: date)
    }
    
    @objc private func timeChanged(sender: UIDatePicker) {
        dateLabel.text = convertToString(date: sender.date)
    }


}

