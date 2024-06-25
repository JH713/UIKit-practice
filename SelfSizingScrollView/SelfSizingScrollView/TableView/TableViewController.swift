//
//  TableViewController.swift
//  SelfSizingScrollView
//
//  Created by 이지현 on 6/21/24.
//

import SnapKit
import UIKit

class TableViewController: UIViewController {
    var rowCount = 5
    
    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .init(red: 216/255, green: 239/255, blue: 211/255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var tableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
//        tableView.bounces = false
        return tableView
    }()
    
    private lazy var buttons = {
        let buttons = SizeControlButtons(title: "rows:")
        buttons.decreaseButton.addTarget(self, action: #selector(decreaseRow), for: .touchUpInside)
        buttons.increaseButton.addTarget(self, action: #selector(increaseRow), for: .touchUpInside)
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 149/255, green: 210/255, blue: 179/255, alpha: 1)
        
        setupLayout()
    }
    
    private func setupLayout() {
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        view.addSubview(containerView)
        view.addSubview(buttons)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualTo(buttons.snp.top).offset(-20)
        }
        
        buttons.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    @objc private func decreaseRow() {
        guard rowCount > 1 else { return }
        rowCount -= 1
        tableView.deleteRows(at: [IndexPath(row: rowCount, section: 0)], with: .automatic)
    }
    
    @objc private func increaseRow() {
        guard rowCount < 20 else { return }
        rowCount += 1
        let insertedIndexPath = IndexPath(row: rowCount - 1, section: 0)
        tableView.insertRows(at: [insertedIndexPath], with: .automatic)
        tableView.scrollToRow(at: insertedIndexPath, at: .bottom, animated: true)
    }
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .init(red: 216/255, green: 239/255, blue: 211/255, alpha: 1)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}
