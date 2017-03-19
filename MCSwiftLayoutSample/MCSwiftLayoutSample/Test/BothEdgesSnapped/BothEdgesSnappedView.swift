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
    
    var rootView: BasicView!
    var aView: BasicView!
    var aViewChild: BasicView!
    
    var bView: BasicView!
    var bViewChild: BasicView!
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
        rootView.addSubview(aView)
        
        aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
        aView.addSubview(aViewChild)
        
        bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
        rootView.addSubview(bView)
        
        bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
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
        aView.frame = CGRect(x: 100, y: 100, width: 200, height: 160)
        aViewChild.frame = CGRect(x: 45, y: 50, width: 80, height: 80)
        bView.frame = CGRect(x: 160, y: 200, width: 40, height: 40)
        
//        bView.layout.above(of: aView, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.layout.above(of: aViewChild, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 145.0, y: 110.0, width: 40.0, height: 40.0)))
        
//        bView.layout.above(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 180.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.layout.above(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 165.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.layout.above(of: aView, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 260.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.layout.above(of: aViewChild, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 110.0, width: 40.0, height: 40.0)))

        
//        bView.layout.right(of: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 40.0, height: 40.0)))
//        bView.layout.right(of: aViewChild, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 150.0, width: 40.0, height: 40.0)))

//        bView.layout.right(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 160.0, width: 40.0, height: 40.0)))
//        bView.layout.right(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 170.0, width: 40.0, height: 40.0)))

//        bView.layout.right(of: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 220.0, width: 40.0, height: 40.0)))
//        bView.layout.right(of: aViewChild, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 190.0, width: 40.0, height: 40.0)))

        
//        bView.layout.below(of: aView, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 100.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.layout.below(of: aViewChild, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 145.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.layout.below(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 180.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.layout.below(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 165.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.layout.below(of: aView, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 260.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.layout.below(of: aViewChild, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 230.0, width: 40.0, height: 40.0)))


//        bView.layout.left(of: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 40.0, height: 40.0)))
//        bView.layout.left(of: aViewChild, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 40.0, height: 40.0)))

//        bView.layout.left(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 160.0, width: 40.0, height: 40.0)))
//        bView.layout.left(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 170.0, width: 40.0, height: 40.0)))

//        bView.layout.left(of: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 220.0, width: 40.0, height: 40.0)))
//        bView.layout.left(of: aViewChild, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 190.0, width: 40.0, height: 40.0)))

        
//        bView.layout.above(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.layout.above(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.layout.left(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 200.0, width: 40.0, height: 40.0)))
//        bView.layout.left(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 200.0, width: 40.0, height: 40.0)))


//        bView.layout.below(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.layout.below(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.layout.right(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 200.0, width: 40.0, height: 40.0)))

//        bView.layout.right(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 200.0, width: 40.0, height: 40.0)))

        
        // MARGINS
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
//        let label = UILabel()
//        label.text = "clafsdj lfkd asdkjkd lkjlksfjd daljs df flkjdslkjf lksfjlkj jaslkj ljdfaj lkajdsfl k asdlkd jassd adskjfksad laksdj fds;alkj l"
//        label.numberOfLines = 0
//        let toto = label.sizeThatFits(CGSize(width: 20, height: CGFloat.greatestFiniteMagnitude))
//        let toto2 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 20))
//        let toto3 = label.sizeThatFits(CGSize(width: 20, height: 20))
//        
//        let toto4 = label.sizeThatFits(CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
//        let toto5 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 100))
//        let toto6 = label.sizeThatFits(CGSize(width: 100, height: 100))
//        
//        let toto7 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        //
        // sizeThatFits
        //
        aView.sizeThatFitsExpectedArea = 40 * 40
        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 160)
        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
        
        //
        // sizeToFit
        //
//        aView.layout.width(100).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))

//        aView.layout.width(of: aViewChild).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))

//        aView.layout.height(100).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))

//        aView.layout.height(of: aViewChild).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0)))

//        aView.layout.size(of: aViewChild).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))

//        aView.layout.size(CGSize(width: 20, height: 100)).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))

        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        aViewChild.layout.pinCenter(.center, of: aView).height(40).sizeToFit()
//        expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))
        // SHOULD EQUAL THESE 2 LINES:
//        aViewChild.layout.width(40).height(40)
//        aViewChild.layout.pinCenter(to: aView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))

//        aViewChild.layout.pinCenter(.center, of: aView).width(20).sizeToFit()
//        expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))
        // SHOULD EQUAL THESE 2 LINES:
        //aViewChild.layout.width(20).height(80)
        //aViewChild.layout.pinCenter(to: aView)
        //expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))


        
//        aViewChild.layout.pinTopLeft(.topLeft, of: bView).height(40).sizeToFit()
//        aViewChild.layout.pinTopLeft(.topLeft, of: aView).height(40).sizeToFit()
//        bView.layout.pinTopLeft(.topLeft, of: aViewChild).height(40).sizeToFit()
        
//        aView.layout.sizeThatFits(size: CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude)) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)
//        aView.layout.sizeThatFits(width: 100) // CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)
//        aView.layout.sizeThatFits(widthOf: aViewChild) //CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)
        
//        aView.layout.sizeThatFits(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 100)) //CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)
//        aView.layout.sizeThatFits(height: 100) //CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)
//        aView.layout.sizeThatFits(heightOf: aViewChild)// CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0)
        
//        aView.layout.sizeThatFits(sizeOf: aViewChild)//CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)
        
//        aView.layout.size(of: aViewChild)// CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)
//        aView.layout.size(CGSize(width: 25, height: 25))//CGRect(x: 140.0, y: 100.0, width: 25.0, height: 25.0)
        
        //
        // pin coordinate
        //
