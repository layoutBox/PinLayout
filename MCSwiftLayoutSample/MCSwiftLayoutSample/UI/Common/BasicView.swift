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
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
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
            
        label.pin.top(0).left(0)
    }
    
    var sizeThatFitsExpectedArea: CGFloat = 40 * 40
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = CGSize()
        if size.width != CGFloat.greatestFiniteMagnitude {
            newSize.width = size.width
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        } else if size.height != CGFloat.greatestFiniteMagnitude {
            newSize.height = size.height
            newSize.width = sizeThatFitsExpectedArea / newSize.height
        } else {
            newSize.width = 40
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        }
        
        return newSize
    }
}
