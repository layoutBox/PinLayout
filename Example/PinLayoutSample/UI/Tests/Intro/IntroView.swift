//
//  IntroView.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-05.
//  Copyright (c) 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import UIKit
import PinLayout

class IntroView: UIView {

    fileprivate let container = UIView()
    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    fileprivate let segmented = UISegmentedControl(items: ["Intro", "1", "2"])
    fileprivate let textLabel = UILabel()
    
    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        
        logo.contentMode = .scaleAspectFit
        addSubview(logo)
        
        addSubview(segmented)
        
        textLabel.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable."
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        addSubview(textLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        logo.pin.topLeft().size(100).margin(74, 10, 10)
        segmented.pin.right(of: logo, aligned: .top).right().marginHorizontal(20)
        textLabel.pin.below(of: segmented, aligned: .left).width(of: segmented).pinEdges().marginTop(10).sizeToFit()
    }
}
