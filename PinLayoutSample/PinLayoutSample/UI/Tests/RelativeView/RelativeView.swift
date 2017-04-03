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

class RelativeView: UIView {
    fileprivate let belowNavBarView = BasicView(text: "Below navbar", color: UIColor.lightGray)
    
    var rootView: BasicView!
    
    private let centerView = UIView()
    
    private let topLeftView = UIView()
    private let topCenterView = UIView()
    private let topRightView = UIView()
    
    private let leftTopView = UIView()
    private let leftCenterView = UIView()
    private let leftBottomView = UIView()
    
    private let bottomLeftView = UIView()
    private let bottomCenterView = UIView()
    private let bottomRightView = UIView()
    
    private let rightTopView = UIView()
    private let rightCenterView = UIView()
    private let rightBottomView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(belowNavBarView)
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        centerView.backgroundColor = .blue
        rootView.addSubview(centerView)
        
        addSquare(topLeftView, color: .green)
        addSquare(topCenterView, color: .yellow)
        addSquare(topRightView, color: .purple)
        
        addSquare(leftTopView, color: .magenta)
        addSquare(leftCenterView, color: .cyan)
        addSquare(leftBottomView, color: .purple)
        
        addSquare(bottomLeftView, color: .black)
        addSquare(bottomCenterView, color: .red)
        addSquare(bottomRightView, color: .gray)
        
        addSquare(rightTopView, color: .black)
        addSquare(rightCenterView, color: .red)
        addSquare(rightBottomView, color: .gray)
    }
    
    fileprivate func addSquare(_ view: UIView, color: UIColor) {
        view.backgroundColor = color
        view.pin.width(50).height(50)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        belowNavBarView.pin.topLeft().bottomRight().marginTop(64)
        
        rootView.frame = CGRect(x: 0, y: 64, width: 400, height: 400)
        centerView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
//        centerView.width = 200
//        centerView.height = 200
//        centerView.center = CGPoint(x: 200, y: 300)
        
        topLeftView.pin.above(of: centerView, aligned: .left)
        topCenterView.pin.above(of: centerView, aligned: .center)
        topRightView.pin.above(of: centerView, aligned: .right)
        
        leftTopView.pin.left(of: centerView, aligned: .top)
        leftCenterView.pin.left(of: centerView, aligned: .center)
        leftBottomView.pin.left(of: centerView, aligned: .bottom)
        
        bottomLeftView.pin.below(of: centerView, aligned: .left)
        bottomCenterView.pin.below(of: centerView, aligned: .center)
        bottomRightView.pin.below(of: centerView, aligned: .right)

        rightTopView.pin.right(of: centerView, aligned: .top)
        rightCenterView.pin.right(of: centerView, aligned: .center)
        rightBottomView.pin.right(of: centerView, aligned: .bottom)
    }
}
