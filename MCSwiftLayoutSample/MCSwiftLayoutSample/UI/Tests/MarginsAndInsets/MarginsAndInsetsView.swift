//
//  MarginsAndInsetsView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit
import MCSwiftLayout

class MarginsAndInsetsView: UIView {
    private let contentScrollView = UIScrollView()
    
    private let descriptionLabel = UILabel()
    
    var rootView: BasicView!
    var aView: BasicView!
//    var aViewChild: BasicView!
//    
//    var bView: BasicView!
//    var bViewChild: BasicView!
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
        rootView.addSubview(aView)
//
//        aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
//        aView.addSubview(aViewChild)
//        
//        bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
//        rootView.addSubview(bView)
//        
//        bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
//        bView.addSubview(bViewChild)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("\n")
        
        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 120)
        
//        aView.layout.width(100).margin(10)//CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.width(100).inset(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.width(100).insetLeft(10)//CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.width(100).insetLeft(10).insetRight(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.width(100).insetHorizontal(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.width(100).margins(10).insets(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)

//        aView.layout.left(150).width(100).margin(10) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.left(140).width(100).inset(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).width(100).insetLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.left(140).width(100).insetRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.left(140).width(100).insetLeft(10).insetRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).width(100).insetHorizontal(10)//CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).width(100).margin(10).inset(10)//CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).width(100).marginLeft(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.left(140).width(100).marginRight(10) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.left(140).width(100).marginHorizontal(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)
        
//        aView.layout.left(140).right(240).margin(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).right(240).inset(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).right(240).insetLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.left(140).right(240).insetRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.left(140).right(240).insetLeft(10).insetRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).right(240).insetHorizontal(10)//CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).right(240).margin(10).inset(10)//CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)
//        aView.layout.left(140).right(240).marginLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.left(140).right(240).marginRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.left(140).right(240).marginLeft(10).marginRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.left(140).right(240).marginHorizontal(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)

//        aView.layout.right(140).width(100).margin(10) //CGRect(x: 50.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.right(140).width(100).inset(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.right(140).width(100).insetLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.right(140).width(100).insetRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.layout.right(140).width(100).insetLeft(10).insetRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.right(140).width(100).insetHorizontal(10)//CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.right(140).width(100).margin(10).inset(10)//CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.layout.right(140).width(100).marginLeft(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.right(140).width(100).marginRight(10) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.layout.right(140).width(100).marginHorizontal(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)

        // TODO: Test top and bottom
        
        // TODO: Test using sizeThatFits
        

        //
        // sizeThatFits
        //
//        aView.sizeThatFitsExpectedArea = 40 * 40
        
        printViewFrame(aView, name: "aView")
//        printViewFrame(aViewChild, name: "aViewChild")
//        printViewFrame(bView, name: "bView")
//        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("\(name): CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height))")
    }
}
