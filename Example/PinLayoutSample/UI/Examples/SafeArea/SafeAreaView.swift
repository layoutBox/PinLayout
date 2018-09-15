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

class SafeAreaView: UIView {
    private let topTextLabel = UILabel()
    private let scanButton = RoundedButton(text: "Scan", icon: UIImage(named: "Barcode")!)
    private let iconImageView = UIImageView(image: UIImage(named: "IconOrder")!)
    private let textLabel = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        topTextLabel.text = "Add items to your cart"
        topTextLabel.textColor = UIColor.darkGray
        topTextLabel.font = UIFont.boldSystemFont(ofSize: 22)
        topTextLabel.sizeToFit()
        addSubview(topTextLabel)

        addSubview(scanButton)
        addSubview(iconImageView)

        textLabel.text = "Scan the item's barcode to add it to your cart"
        textLabel.textColor = UIColor.lightGray
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.boldSystemFont(ofSize: 17)
        addSubview(textLabel)
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

        topTextLabel.pin.top(pin.safeArea.top + 10).hCenter()
        iconImageView.pin.hCenter().vCenter(-10%)
        textLabel.pin.below(of: iconImageView).hCenter().width(60%).maxWidth(400).marginTop(20).sizeToFit(.width)
        scanButton.pin.bottom(pin.safeArea.bottom + 5).hCenter().width(80%).maxWidth(300).height(40)
    }
}
