//
//  BothEdgesSnappedView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit
import MCSwiftLayout

class BothEdgesSnappedView: UIView {
    private let contentScrollView = UIScrollView()
    
    private let descriptionLabel = UILabel()
    
    private let noMarginsNoPaddings = BasicView(text: "70x30", color: .black)
    
//    private let noMarginsLeftInsetView = BasicView(text: "LI", color: UIColor.red.withAlphaComponent(1.0))
//    private let noMarginsRightInsetView = BasicView(text: "RI", color: UIColor.red.withAlphaComponent(0.8))
//    private let noMarginsLeftRightInsetView = BasicView(text: "LI-RI", color: UIColor.red.withAlphaComponent(0.6))
//    
//    private let leftMarginView = BasicView(text: "LM", color: UIColor.blue.withAlphaComponent(1.0))
//    private let leftMarginLeftInsetView = BasicView(text: "LM LI", color: UIColor.blue.withAlphaComponent(0.8))
//    private let leftMarginRightInsetView = BasicView(text: "LM RI", color: UIColor.blue.withAlphaComponent(0.6))
//    private let leftMarginLeftRightInsetView = BasicView(text: "LM LI-RI", color: UIColor.blue.withAlphaComponent(0.4))
//    
//    private let rigthMarginView = BasicView(text: "RM", color: UIColor.green.withAlphaComponent(1))
//    private let rigthMarginLeftInsetView = BasicView(text: "RM LI", color: UIColor.green.withAlphaComponent(0.8))
//    private let rigthMarginRightInsetView = BasicView(text: "RM RI", color: UIColor.green.withAlphaComponent(0.6))
//    private let rigthMarginLeftRightInsetView = BasicView(text: "RM LI-RI", color: UIColor.green.withAlphaComponent(0.4))
//    
//    private let leftRightMarginsView = BasicView(text: "LM-RM", color: UIColor.purple.withAlphaComponent(1))
//    private let leftRightMarginsLeftInsetView = BasicView(text: "LM-RM LI", color: UIColor.purple.withAlphaComponent(0.8))
//    private let leftRightMarginsRightInsetView = BasicView(text: "LM-RM RI", color: UIColor.purple.withAlphaComponent(0.6))
//    private let leftRightMarginsLeftRightInsetView = BasicView(text: "LM-RM LI-RI", color: UIColor.purple.withAlphaComponent(0.4))
    
    var rootView: UILabel!
    var aView: UILabel!
    var aViewChild: UILabel!
    
    var bView: UILabel!
    var bViewChild: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        rootView = UILabel()
        setup(rootView, color: .white, text: "")
        addSubview(rootView)
        
        aView = UILabel()
        setup(aView, color: UIColor.red.withAlphaComponent(0.5), text: "View A")
        rootView.addSubview(aView)
        
        aViewChild = UILabel()
        setup(aViewChild, color: UIColor.red.withAlphaComponent(1), text: "View A Child")
        aView.addSubview(aViewChild)
        
        bView = UILabel()
        setup(bView, color: UIColor.blue.withAlphaComponent(0.5), text: "View B")
        rootView.addSubview(bView)
        
