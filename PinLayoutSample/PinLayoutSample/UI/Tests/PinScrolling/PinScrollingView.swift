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
