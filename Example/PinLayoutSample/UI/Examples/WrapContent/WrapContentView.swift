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

class WrapContentView: UIView {
    private let scrollView = UIScrollView()

    private let topContainer = UIView()
    private let topLogo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let topLabel = UILabel()

    private let separatorView1 = UIView()

    private let middleContainer = UIView()
    private let middleLabel = UILabel()
    private let button1 = UIButton(type: .custom)
    private let button2 = UIButton(type: .custom)
    private let button3 = UIButton(type: .custom)

    private let separatorView2 = UIView()

    private let bottomContainer = UIView()
    private let bottomLogo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let bottomLabel = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(scrollView)

        topContainer.backgroundColor = .lightColor
        scrollView.addSubview(topContainer)

        //
        // Top section
        //
        topLogo.contentMode = .scaleAspectFit
        topContainer.addSubview(topLogo)

        configureLabel(topLabel, text: "This view use 'pin.wrapContent()' to wrap its subviews (logo and label). This view horizontally center at the top.")
        topContainer.addSubview(topLabel)

        // Separator 1
        separatorView1.pin.height(1)
        separatorView1.backgroundColor = .pinLayoutColor
        scrollView.addSubview(separatorView1)

        //
        // Middle section
        //
        middleContainer.backgroundColor = .lightColor
        scrollView.addSubview(middleContainer)

        configureLabel(middleLabel, text: "This view use 'pin.wrapContent()' to wrap its subviews (1 label and 3 buttons). This view is horizontally centered.")
        middleContainer.addSubview(middleLabel)

        button1.setTitle("Button 1", for: .normal)
        button1.setTitleColor(.black, for: .normal)
        button1.sizeToFit()
        middleContainer.addSubview(button1)

        button2.setTitle("Button 2", for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button2.sizeToFit()
        middleContainer.addSubview(button2)

        button3.setTitle("Button 3", for: .normal)
        button3.setTitleColor(.black, for: .normal)
        button3.sizeToFit()
        middleContainer.addSubview(button3)

        // Separator 2
        separatorView2.pin.height(1)
        separatorView2.backgroundColor = .pinLayoutColor
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } 
        scrollView.addSubview(separatorView2)

        //
        // Bottom section
        //
        bottomContainer.backgroundColor = .lightColor
        scrollView.addSubview(bottomContainer)

        bottomLogo.contentMode = .scaleAspectFit
        bottomContainer.addSubview(bottomLogo)

        configureLabel(bottomLabel, text: "This view use 'pin.wrapContent()' to wrap its subviews (logo and label). This view is horizontally centered. This view is vertically center in the region between the separator and the bottom of the screen using '.align(.center)'")
        bottomContainer.addSubview(bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 10

        scrollView.pin.all()
        
        // Top section
        topLogo.pin.width(100).aspectRatio()
        topLabel.pin.below(of: topLogo, aligned: .center).width(260).sizeToFit(.width).marginTop(padding)
        topContainer.pin.wrapContent(padding: 4).top(pin.safeArea.top + padding).hCenter()

        // Separator1
        separatorView1.pin.below(of: topContainer, aligned: .center).width(80%).marginTop(padding)

        middleLabel.pin.width(260).sizeToFit(.width)
        button2.pin.below(of: middleLabel, aligned: .center).marginTop(padding)
        button1.pin.before(of: button2, aligned: .center).marginRight(padding)
        button3.pin.after(of: button2, aligned: .center).marginLeft(padding)
        middleContainer.pin.wrapContent(padding: 4).below(of: separatorView1).hCenter().marginTop(padding)

        // Separator2
        separatorView2.pin.below(of: middleContainer, aligned: .center).width(80%).marginTop(padding)

        // Bottom section
        bottomLogo.pin.width(50).aspectRatio()
        bottomLabel.pin.after(of: bottomLogo, aligned: .top).width(200).marginLeft(10).sizeToFit(.width)
        bottomContainer.pin.wrapContent(padding: 30).below(of: separatorView2).hCenter().marginTop(padding)

        scrollView.contentSize = CGSize(width: frame.width, height: bottomContainer.frame.maxY)
    }

    private func configureLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
}
