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
import PinLayout

class PinScrollingView: UIView {

    private let contentScrollView = UIScrollView()

    var aView: BasicView!
    var bView: BasicView!
    var cView: BasicView!
    var dView: BasicView!

    var row1 = BasicView(text: "", color: UIColor.lightGray)
    var row1Item1 = BasicView(text: "50px", color: UIColor.blue)
    var row1Item2 = BasicView(text: "Remaining space", color: UIColor.red)

    var row2 = BasicView(text: "", color: UIColor.lightGray)
    var row2Item1 = BasicView(text: "50px", color: UIColor.blue)
    var row2Item2 = BasicView(text: "Remaining space", color: UIColor.red)

    var row3 = BasicView(text: "", color: UIColor.lightGray)
    var row3Item1 = BasicView(text: "50px", color: UIColor.blue)
    var row3Item2 = BasicView(text: "Remaining space", color: UIColor.red)
    var row3Item3 = BasicView(text: "Remaining space", color: UIColor.red)

    var row4 = BasicView(text: "", color: UIColor.lightGray)
    var row4Item1 = BasicView(text: "25%", color: UIColor.red)
    var row4Item2 = BasicView(text: "50%", color: UIColor.blue)
    var row4Item3 = BasicView(text: "25%", color: UIColor.red)

    init() {
        super.init(frame: .zero)

        backgroundColor = .white

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

        contentScrollView.addSubview(row1)
        row1.addSubview(row1Item1)
        row1.addSubview(row1Item2)

        contentScrollView.addSubview(row2)
        row2.addSubview(row2Item1)
        row2.addSubview(row2Item2)

        contentScrollView.addSubview(row3)
        row3.addSubview(row3Item1)
        row3.addSubview(row3Item2)
        row3.addSubview(row3Item3)

        contentScrollView.addSubview(row4)
        row4.addSubview(row4Item1)
        row4.addSubview(row4Item2)
        row4.addSubview(row4Item3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentScrollView.pin.topLeft().bottomRight().marginTop(64)
        contentScrollView.contentSize = CGSize(width: width, height: height * 2)
        contentScrollView.contentInset = .zero
        
        aView.pin.top(0).left(0).right(0).height(40).margin(10)
        layoutBView()

        cView.pin.below(of: aView, aligned: .right).width(100).height(50).marginTop(10)
        dView.pin.below(of: aView, aligned: .left).left(of: cView).height(of: cView).marginTop(10).marginRight(10)

        row1.pin.below(of: dView, aligned: .left).size(of: aView).marginTop(10)
        row1Item1.pin.topLeft().bottom().width(50).margin(2)
        row1Item2.pin.right(of: row1Item1, aligned: .top).bottomRight().margin(0, 2, 2, 2)

        row2.pin.below(of: row1, aligned: .left).size(of: aView).marginTop(10)
        row2Item1.pin.topRight().bottom().width(20).width(25%).margin(2)
        row2Item2.pin.left(of: row2Item1, aligned: .top).bottomLeft().margin(0, 2, 2, 2)

        row3.pin.below(of: row2, aligned: .left).size(of: aView).marginTop(10)
        row3Item1.pin.topCenter().width(50).bottom().margin(2)
        row3Item2.pin.left(of: row3Item1, aligned: .top).bottomLeft().margin(0, 2, 2, 2)
        row3Item3.pin.right(of: row3Item1, aligned: .top).bottomRight().margin(0, 2, 2, 2)

        row4.pin.below(of: row3, aligned: .left).size(of: aView).marginTop(10)
        row4Item1.pin.topLeft().width(25%).bottom().margin(2)
        row4Item2.pin.right(of: row4Item1, aligned: .top).width(50%).bottom().margin(0, 2, 2, 2)
        row4Item3.pin.right(of: row4Item2, aligned: .top).bottomRight().margin(0, 2, 2, 2)
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
