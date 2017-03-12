//
//  MarginsAndPaddingsLeftWidthView.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class MarginsAndPaddingsLeftWidthView: UIView {
    private let contentScrollView = UIScrollView()
    
    private let descriptionLabel = UILabel()
    
    private let noMarginsNoPaddings = BasicView(text: "70x30", color: .black)
    
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
    
//    private let noMarginsNoPaddings2 = BasicView(text: "70x30", color: UIColor.black)
//    private let topMarginView = BasicView(text: "TM", color: UIColor.orange.withAlphaComponent(1))
//    private let topMarginTopPaddingView = BasicView(text: "TM TP", color: UIColor.orange.withAlphaComponent(0.8))
//    private let topMarginBottomPaddingView = BasicView(text: "TM BP", color: UIColor.orange.withAlphaComponent(0.6))
//    private let topMarginTopBottomPaddingView = BasicView(text: "TM TP-BP", color: UIColor.orange.withAlphaComponent(0.4))
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white

        contentScrollView.backgroundColor = .yellow
        addSubview(contentScrollView)
        
        descriptionLabel.text = "In this test the topLeft coordinates and width have been set.\nMargins and Insets always have a value of 10\nL=Left, R=Right, M=Margin, I=Inset"
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

        // Top margin
//        addView(noMarginsNoPaddings2)
//        addView(topMarginView)
//        addView(topMarginTopPaddingView)
//        addView(topMarginBottomPaddingView)
//        addView(topMarginTopBottomPaddingView)
        
        // Bottom margin
        
        // Top and Bottom margin
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
        
        let leftPosition: CGFloat = 0
        
        contentScrollView.layout.pinTopLeft().width(width).height(height).topInset(64)
        
        descriptionLabel.size = descriptionLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        descriptionLabel.layout.pinTopLeft(to: CGPoint(x: leftPosition, y: 10))
        
        // No margins
        noMarginsNoPaddings.layout.pinTopLeft(to: descriptionLabel.bottomLeft).topMargin(5)
        noMarginsLeftInsetView.layout.top(noMarginsNoPaddings.bottom).left(leftPosition).width(70).leftInset(10)
        noMarginsRightInsetView.layout.top(noMarginsLeftInsetView.bottom).left(leftPosition).width(70).rightInset(10)
        noMarginsLeftRightInsetView.layout.top(noMarginsRightInsetView.bottom).left(leftPosition).width(70).leftInset(10).rightInset(10)
        
        // Left margin
        leftMarginView.layout.top(noMarginsLeftRightInsetView.bottom + 5).left(leftPosition).width(70).leftMargin(10)
        leftMarginLeftInsetView.layout.top(leftMarginView.bottom).left(leftPosition).width(70).leftMargin(10).leftInset(10)
        leftMarginRightInsetView.layout.top(leftMarginLeftInsetView.bottom).left(leftPosition).width(70).leftMargin(10).rightInset(10)
        leftMarginLeftRightInsetView.layout.top(leftMarginRightInsetView.bottom).left(leftPosition).width(70).leftMargin(10).leftInset(10).rightInset(10)
        
        // Right margin
        rigthMarginView.layout.top(leftMarginLeftRightInsetView.bottom + 5).left(leftPosition).width(70).rightMargin(10)
        rigthMarginLeftInsetView.layout.top(rigthMarginView.bottom).left(leftPosition).width(70).rightMargin(10).leftInset(10)
        rigthMarginRightInsetView.layout.top(rigthMarginLeftInsetView.bottom).left(leftPosition).width(70).rightMargin(10).rightInset(10)
        rigthMarginLeftRightInsetView.layout.top(rigthMarginRightInsetView.bottom).left(leftPosition).width(70).rightMargin(10).leftInset(10).rightInset(10)
        
        // Left and right margins
        leftRightMarginsView.layout.top(rigthMarginLeftRightInsetView.bottom + 5).left(leftPosition).width(70).leftMargin(10).rightMargin(10)
        leftRightMarginsLeftInsetView.layout.top(leftRightMarginsView.bottom).left(leftPosition).width(70).leftMargin(10).rightMargin(10).leftInset(10)
        leftRightMarginsRightInsetView.layout.top(leftRightMarginsLeftInsetView.bottom).left(leftPosition).width(70).leftMargin(10).rightMargin(10).rightInset(10)
        leftRightMarginsLeftRightInsetView.layout.top(leftRightMarginsRightInsetView.bottom).left(leftPosition).width(70).leftMargin(10).rightMargin(10).leftInset(10).rightInset(10)
        
        // Top Margin
//        noMarginsNoPaddings2.layout2.top(leftRightMarginsLeftRightInsetView.bottom + 5).left(leftPosition).width(70).height(30)
//        topMarginView.layout2.top(noMarginsNoPaddings2.top).left(noMarginsNoPaddings2.right).width(70).height(30).topMargin(10)
//        topMarginTopPaddingView.layout2.top(topMarginView.top).left(topMarginView.right).width(70).height(30).topMargin(10).topInset(10)
//        topMarginBottomPaddingView.layout2.top(topMarginView.top).left(topMarginTopPaddingView.right).width(70).height(30).topMargin(10).bottomPadding(10)
//        topMarginTopBottomPaddingView.layout2.top(topMarginView.top).left(topMarginBottomPaddingView.right).width(70).height(30).topMargin(10).topInset(10).bottomPadding(10)
        
        contentScrollView.contentSize = CGSize(width: width, height: leftRightMarginsLeftRightInsetView.bottom)
        contentScrollView.contentInset = UIEdgeInsets.zero
    }
}
