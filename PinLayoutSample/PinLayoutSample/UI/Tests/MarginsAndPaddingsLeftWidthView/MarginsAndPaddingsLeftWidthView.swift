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
        view.pin.height(30).width(70)
        contentScrollView.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftPosition: CGFloat = 0
        
//        contentScrollView.pin.topLeft().width(width).height(height).insetTop(64)
//        
//        descriptionLabel.size = descriptionLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
//        descriptionLabel.pin.topLeft(to: CGPoint(x: leftPosition, y: 10))
//        
//        // No margins
//        noMarginsNoPaddings.pin.topLeft(to: descriptionLabel.anchor.bottomLeft).marginTop(5)
//        noMarginsLeftInsetView.pin.top(noMarginsNoPaddings.bottom).left(leftPosition).width(70).insetLeft(10)
//        noMarginsRightInsetView.pin.top(noMarginsLeftInsetView.bottom).left(leftPosition).width(70).insetRight(10)
//        noMarginsLeftRightInsetView.pin.top(noMarginsRightInsetView.bottom).left(leftPosition).width(70).insetLeft(10).insetRight(10)
//        
//        // Left margin
//        leftMarginView.pin.top(noMarginsLeftRightInsetView.bottom + 5).left(leftPosition).width(70).marginLeft(10)
//        leftMarginLeftInsetView.pin.top(leftMarginView.bottom).left(leftPosition).width(70).marginLeft(10).insetLeft(10)
//        leftMarginRightInsetView.pin.top(leftMarginLeftInsetView.bottom).left(leftPosition).width(70).marginLeft(10).insetRight(10)
//        leftMarginLeftRightInsetView.pin.top(leftMarginRightInsetView.bottom).left(leftPosition).width(70).marginLeft(10).insetLeft(10).insetRight(10)
//        
//        // Right margin
//        rigthMarginView.pin.top(leftMarginLeftRightInsetView.bottom + 5).left(leftPosition).width(70).marginRight(10)
//        rigthMarginLeftInsetView.pin.top(rigthMarginView.bottom).left(leftPosition).width(70).marginRight(10).insetLeft(10)
//        rigthMarginRightInsetView.pin.top(rigthMarginLeftInsetView.bottom).left(leftPosition).width(70).marginRight(10).insetRight(10)
//        rigthMarginLeftRightInsetView.pin.top(rigthMarginRightInsetView.bottom).left(leftPosition).width(70).marginRight(10).insetLeft(10).insetRight(10)
//        
//        // Left and right margins
//        leftRightMarginsView.pin.top(rigthMarginLeftRightInsetView.bottom + 5).left(leftPosition).width(70).marginLeft(10).marginRight(10)
//        leftRightMarginsLeftInsetView.pin.top(leftRightMarginsView.bottom).left(leftPosition).width(70).marginLeft(10).marginRight(10).insetLeft(10)
//        leftRightMarginsRightInsetView.pin.top(leftRightMarginsLeftInsetView.bottom).left(leftPosition).width(70).marginLeft(10).marginRight(10).insetRight(10)
//        leftRightMarginsLeftRightInsetView.pin.top(leftRightMarginsRightInsetView.bottom).left(leftPosition).width(70).marginLeft(10).marginRight(10).insetLeft(10).insetRight(10)
//        
        // Top Margin
//        noMarginsNoPaddings2.layout2.top(leftRightMarginsLeftRightInsetView.bottom + 5).left(leftPosition).width(70).height(30)
//        topMarginView.layout2.top(noMarginsNoPaddings2.top).left(noMarginsNoPaddings2.right).width(70).height(30).marginTop(10)
//        topMarginTopPaddingView.layout2.top(topMarginView.top).left(topMarginView.right).width(70).height(30).marginTop(10).insetTop(10)
//        topMarginBottomPaddingView.layout2.top(topMarginView.top).left(topMarginTopPaddingView.right).width(70).height(30).marginTop(10).bottomPadding(10)
//        topMarginTopBottomPaddingView.layout2.top(topMarginView.top).left(topMarginBottomPaddingView.right).width(70).height(30).marginTop(10).insetTop(10).bottomPadding(10)
        
        contentScrollView.contentSize = CGSize(width: width, height: leftRightMarginsLeftRightInsetView.bottom)
        contentScrollView.contentInset = UIEdgeInsets.zero
    }
}
