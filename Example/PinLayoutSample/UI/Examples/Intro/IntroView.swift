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

class IntroView: BaseView {

    fileprivate let container = UIView()
    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    fileprivate let segmented = UISegmentedControl(items: ["Intro", "1", "2"])
    fileprivate let textLabel = UILabel()
    fileprivate let separatorView = UIView()
    
    override init() {
        super.init()

        logo.contentMode = .scaleAspectFit
        addSubview(logo)
        
        segmented.selectedSegmentIndex = 0
        segmented.tintColor = .pinLayoutColor
        addSubview(segmented)
        
        textLabel.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable."
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        addSubview(textLabel)
        
        separatorView.pin.height(1)
        separatorView.backgroundColor = .pinLayoutColor
        addSubview(separatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        logo.pin.top().left().size(100).margin(topLayoutGuide + 10, 10, 10)
        segmented.pin.right(of: logo, aligned: .top).right().marginHorizontal(10)
        textLabel.pin.below(of: segmented, aligned: .left).width(of: segmented).pinEdges().marginTop(10).fitSize()
        separatorView.pin.below(of: [logo, textLabel], aligned: .left).right(to: segmented.edge.right).marginTop(10)
    }
}
