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

class BasicView: UIView {
    private let label = UILabel()

    init(text: String? = nil, color: UIColor) {
        super.init(frame: .zero)

        backgroundColor = color
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor

        label.text = text
        label.font = .systemFont(ofSize: 7)
        label.textColor = .white
        label.numberOfLines = 0
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        label.pin.top().horizontally().margin(4).sizeToFit(.width)
    }

    var sizeThatFitsExpectedArea: CGFloat = 40 * 40
    var sizeThatFitSizeOffset: CGFloat = 0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = CGSize()
        if size.width != CGFloat.greatestFiniteMagnitude && size.height != CGFloat.greatestFiniteMagnitude {
            newSize.width = 35
            newSize.height = 45
        } else if size.width != CGFloat.greatestFiniteMagnitude {
            newSize.width = size.width + sizeThatFitSizeOffset
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        } else if size.height != CGFloat.greatestFiniteMagnitude {
            newSize.height = size.height + sizeThatFitSizeOffset
            newSize.width = sizeThatFitsExpectedArea / newSize.height
        } else {
            newSize.width = 40
            newSize.height = sizeThatFitsExpectedArea / newSize.width
        }

        return newSize
    }
}
