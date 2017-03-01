//
//  MenuView.swift
//  MCLayoutExample
//
//  Created by Luc Dion on 2016-09-03.
//  Copyright © 2016 Mirego. All rights reserved.
//
import UIKit

protocol MenuViewDelegate: class {
    func didSelect(page: Page)
}

class MenuView: UIView {
    weak var delegate: MenuViewDelegate?

    fileprivate let tableView = UITableView()
    fileprivate let cellIdentifier = "MenuViewCell"

    init() {
        super.init(frame: .zero)

        backgroundColor = .red

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        addSubview(tableView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        tableView.layout.size(size)
//        tableView.layoutOld.matchView(self)
    }
}

// MARK: UITableViewDataSource
extension MenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Page.count.rawValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = Page(rawValue: indexPath.row)?.text ?? "Unknown"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
}

// MARK: UITableViewDelegate
extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let page = Page(rawValue: indexPath.row) {
            delegate?.didSelect(page: page)
        }
    }

    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
     {
     return FavoriteListsTableViewCell.heighForWidth(width)
     }*/
}
