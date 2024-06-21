//
//  SizeControlButtons.swift
//  SelfSizingScrollView
//
//  Created by 이지현 on 6/21/24.
//

import UIKit

class SizeControlButtons: UIStackView {
    let title: String
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var decreaseButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "minus")
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var increaseButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "plus")
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 10
        addArrangedSubview(titleLabel)
        addArrangedSubview(decreaseButton)
        addArrangedSubview(increaseButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
