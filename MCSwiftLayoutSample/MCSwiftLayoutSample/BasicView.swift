//
//  BasicView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright © 2017 Mirego. All rights reserved.
//
import UIKit

class BasicView: UIView {
    fileprivate let label = UILabel()
    
    init(text: String? = nil, color: UIColor) {
        super.init(frame: .zero)

        backgroundColor = color
        
        label.text = text
        label.font = UIFont.systemFont(ofSize: 7)
        label.textColor = .white
        label.sizeToFit()
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        label.layout.top(0).left(0)
    }
}
