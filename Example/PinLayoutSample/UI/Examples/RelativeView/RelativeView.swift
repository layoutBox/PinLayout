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

class RelativeView: BaseView {
    fileprivate let centerView = UIView()
    
    fileprivate let topLeftView = UIView()
    fileprivate let topCenterView = UIView()
    fileprivate let topRightView = UIView()
    
    fileprivate let leftTopView = UIView()
    fileprivate let leftCenterView = UIView()
    fileprivate let leftBottomView = UIView()
    
    fileprivate let bottomLeftView = UIView()
    fileprivate let bottomCenterView = UIView()
    fileprivate let bottomRightView = UIView()
    
    fileprivate let rightTopView = UIView()
    fileprivate let rightCenterView = UIView()
    fileprivate let rightBottomView = UIView()
    
    fileprivate let relativeView = UIView()
    fileprivate let childRelativeView = UIView()
    
    override init() {
        super.init()
        
        centerView.backgroundColor = .pinLayoutColor
        addSubview(centerView)
        
        addSquare(topLeftView, color: .lightGray)
        addSquare(topCenterView, color: .gray)
        addSquare(topRightView, color: .lightGray)
        
        addSquare(leftTopView, color: .lightGray)
        addSquare(leftCenterView, color: .gray)
        addSquare(leftBottomView, color: .lightGray)
        
        addSquare(bottomLeftView, color: .lightGray)
        addSquare(bottomCenterView, color: .gray)
        addSquare(bottomRightView, color: .lightGray)
        
        addSquare(rightTopView, color: .lightGray)
        addSquare(rightCenterView, color: .gray)
        addSquare(rightBottomView, color: .lightGray)
    }
    
    fileprivate func addSquare(_ view: UIView, color: UIColor) {
        view.backgroundColor = color
        view.pin.size(40)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerView.pin.center().size(150)
        
        topLeftView.pin.above(of: centerView, aligned: .left).marginBottom(10)
        topCenterView.pin.above(of: centerView, aligned: .center).marginBottom(10)
        topRightView.pin.above(of: centerView, aligned: .right).marginBottom(10)
        
        rightTopView.pin.right(of: centerView, aligned: .top).marginLeft(10)
        rightCenterView.pin.right(of: centerView, aligned: .center).marginLeft(10)
        rightBottomView.pin.right(of: centerView, aligned: .bottom).marginLeft(10)
        
        bottomLeftView.pin.below(of: centerView, aligned: .left).marginTop(10)
        bottomCenterView.pin.below(of: centerView, aligned: .center).marginTop(10)
        bottomRightView.pin.below(of: centerView, aligned: .right).marginTop(10)

        leftTopView.pin.left(of: centerView, aligned: .top).marginRight(10)
        leftCenterView.pin.left(of: centerView, aligned: .center).marginRight(10)
        leftBottomView.pin.left(of: centerView, aligned: .bottom).marginRight(10)
    }
}
