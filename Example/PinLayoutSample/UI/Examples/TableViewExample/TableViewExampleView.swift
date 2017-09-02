//
//  TableViewExampleView.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-13.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class TableViewExampleView: BaseView {

    fileprivate let tableView = UITableView()
    fileprivate let methodCellTemplate = MethodCell()
    
    fileprivate var methods: [Method] = []
    
    override init() {
        super.init()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(MethodCell.self, forCellReuseIdentifier: MethodCell.reuseIdentifier)
        tableView.register(MethodGroupHeader.self, forHeaderFooterViewReuseIdentifier: MethodGroupHeader.reuseIdentifier)
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(methods: [Method]) {
        self.methods = methods
        tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.topLeft().bottomRight()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension TableViewExampleView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MethodGroupHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: MethodGroupHeader.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MethodCell.reuseIdentifier, for: indexPath) as! MethodCell
        cell.configure(method: methods[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        methodCellTemplate.configure(method: methods[indexPath.row])
        return methodCellTemplate.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)).height
    }
}