        bViewChild = UILabel()
        setup(bViewChild, color: UIColor.blue.withAlphaComponent(0.7), text: "View B Child")
        bView.addSubview(bViewChild)
        
//        contentScrollView.backgroundColor = .yellow
//        addSubview(contentScrollView)
//        
//        descriptionLabel.text = "In this test the topLeft coordinates and the bottomRight have been set.\nMargins and Insets always have a value of 10\nL=Left, R=Right, M=Margin, I=Inset"
//        descriptionLabel.numberOfLines = 0
//        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
//        contentScrollView.addSubview(descriptionLabel)
//        
//        addView(noMarginsNoPaddings)
//        
//        // No margins
//        addView(noMarginsLeftInsetView)
//        addView(noMarginsRightInsetView)
//        addView(noMarginsLeftRightInsetView)
//        
//        // Left margin
//        addView(leftMarginView)
//        addView(leftMarginLeftInsetView)
//        addView(leftMarginRightInsetView)
//        addView(leftMarginLeftRightInsetView)
//        
//        // Right margin
//        addView(rigthMarginView)
//        addView(rigthMarginLeftInsetView)
//        addView(rigthMarginRightInsetView)
//        addView(rigthMarginLeftRightInsetView)
//        
//        // Left and right margins
//        addView(leftRightMarginsView)
//        addView(leftRightMarginsLeftInsetView)
//        addView(leftRightMarginsRightInsetView)
//        addView(leftRightMarginsLeftRightInsetView)
    }
    
    fileprivate func addView(_ view: BasicView) {
        view.layout.height(30).width(70)
        contentScrollView.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("\n")
        
        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        
        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
        
        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        // topLeft
//        aView.layout.topLeft()                    // CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)
        aViewChild.layout.topLeft(.topLeft, of: aView)  //(of: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
        aViewChild.layout.topLeft(of: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aView.layout.topLe
//        aViewChild.layout.topLeft(of: bView)      // CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.layout.topLeft(of: aViewChild)      // CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.layout.topLeft(of: aViewChild) // CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)
        
        // topCenter
//        aView.layout.topCenter()                      // CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.layout.topCenter(of: aView)        //CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.layout.topCenter(of: bView)        //CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.layout.topCenter(of: aViewChild)        //CGRect(x: 120.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.layout.topCenter(of: aViewChild)   //CGRect(x: -15.0, y: -80.0, width: 60.0, height: 20.0)
 
        // topRight
//        aView.layout.topRight()                      //CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.layout.topRight(of: aView)        //GRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.layout.topRight(of: bView)        //CGRect(x: 80.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.layout.topRight(of: aViewChild)        //CGRect(x: 90.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.layout.topRight(of: aViewChild)   //CGRect(x: -20.0, y: -80.0, width: 60.0, height: 20.0)
        
        // leftCenter
//        aView.layout.leftCenter()                    //CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)
//        aViewChild.layout.leftCenter(of: aView)      //CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)
//        aViewChild.layout.leftCenter(of: bView)      //CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)
//        bView.layout.leftCenter(of: aViewChild)      //CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)
//        bViewChild.layout.leftCenter(of: aViewChild) //CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)

        // Centers
//        aView.layout.centers()                    //CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)
//        aViewChild.layout.centers(of: aView)      //CGRect(x: 25.0, y: 15.0, width: 50.0, height: 30.0)
//        aViewChild.layout.centers(of: bView)      //CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)
//        bView.layout.centers(of: aViewChild)      //CGRect(x: 120.0, y: 95.0, width: 110.0, height: 80.0)
//        bViewChild.layout.centers(of: aViewChild) //CGRect(x: -15.0, y: -75.0, width: 60.0, height: 20.0)
    
        // rightCenter
//        aView.layout.rightCenter()                    //CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)
//        aViewChild.layout.rightCenter(of: aView)      //CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)
//        aViewChild.layout.rightCenter(of: bView)      //CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)
//        bView.layout.rightCenter(of: aViewChild)      //CGRect(x: 90.0, y: 95.0, width: 110.0, height: 80.0)
//        bViewChild.layout.rightCenter(of: aViewChild) //CGRect(x: -20.0, y: -75.0, width: 60.0, height: 20.0)

        // bottomLeft
//        aView.layout.bottomLeft()                    //CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)
//        aViewChild.layout.bottomLeft(of: aView)      //CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)
//        aViewChild.layout.bottomLeft(of: bView)      //CGRect(x: 20.0, y: 150.0, width: 50.0, height: 30.0)
//        bView.layout.bottomLeft(of: aViewChild)      //CGRect(x: 150.0, y: 70.0, width: 110.0, height: 80.0)
//        bViewChild.layout.bottomLeft(of: aViewChild) //CGRect(x: -10.0, y: -70.0, width: 60.0, height: 20.0)

        // bottomCenter
//        aView.layout.bottomCenter()                    //CGRect(x: 150.0, y: 340.0, width: 100.0, height: 60.0)
//        aViewChild.layout.bottomCenter(of: aView)      //CGRect(x: 25.0, y: 30.0, width: 50.0, height: 30.0)
//        aViewChild.layout.bottomCenter(of: bView)      //CGRect(x: 50.0, y: 150.0, width: 50.0, height: 30.0)
//        bView.layout.bottomCenter(of: aViewChild)      //CGRect(x: 120.0, y: 70.0, width: 110.0, height: 80.0)
//        bViewChild.layout.bottomCenter(of: aViewChild) //CGRect(x: -15.0, y: -70.0, width: 60.0, height: 20.0)

        // bottomRight
//        aView.layout.bottomRight()                    //CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)
//        aViewChild.layout.bottomRight(of: aView)      //CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)
//        aViewChild.layout.bottomRight(of: bView)      //CGRect(x: 80.0, y: 150.0, width: 50.0, height: 30.0)
//        bView.layout.bottomRight(of: aViewChild)      //CGRect(x: 90.0, y: 70.0, width: 110.0, height: 80.0)
//        bViewChild.layout.bottomRight(of: aViewChild) //CGRect(x: -20.0, y: -70.0, width: 60.0, height: 20.0)

        printViewFrame(aView, name: "aView")
        printViewFrame(aViewChild, name: "aViewChild")
        printViewFrame(bView, name: "bView")
        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate func setup(_ view: UILabel, color: UIColor, text: String) {
        view.text = text
        view.font = UIFont.systemFont(ofSize: 6)
        view.backgroundColor = color
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("\(name): CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height))")
    }
}
