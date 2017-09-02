//
//  MethodGroupHeader.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-13.
//  Copyright © 2017 Mirego. All rights reserved.
//

import UIKit

class MethodGroupHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "MethodGroupHeader"
    static let height: CGFloat = 50
    
    fileprivate let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    
        titleLabel.text = "PinLayout's methods"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.sizeToFit()
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Center the label vertically. Note that we don't need to specify the size, it has already be adjusted in init().
        titleLabel.pin.left().vCenter().margin(10)
    }
}