//        aViewChild.layout.pinTop(.top, of: aView) //CGRect(x: 10.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinTop(.top, of: bView)      // CGRect(x: 10.0, y: 100.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinTop(.top, of: aViewChild) //CGRect(x: 40.0, y: -80.0, width: 60.0, height: 20.0)

//        aViewChild.layout.pinTop(.bottom, of: aView)      //CGRect(x: 10.0, y: 60.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinTop(.bottom, of: bView)      //CGRect(x: 10.0, y: 180.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinTop(.bottom, of: aViewChild) //CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)
        
//        aViewChild.layout.pinBottom(.top, of: aView) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.layout.pinBottom(.top, of: bView)      //CGRect(x: 10.0, y: 70.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinBottom(.top, of: aViewChild) //CGRect(x: 40.0, y: -100.0, width: 60.0, height: 20.0)
//
//        aViewChild.layout.pinBottom(.bottom, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.layout.pinBottom(.bottom, of: bView)      //CGRect(x: 10.0, y: 150.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinBottom(.bottom, of: aViewChild) //CGRect(x: 40.0, y: -70.0, width: 60.0, height: 20.0)

//        aViewChild.layout.pinLeft(.left, of: aView) //CGRect(x: 0.0, y: 20.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinLeft(.left, of: bView)      //CGRect(x: 20.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinLeft(.left, of: aViewChild) //CGRect(x: -10.0, y: 10.0, width: 60.0, height: 20.0)
//
//        aViewChild.layout.pinLeft(.right, of: aView)      //CGRect(x: 100.0, y: 20.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinLeft(.right, of: bView)      //CGRect(x: 130.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinLeft(.right, of: aViewChild) //CGRect(x: 40.0, y: 10.0, width: 60.0, height: 20.0)

//        aViewChild.layout.pinRight(.left, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.layout.pinRight(.left, of: bView)      //CGRect(x: -30.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinRight(.left, of: aViewChild) //CGRect(x: -70.0, y: 10.0, width: 60.0, height: 20.0)
//
//        aViewChild.layout.pinRight(.right, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.layout.pinRight(.right, of: bView)      //CGRect(x: 80.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.layout.pinRight(.right, of: aViewChild) //CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)

        //
        // pin point
        //
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        // topLeft
//        aView.layout.topLeft()                    // CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.layout.pinTopLeft(.topLeft, of: aView)  //(of: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinTopLeft(of: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinTopLeft(of: aView).pinBottomRight()
//        aViewChild.layout.topLeft(of: bView)      // CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.layout.topLeft(of: aViewChild)      // CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.layout.pinTopLeft(to: aViewChild)< // CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)
        
//        bView.layout.pinBottomRight().pinTopLeft(to: .zero).below(of: bViewChild)
        
        // pinTopCenter
//        aView.layout.pinTopCenter()                      // CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.layout.pinTopCenter(to: aView)        //CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.layout.pinTopCenter(to: bView)        //CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.layout.pinTopCenter(to: aViewChild)        //CGRect(x: 120.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.layout.pinTopCenter(to: aViewChild)   //CGRect(x: -15.0, y: -80.0, width: 60.0, height: 20.0)
 
        // pinTopRight
//        aView.layout.pinTopRight()
//        aViewChild.layout.pinTopRight(to: aView)
//        aViewChild.layout.pinTopRight(to: bView)
//        bView.layout.pinTopRight(to: aViewChild)
//        bViewChild.layout.pinTopRight(to: aViewChild)
        
        // pinLeftCenter
//        aView.layout.pinLeftCenter()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))

//        aViewChild.layout.pinLeftCenter(to: aView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
//        aViewChild.layout.pinLeftCenter(to: bView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
//        bView.layout.pinLeftCenter(to: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)))
//        bViewChild.layout.pinLeftCenter(to: aViewChild)
//        expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)))

        // pinCenter
//        aView.layout.pinCenter()
//        aViewChild.layout.pinCenter(to: aView)
//        aViewChild.layout.pinCenter(to: bView)
//        bView.layout.pinCenter(to: aViewChild)
//        bViewChild.layout.pinCenter(to: aViewChild)
    
        // pinRightCenter
//        aView.layout.pinRightCenter()
//        aViewChild.layout.pinRightCenter(to: aView)
//        aViewChild.layout.pinRightCenter(to: bView)
//        bView.layout.pinRightCenter(to: aViewChild)
//        bViewChild.layout.pinRightCenter(to: aViewChild)

        // pinBottomLeft
//        aView.layout.pinBottomLeft()
//        aViewChild.layout.pinBottomLeft(to: aView)
//        aViewChild.layout.pinBottomLeft(to: bView)
//        bView.layout.pinBottomLeft(to: aViewChild)
//        bViewChild.layout.pinBottomLeft(to: aViewChild)

        // pinBottomCenter
//        aView.layout.pinBottomCenter()
//        aViewChild.layout.pinBottomCenter(to: aView)
//        aViewChild.layout.pinBottomCenter(to: bView)
//        bView.layout.pinBottomCenter(to: aViewChild)
//        bViewChild.layout.pinBottomCenter(to: aViewChild)

        // pinBottomRight
//        aView.layout.pinBottomRight()
//        aViewChild.layout.pinBottomRight(of: aView)
//        aViewChild.layout.pinBottomRight(of: bView)
//        bView.layout.pinBottomRight(of: aViewChild)
//        bViewChild.layout.pinBottomRight(of: aViewChild) 

        printViewFrame(aView, name: "aView")
        printViewFrame(aViewChild, name: "aViewChild")
        
        printViewFrame(bView, name: "bView")
        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("expect(\(name).frame).to(equal(CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height))))")
    }
}
