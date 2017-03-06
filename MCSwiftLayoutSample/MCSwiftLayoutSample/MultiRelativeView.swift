//
//  MultiRelativeView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-25.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class MultiRelativeView: UIView {
    private let view1 = BasicView(text: "View1", color: UIColor.blue.withAlphaComponent(0.6))
    private let view2 = BasicView(text: "View2", color: UIColor.blue.withAlphaComponent(0.6))
    private let view = BasicView(text: "View", color: UIColor.blue.withAlphaComponent(1.0))
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(view1)
        addSubview(view2)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        view1.layout.top(64).left(10).width(100).height(100)
        view2.layout.right(of: view1, aligned: .top).leftMargin(150).width(100).height(100)
        
        view.layout.right(of: view1, aligned: .top).left(of: view2).height(75).leftInset(10).rightInset(10)
    }
}
