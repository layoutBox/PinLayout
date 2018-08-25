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

class SafeAreaAndMarginsView: UIView {
    private let safeAreaView = AreaView(name: "pin.safeArea",
                                        color: UIColor(red: 0.02, green: 0.20, blue: 0.29, alpha: 1))
    private let layoutMarginsAreaView = AreaView(name: "pin.layoutMargins",
                                                 color: UIColor(red: 0.1, green: 0.49, blue: 0.58, alpha: 1))
    private let readableMarginsView = AreaView(name: "                                  pin.readableMargins",
                                               color: UIColor(red: 0.15, green: 0.60, blue: 0.89, alpha: 1))

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(safeAreaView)
        addSubview(layoutMarginsAreaView)
        addSubview(readableMarginsView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.safeAreaInsetsDidChange()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        safeAreaView.pin.all(pin.safeArea)
        layoutMarginsAreaView.pin.all(pin.layoutMargins)
        readableMarginsView.pin.all(pin.readableMargins)
    }
}
