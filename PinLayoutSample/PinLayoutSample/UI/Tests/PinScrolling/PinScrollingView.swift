//
//  PinScrollingView.swift
//  PinLayoutSample
//
//  Created by Luc Dion on 2017-03-23.
//  Copyright (c) 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import UIKit

class PinScrollingView: UIView {

    private let contentScrollView = UIScrollView()

    var aView: BasicView!
    var bView: BasicView!
    var cView: BasicView!
    var dView: BasicView!

    init() {
        super.init(frame: .zero)

        backgroundColor = .black

        contentScrollView.backgroundColor = .white
        contentScrollView.delegate = self
        addSubview(contentScrollView)

         aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
         contentScrollView.addSubview(aView)

         bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
         addSubview(bView)

        cView = BasicView(text: "View C", color: UIColor.red.withAlphaComponent(0.5))
        contentScrollView.addSubview(cView)

        dView = BasicView(text: "View D", color: UIColor.red.withAlphaComponent(0.5))
        contentScrollView.addSubview(dView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentScrollView.pin.topLeft().width(width).height(height).insetTop(64)
        contentScrollView.contentSize = CGSize(width: width, height: height * 4)

        aView.pin.top(20).left(0).right(width).height(40).margin(10)
        layoutBView()

        cView.pin.below(of: aView, aligned: .right).width(100).height(50).marginTop(10)
        dView.pin.below(of: aView, aligned: .left).left(of: cView).height(of: cView).marginTop(10).marginRight(10)
    }

    fileprivate func layoutBView() {
        bView.pin.topLeft(to: aView.anchor.topLeft).bottomRight(to: aView.anchor.bottomCenter)
    }
}

extension PinScrollingView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        layoutBView()
    }
}
