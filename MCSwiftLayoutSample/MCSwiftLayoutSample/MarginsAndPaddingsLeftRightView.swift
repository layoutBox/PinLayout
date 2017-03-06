//
//  MarginsAndPaddingsLeftRightView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class MarginsAndPaddingsLeftRightView: UIView {
    fileprivate let viewHeight: CGFloat = 40
    private let contentScrollView = UIScrollView()
    
    private let descriptionLabel = UILabel()
    
    private let noMarginsNoPaddings = BasicView(text: "70x40", color: .black)
    
    private let noMarginsLeftInsetView = BasicView(text: "LI", color: UIColor.red.withAlphaComponent(1.0))
    private let noMarginsRightInsetView = BasicView(text: "RI", color: UIColor.red.withAlphaComponent(0.8))
    private let noMarginsLeftRightInsetView = BasicView(text: "LI-RI", color: UIColor.red.withAlphaComponent(0.6))
    
    private let leftMarginView = BasicView(text: "LM", color: UIColor.blue.withAlphaComponent(1.0))
    private let leftMarginLeftInsetView = BasicView(text: "LM LI", color: UIColor.blue.withAlphaComponent(0.8))
    private let leftMarginRightInsetView = BasicView(text: "LM RI", color: UIColor.blue.withAlphaComponent(0.6))
    private let leftMarginLeftRightInsetView = BasicView(text: "LM LI-RI", color: UIColor.blue.withAlphaComponent(0.4))
    
    private let rigthMarginView = BasicView(text: "RM", color: UIColor.green.withAlphaComponent(1))
    private let rigthMarginLeftInsetView = BasicView(text: "RM LI", color: UIColor.green.withAlphaComponent(0.8))
    private let rigthMarginRightInsetView = BasicView(text: "RM RI", color: UIColor.green.withAlphaComponent(0.6))
    private let rigthMarginLeftRightInsetView = BasicView(text: "RM LI-RI", color: UIColor.green.withAlphaComponent(0.4))
    
    private let leftRightMarginsView = BasicView(text: "LM-RM", color: UIColor.purple.withAlphaComponent(1))
    private let leftRightMarginsLeftInsetView = BasicView(text: "LM-RM LI", color: UIColor.purple.withAlphaComponent(0.8))
    private let leftRightMarginsRightInsetView = BasicView(text: "LM-RM RI", color: UIColor.purple.withAlphaComponent(0.6))
    private let leftRightMarginsLeftRightInsetView = BasicView(text: "LM-RM LI-RI", color: UIColor.purple.withAlphaComponent(0.4))

