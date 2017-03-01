//
//  BasicView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright © 2017 Mirego. All rights reserved.
//
import UIKit

class BasicView: UILabel {
    init(text: String? = nil, color: UIColor) {
        super.init(frame: .zero)

        self.text = text
        font = UIFont.systemFont(ofSize: 7)
        textColor = .white
        backgroundColor = color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
