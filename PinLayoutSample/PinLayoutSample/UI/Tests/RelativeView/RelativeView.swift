//
//  RelativeView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-22.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit
import PinLayout

class RelativeView: UIView {
    fileprivate let belowNavBarView = BasicView(text: "Below navbar", color: UIColor.lightGray)
    
    var rootView: BasicView!
    
    private let centerView = UIView()
    
    private let topLeftView = UIView()
    private let topCenterView = UIView()
    private let topRightView = UIView()
    
    private let leftTopView = UIView()
    private let leftCenterView = UIView()
    private let leftBottomView = UIView()
    
    private let bottomLeftView = UIView()
    private let bottomCenterView = UIView()
    private let bottomRightView = UIView()
    
    private let rightTopView = UIView()
    private let rightCenterView = UIView()
    private let rightBottomView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(belowNavBarView)
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        centerView.backgroundColor = .blue
        rootView.addSubview(centerView)
        
        addSquare(topLeftView, color: .green)
        addSquare(topCenterView, color: .yellow)
        addSquare(topRightView, color: .purple)
        
        addSquare(leftTopView, color: .magenta)
        addSquare(leftCenterView, color: .cyan)
        addSquare(leftBottomView, color: .purple)
        
        addSquare(bottomLeftView, color: .black)
        addSquare(bottomCenterView, color: .red)
        addSquare(bottomRightView, color: .gray)
        
        addSquare(rightTopView, color: .black)
        addSquare(rightCenterView, color: .red)
        addSquare(rightBottomView, color: .gray)
    }
    
    fileprivate func addSquare(_ view: UIView, color: UIColor) {
        view.backgroundColor = color
        view.pin.width(50).height(50)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        belowNavBarView.pin.topLeft().size(size).insetTop(64)
        
        rootView.frame = CGRect(x: 20, y: 20, width: 400, height: 400)
        centerView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
//        centerView.width = 200
//        centerView.height = 200
//        centerView.center = CGPoint(x: 200, y: 300)
        
        topLeftView.pin.above(of: centerView, aligned: .left)
        topCenterView.pin.above(of: centerView, aligned: .center)
        topRightView.pin.above(of: centerView, aligned: .right)
        
        leftTopView.pin.left(of: centerView, aligned: .top)
        leftCenterView.pin.left(of: centerView, aligned: .center)
        leftBottomView.pin.left(of: centerView, aligned: .bottom)
        
        bottomLeftView.pin.below(of: centerView, aligned: .left)
        bottomCenterView.pin.below(of: centerView, aligned: .center)
        bottomRightView.pin.below(of: centerView, aligned: .right)

        rightTopView.pin.right(of: centerView, aligned: .top)
        rightCenterView.pin.right(of: centerView, aligned: .center)
        rightBottomView.pin.right(of: centerView, aligned: .bottom)
    }
}
