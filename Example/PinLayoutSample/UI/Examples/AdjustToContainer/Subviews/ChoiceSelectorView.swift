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

class ChoiceSelectorView: UIView {

    fileprivate let textLabel = UILabel()
    fileprivate let segmentedControl = UISegmentedControl()
    
    init(text: String, choices: [String]) {
        super.init(frame: .zero)

        textLabel.text = text
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        addSubview(textLabel)
        
        choices.forEach({ segmentedControl.insertSegment(withTitle: $0, at: segmentedControl.numberOfSegments, animated: false) })
        segmentedControl.tintColor = .pinLayoutColor
        segmentedControl.sizeToFit()
        addSubview(segmentedControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = layout(size: frame.size)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return layout(size: size)
    }
    
    fileprivate func layout(size: CGSize) -> CGSize {
        let width = size.width
        let margin: CGFloat = 12
        
        if frame.width > 500 {
            // The UISegmentedControl is at the top-right corner and the label takes the remaining horizontal space.
            segmentedControl.pin.top().right().margin(margin)
            textLabel.pin.top().left().left(of: segmentedControl).margin(margin).fitSize()
        } else {
            // The UISegmentedControl is placed below the label.
            textLabel.pin.top().left().right().margin(margin).fitSize()
            segmentedControl.pin.below(of: textLabel).right().margin(margin)
        }
        
        return CGSize(width: width, height: max(textLabel.frame.maxY, segmentedControl.frame.maxY) + margin)
    }
}
