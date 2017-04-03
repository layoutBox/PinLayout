// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
        view.pin.height(viewHeight).width(70)
        contentScrollView.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftPosition: CGFloat = 0
        
        contentScrollView.pin.topLeft().bottomRight().marginTop(64)
        
//        descriptionLabel.size = descriptionLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        descriptionLabel.pin.topLeft().right(0).marginTop(10).sizeToFit()
        
        // No margins
//        let rightPosition: CGFloat = 70
//        var topPosition = descriptionLabel.bottom + 10

        noMarginsNoPaddings.pin.left(70).below(of: descriptionLabel).marginTop(10)

//        noMarginsNoPaddings.pin.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition)
//        expect(view: noMarginsNoPaddings, toMatchRect: CGRect(x: 0, y: 63, width: 70, height: 40))
//        topPosition += viewHeight
//
        noMarginsLeftInsetView.pin.left(70).below(of: noMarginsNoPaddings).marginTop(10).marginLeft(10)
//        expect(view: noMarginsLeftInsetView, toMatchRect: CGRect(x: 10, y: 103, width: 60, height: 40))
//        topPosition += viewHeight
//        
//        noMarginsRightInsetView.pin.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition).insetRight(10)
//        expect(view: noMarginsRightInsetView, toMatchRect: CGRect(x: 0, y: 143, width: 60, height: 40))
//        topPosition += viewHeight
//        
//        noMarginsLeftRightInsetView.pin.top(topPosition).left(0).bottom(topPosition + viewHeight).right(rightPosition).insetLeft(10).insetRight(10)
//        expect(view: noMarginsLeftRightInsetView, toMatchRect: CGRect(x: 10, y: 183, width: 50, height: 40))
//        topPosition += viewHeight
//        
//        // Left margin
//        topPosition += 5
//        leftMarginView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10)
//        expect(view: leftMarginView, toMatchRect: CGRect(x: 10, y: 228, width: 60, height: 40))
//        topPosition += viewHeight
//        
//        leftMarginLeftInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).insetLeft(10)
//        expect(view: leftMarginLeftInsetView, toMatchRect: CGRect(x: 20, y: 268, width: 50, height: 40))
//        topPosition += viewHeight
//        
//        leftMarginRightInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).insetRight(10)
//        expect(view: leftMarginRightInsetView, toMatchRect: CGRect(x: 10, y: 308, width: 50, height: 40))
//        topPosition += viewHeight
//        
//        leftMarginLeftRightInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).insetLeft(10).insetRight(10)
//        expect(view: leftMarginLeftRightInsetView, toMatchRect: CGRect(x: 20, y: 348, width: 40, height: 40))
//        topPosition += viewHeight
//        
//        // Right margin
//        topPosition += 5
//        rigthMarginView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginRight(10)
//        expect(view: rigthMarginView, toMatchRect: CGRect(x: 0, y: 393, width: 60, height: 40))
//        topPosition += viewHeight
//        
//        rigthMarginLeftInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginRight(10).insetLeft(10)
//        expect(view: rigthMarginLeftInsetView, toMatchRect: CGRect(x: 10, y: 433, width: 50, height: 40))
//        topPosition += viewHeight
//        
//        rigthMarginRightInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginRight(10).insetRight(10)
//        expect(view: rigthMarginRightInsetView, toMatchRect: CGRect(x: 0, y: 473, width: 50, height: 40))
//        topPosition += viewHeight
//        
//        rigthMarginLeftRightInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginRight(10).insetLeft(10).insetRight(10)
//        expect(view: rigthMarginLeftRightInsetView, toMatchRect: CGRect(x: 10, y: 513, width: 40, height: 40))
//        topPosition += viewHeight
//        
//        // Left and right margins
//        topPosition += 5
//        leftRightMarginsView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).marginRight(10)
//        expect(view: leftRightMarginsView, toMatchRect: CGRect(x: 10, y: 558, width: 50, height: 40))
//        topPosition += viewHeight
//        
//        leftRightMarginsLeftInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).marginRight(10).insetLeft(10)
//        expect(view: leftRightMarginsLeftInsetView, toMatchRect: CGRect(x: 20, y: 598, width: 40, height: 40))
//        topPosition += viewHeight
//        
//        leftRightMarginsRightInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).marginRight(10).insetRight(10)
//        expect(view: leftRightMarginsRightInsetView, toMatchRect: CGRect(x: 10, y: 638, width: 40, height: 40))
//        topPosition += viewHeight
//
//        leftRightMarginsLeftRightInsetView.pin.top(topPosition).left(leftPosition).bottom(topPosition + viewHeight).right(rightPosition).marginLeft(10).marginRight(10).insetLeft(10).insetRight(10)
//        expect(view: leftRightMarginsLeftRightInsetView, toMatchRect: CGRect(x: 20, y: 678, width: 30, height: 40))
//        topPosition += viewHeight

        contentScrollView.contentSize = CGSize(width: width, height: /*topPosition*/ 1000)
        contentScrollView.contentInset = .zero
    }
}
