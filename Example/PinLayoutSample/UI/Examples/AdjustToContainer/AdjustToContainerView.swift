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

class AdjustToContainerView: UIView {
    private let languageSelectorView = ChoiceSelectorView(text: "What is your favorite language?", choices: ["Swift", "Objective-C", "C++"])
    private let swiftOpinionSelector = ChoiceSelectorView(text: "Overall, are you satisfied with the Swift performance in your projects?", choices: ["Yes", "No"])
    private let swiftUsageSelector = ChoiceSelectorView(text: "How often do you typically use Swift?", choices: ["Daily", "Weekly", "Montly", "Do not use"])
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(languageSelectorView)
        addSubview(swiftOpinionSelector)
        addSubview(swiftUsageSelector)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        languageSelectorView.pin.top(pin.safeArea).horizontally(pin.safeArea).sizeToFit(.width)
        swiftOpinionSelector.pin.below(of: languageSelectorView).horizontally(pin.safeArea).marginTop(10).sizeToFit(.width)
        swiftUsageSelector.pin.below(of: swiftOpinionSelector).horizontally(pin.safeArea).marginTop(10).sizeToFit(.width)
    }
}