//    TODO
        private let noMarginsNoPaddings2 = BasicView(text: "70x30", color: UIColor.black)
        private let topMarginView = BasicView(text: "TM", color: UIColor.orange.withAlphaComponent(1))
        private let topMarginTopPaddingView = BasicView(text: "TM TP", color: UIColor.orange.withAlphaComponent(0.8))
        private let topMarginBottomPaddingView = BasicView(text: "TM BP", color: UIColor.orange.withAlphaComponent(0.6))
        private let topMarginTopBottomPaddingView = BasicView(text: "TM TP-BP", color: UIColor.orange.withAlphaComponent(0.4))

    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        contentScrollView.backgroundColor = .yellow
        addSubview(contentScrollView)
        
        descriptionLabel.text = "In this test the topLeft coordinates and the bottomRight have been set.\nMargins and Insets always have a value of 10\nL=Left, R=Right, M=Margin, I=Inset"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        contentScrollView.addSubview(descriptionLabel)
        
        addView(noMarginsNoPaddings)
        
        // No margins
        addView(noMarginsLeftInsetView)
        addView(noMarginsRightInsetView)
        addView(noMarginsLeftRightInsetView)

        // Left margin
        addView(leftMarginView)
        addView(leftMarginLeftInsetView)
        addView(leftMarginRightInsetView)
        addView(leftMarginLeftRightInsetView)
        
        // Right margin
        addView(rigthMarginView)
        addView(rigthMarginLeftInsetView)
        addView(rigthMarginRightInsetView)
        addView(rigthMarginLeftRightInsetView)

        // Left and right margins
        addView(leftRightMarginsView)
        addView(leftRightMarginsLeftInsetView)
        addView(leftRightMarginsRightInsetView)
        addView(leftRightMarginsLeftRightInsetView)
    }
    
    fileprivate func addView(_ view: BasicView) {
        view.layout.height(viewHeight).width(70)
        contentScrollView.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftPosition: CGFloat = 0
        
        contentScrollView.layout.topLeft(CGPoint(x: 0, y: 0)).width(width).height(height).topInset(64)
        
        descriptionLabel.size = descriptionLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        descriptionLabel.layout.topLeft(CGPoint(x: leftPosition, y: 10))
        
        // No margins
        let rightPosition: CGFloat = 70
        var topPosition = descriptionLabel.bottom + 10
        
        noMarginsNoPaddings.layout.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition)
        expect(view: noMarginsNoPaddings, toMatchRect: CGRect(x: 0, y: 63, width: 70, height: 40))
        topPosition += viewHeight
        
        noMarginsLeftInsetView.layout.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition).leftInset(10)
        expect(view: noMarginsLeftInsetView, toMatchRect: CGRect(x: 10, y: 103, width: 60, height: 40))
        topPosition += viewHeight
        
        noMarginsRightInsetView.layout.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition).rightInset(10)
        expect(view: noMarginsRightInsetView, toMatchRect: CGRect(x: 0, y: 143, width: 60, height: 40))
        topPosition += viewHeight
        
        noMarginsLeftRightInsetView.layout.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition).leftInset(10).rightInset(10)
        expect(view: noMarginsLeftRightInsetView, toMatchRect: CGRect(x: 10, y: 183, width: 50, height: 40))
        topPosition += viewHeight
        
        // Left margin
        topPosition += 5
        leftMarginView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10)
        expect(view: leftMarginView, toMatchRect: CGRect(x: 10, y: 228, width: 60, height: 40))
        topPosition += viewHeight
        
        leftMarginLeftInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).leftInset(10)
        expect(view: leftMarginLeftInsetView, toMatchRect: CGRect(x: 20, y: 268, width: 50, height: 40))
        topPosition += viewHeight
        
        leftMarginRightInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).rightInset(10)
        expect(view: leftMarginRightInsetView, toMatchRect: CGRect(x: 10, y: 308, width: 50, height: 40))
        topPosition += viewHeight
        
        leftMarginLeftRightInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).leftInset(10).rightInset(10)
        expect(view: leftMarginLeftRightInsetView, toMatchRect: CGRect(x: 20, y: 348, width: 40, height: 40))
        topPosition += viewHeight
        
        // Right margin
        topPosition += 5
        rigthMarginView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).rightMargin(10)
        expect(view: rigthMarginView, toMatchRect: CGRect(x: 0, y: 393, width: 60, height: 40))
        topPosition += viewHeight
        
        rigthMarginLeftInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).rightMargin(10).leftInset(10)
        expect(view: rigthMarginLeftInsetView, toMatchRect: CGRect(x: 10, y: 433, width: 50, height: 40))
        topPosition += viewHeight
        
        rigthMarginRightInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).rightMargin(10).rightInset(10)
        expect(view: rigthMarginRightInsetView, toMatchRect: CGRect(x: 0, y: 473, width: 50, height: 40))
        topPosition += viewHeight
        
        rigthMarginLeftRightInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).rightMargin(10).leftInset(10).rightInset(10)
        expect(view: rigthMarginLeftRightInsetView, toMatchRect: CGRect(x: 10, y: 513, width: 40, height: 40))
        topPosition += viewHeight
        
        // Left and right margins
        topPosition += 5
        leftRightMarginsView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).rightMargin(10)
        expect(view: leftRightMarginsView, toMatchRect: CGRect(x: 10, y: 558, width: 50, height: 40))
        topPosition += viewHeight
        
        leftRightMarginsLeftInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).rightMargin(10).leftInset(10)
        expect(view: leftRightMarginsLeftInsetView, toMatchRect: CGRect(x: 20, y: 598, width: 40, height: 40))
        topPosition += viewHeight
        
        leftRightMarginsRightInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).rightMargin(10).rightInset(10)
        expect(view: leftRightMarginsRightInsetView, toMatchRect: CGRect(x: 10, y: 638, width: 40, height: 40))
        topPosition += viewHeight

        leftRightMarginsLeftRightInsetView.layout.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).leftMargin(10).rightMargin(10).leftInset(10).rightInset(10)
        expect(view: leftRightMarginsLeftRightInsetView, toMatchRect: CGRect(x: 20, y: 678, width: 30, height: 40))
        topPosition += viewHeight

        contentScrollView.contentSize = CGSize(width: width, height: topPosition)
        contentScrollView.contentInset = UIEdgeInsets.zero
    }
}
