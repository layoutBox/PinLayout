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

class AutoAdjustingSizeView: BaseView {

    fileprivate let contentScrollView = UIScrollView()

    var row1 = BasicView(text: "", color: .lightGray)
    var row1Item1 = BasicView(text: "50px", color: .gray)
    var row1Item2 = BasicView(text: "Remaining space", color: .pinLayoutColor)

    var row2 = BasicView(text: "", color: .lightGray)
    var row2Item1 = BasicView(text: "150px", color: .gray)
    var row2Item2 = BasicView(text: "Remaining space", color: .pinLayoutColor)

    var row3 = BasicView(text: "", color: .lightGray)
    var row3Item1 = BasicView(text: "50px", color: .gray)
    var row3Item2 = BasicView(text: "Remaining space", color: .pinLayoutColor)
    var row3Item3 = BasicView(text: "Remaining space", color: .pinLayoutColor)

    var row4 = BasicView(text: "", color: .lightGray)
    var row4Item1 = BasicView(text: "25%", color: .pinLayoutColor)
    var row4Item2 = BasicView(text: "50%", color: .gray)
    var row4Item3 = BasicView(text: "25%", color: .pinLayoutColor)

    override init() {
        super.init()

        contentScrollView.backgroundColor = .white
        addSubview(contentScrollView)

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

        // Layout the contentScrollView using the view's safeArea.
        contentScrollView.pin.all().margin(safeArea)
        
        row1.pin.top().left().right().height(40)
        row1Item1.pin.top().left().bottom().width(50).margin(2)
        row1Item2.pin.right(of: row1Item1, aligned: .top).bottomRight().margin(0, 2, 2, 2)

        row2.pin.below(of: row1, aligned: .left).size(of: row1).marginTop(10)
        row2Item1.pin.top().right().bottom().width(150).width(25%).margin(2)
        row2Item2.pin.left(of: row2Item1, aligned: .top).left().bottom().margin(0, 2, 2, 2)

        row3.pin.below(of: row2, aligned: .left).size(of: row1).marginTop(10)
        row3Item1.pin.topCenter().bottom().width(50).margin(2)
        row3Item2.pin.left(of: row3Item1, aligned: .top).left().bottom().margin(0, 2, 2, 2)
        row3Item3.pin.right(of: row3Item1, aligned: .top).right().bottom().margin(0, 2, 2, 2)

        row4.pin.below(of: row3, aligned: .left).size(of: row1).marginTop(10)
        row4Item1.pin.top().left().width(25%).bottom().margin(2)
        row4Item2.pin.right(of: row4Item1, aligned: .top).width(50%).bottom().margin(0, 2, 2, 2)
        row4Item3.pin.right(of: row4Item2, aligned: .top).right().bottom().margin(0, 2, 2, 2)
        
        contentScrollView.contentSize = CGSize(width: contentScrollView.frame.width, height: row4.frame.maxY)
    }
}
