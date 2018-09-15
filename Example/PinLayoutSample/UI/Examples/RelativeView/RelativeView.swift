//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import PinLayout

class RelativeView: UIView {
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
    
    private let relativeView = UIView()
    private let childRelativeView = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
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
    
    private func addSquare(_ view: UIView, color: UIColor) {
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
        
        rightTopView.pin.after(of: centerView, aligned: .top).marginLeft(10)
        rightCenterView.pin.after(of: centerView, aligned: .center).marginLeft(10)
        rightBottomView.pin.after(of: centerView, aligned: .bottom).marginLeft(10)
        
        bottomLeftView.pin.below(of: centerView, aligned: .left).marginTop(10)
        bottomCenterView.pin.below(of: centerView, aligned: .center).marginTop(10)
        bottomRightView.pin.below(of: centerView, aligned: .right).marginTop(10)

        leftTopView.pin.before(of: centerView, aligned: .top).marginRight(10)
        leftCenterView.pin.before(of: centerView, aligned: .center).marginRight(10)
        leftBottomView.pin.before(of: centerView, aligned: .bottom).marginRight(10)
    }
}
