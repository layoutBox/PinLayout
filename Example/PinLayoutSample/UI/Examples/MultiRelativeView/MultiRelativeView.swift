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

class MultiRelativeView: BaseView {
    fileprivate let contentView = UIView()
    fileprivate let view1 = BasicView(text: "Relative view 1 (width: 20%, height: 50%)", color: .lightGray)
    fileprivate let view2 = BasicView(text: "Relative view 2 (width: 20%, height: 50%)", color: .lightGray)
    fileprivate let view = BasicView(text: "View layouted using two relative views: \n  - right(of: view1, aligned: .top)\n  - left(of: view2, aligned: .bottom)",
                                     color: .pinLayoutColor)
    
    override init() {
        super.init()
    
        addSubview(contentView)

        contentView.addSubview(view1)
        contentView.addSubview(view2)
        contentView.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the contentView using the view's safeArea.
        contentView.pin.all().margin(safeArea)
        
        view1.pin.top().left().width(20%).height(50%)
        view2.pin.top().right().width(20%).height(50%)
        
        view.pin.right(of: view1, aligned: .top).left(of: view2, aligned: .bottom).marginHorizontal(10)
    }
}
