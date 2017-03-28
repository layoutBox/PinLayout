//
//  ChainedLayoutView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-20.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class ChainedLayoutView: UIView {
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
        
        centerView.backgroundColor = .blue
        addSubview(centerView)
        
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
        view.layout.height(50).width(50)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerView.layout.width(200).height(200)
        centerView.center = CGPoint(x: 200, y: 300)
        print("topCenterView: \(topCenterView.frame)")
        
        //        topLeftView.layout2.bottomLeft(centerView.topLeft).margins(10)
        //.bottomLeft = centerView.topLeft
        //        topCenterView.bottomCenter = centerView.topCenter
        //        topRightView.bottomRight = centerView.topRight

        //bottomLeftView.layout2.topLeft(centerView.bottomLeft).margins(10)
//        bottomLeftView.layout.pinTopLeft(<#T##pin: Pin##Pin#>, of: <#T##UIView#>)
//
//        pinTopLeft(to: centerView.pin.bottomLeft).height(50).marginTop(10).marginBottom(10)
//        bottomCenterView.layout.pinCenter(to: centerView.bottomCenter).height(50).marginTop(10).marginBottom(10)
//        bottomRightView.layout.pinTopRight(to: centerView.bottomRight).height(50).marginTop(10).marginBottom(10)
//        
//        rightTopView.layout.pinTopLeft(to: centerView.topRight).width(50).marginLeft(10).marginRight(10)
//        rightCenterView.layout.pinLeftCenter(to: centerView.rightCenter).height(50).marginLeft(10).marginRight(10)
//        rightBottomView.layout.pinBottomLeft(to: centerView.bottomRight).height(50).marginLeft(10).marginRight(10)
        
//
//        leftTopView.topRight = centerView.topLeft
//        leftCenterView.rightCenter = centerView.leftCenter
//        leftBottomView.bottomRight = centerView.bottomLeft
//        
//        bottomLeftView.topLeft = centerView.bottomLeft
//        bottomCenterView.topCenter = centerView.bottomCenter
//        bottomRightView.topRight = centerView.bottomRight
    }
}
