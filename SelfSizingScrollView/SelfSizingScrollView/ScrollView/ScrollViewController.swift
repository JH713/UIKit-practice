//
//  ScrollViewController.swift
//  SelfSizingScrollView
//
//  Created by 이지현 on 6/21/24.
//

import UIKit

class ScrollViewController: UIViewController {
    
    var contentWidth: CGFloat = 200 {
        didSet {
            contentWidthConstraint?.isActive = false
            contentWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: contentWidth)
            contentWidthConstraint?.isActive = true
        }
    }
    var contentHeight: CGFloat = 200 {
        didSet {
            contentHeightConstraint?.isActive = false
            contentHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentHeight)
            contentHeightConstraint?.isActive = true
        }
    }
    var contentWidthConstraint:NSLayoutConstraint?
    var contentHeightConstraint:NSLayoutConstraint?
    
    private lazy var scrollView = {
        let scrollView = SelfSizingScrollView()
        scrollView.backgroundColor = .systemGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var trailingLabel = {
        let label = UILabel()
        label.text = "끝입니다"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(widthButtons)
        stackView.addArrangedSubview(heightButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var widthButtons = {
        let buttons = SizeControlButtons(title: "width:")
        buttons.decreaseButton.addTarget(self, action: #selector(decreaseWidth), for: .touchUpInside)
        buttons.increaseButton.addTarget(self, action: #selector(increaseWidth), for: .touchUpInside)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        return buttons
    }()
    
    private lazy var heightButtons = {
        let buttons = SizeControlButtons(title: "height:")
        buttons.decreaseButton.addTarget(self, action: #selector(decreaseHeight), for: .touchUpInside)
        buttons.increaseButton.addTarget(self, action: #selector(increaseHeight), for: .touchUpInside)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        scrollView.addSubview(contentView)
        contentWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: contentWidth)
        contentHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentHeight)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentWidthConstraint!,
            contentHeightConstraint!
        ])
        
        scrollView.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            buttonStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
        scrollView.addSubview(trailingLabel)
        NSLayoutConstraint.activate([
            trailingLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            trailingLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            trailingLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func decreaseWidth() {
        guard contentWidth > 100 else { return }
        contentWidth -= 100
    }
    
    @objc private func increaseWidth() {
        guard contentWidth < 1000 else { return }
        contentWidth += 100
    }
    
    @objc private func decreaseHeight() {
        guard contentHeight > 100 else { return }
        contentHeight -= 100
    }
    
    @objc private func increaseHeight() {
        guard contentHeight < 1000 else { return }
        contentHeight += 100
    }
    
}
