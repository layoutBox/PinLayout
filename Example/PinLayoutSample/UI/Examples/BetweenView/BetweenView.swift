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

class BetweenView: UIView {
    private let view1 = BasicView(text: "Relative view 1 (width: 20%, height: 50%)", color: .lightGray)
    private let view2 = BasicView(text: "Relative view 2 (width: 20%, height: 50%)", color: .lightGray)
    private let view = BasicView(text: "View layouted using method horizontallyBetween: \n  - horizontallyBetween(view1, and: view2, aligned: .top)",
                                 color: .pinLayoutColor)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    
        addSubview(view1)
        addSubview(view2)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view1.pin.top(pin.safeArea).left(pin.safeArea).width(20%).height(50%)
        view2.pin.top(pin.safeArea).right(pin.safeArea).width(20%).height(50%)

        view.pin.horizontallyBetween(view1, and: view2, aligned: .top).height(of: view1).marginHorizontal(10)
    }
}
