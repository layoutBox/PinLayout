//
//  IntroView.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-05.
//  Copyright (c) 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import UIKit

class IntroView: UIView {
    
    // var rootView: BasicView!
    // var aView: BasicView!
    // var aViewChild: BasicView!
    
    // var bView: BasicView!
    // var bViewChild: BasicView!

    init() {
        super.init(frame: .zero)

        backgroundColor = .black
        
        // rootView = BasicView(text: "", color: .white)
        // addSubview(rootView)
        
        // aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
        // rootView.addSubview(aView)
        
        // aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
        // aView.addSubview(aViewChild)
        
        // bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
        // rootView.addSubview(bView)
        
        // bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
        // bView.addSubview(bViewChild)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        // aView.frame = CGRect(x: 100, y: 100, width: 200, height: 160)
        // aViewChild.frame = CGRect(x: 45, y: 50, width: 80, height: 80)
        // bView.frame = CGRect(x: 160, y: 200, width: 40, height: 40)
    }
}
