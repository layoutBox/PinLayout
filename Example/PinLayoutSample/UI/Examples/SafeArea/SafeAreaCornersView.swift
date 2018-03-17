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

class SafeAreaCornersView: UIView {
    fileprivate let safeAreaZoneView = UIView()

    fileprivate let centerImageView = UIImageView(image: UIImage(named: "Center")!)

    // Corners
    fileprivate let topLeftImageView = UIImageView(image: UIImage(named: "ArrowCorner")!)
    fileprivate let topRightImageView = UIImageView(image: UIImage(named: "ArrowCorner")!)
    fileprivate let bottomRightImageView = UIImageView(image: UIImage(named: "ArrowCorner")!)
    fileprivate let bottomLeftImageView = UIImageView(image: UIImage(named: "ArrowCorner")!)

    // Edges
    fileprivate let topImageView = UIImageView(image: UIImage(named: "Arrow")!)
    fileprivate let rightImageView = UIImageView(image: UIImage(named: "Arrow")!)
    fileprivate let bottomImageView = UIImageView(image: UIImage(named: "Arrow")!)
    fileprivate let leftImageView = UIImageView(image: UIImage(named: "Arrow")!)

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        safeAreaZoneView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        addSubview(safeAreaZoneView)

        addSubview(centerImageView)

        addSubview(topLeftImageView)
        topRightImageView.transform = .init(rotationAngle: CGFloat.pi / 2)
        addSubview(topRightImageView)
        bottomRightImageView.transform = .init(rotationAngle: CGFloat.pi)
        addSubview(bottomRightImageView)
        bottomLeftImageView.transform = .init(rotationAngle: CGFloat.pi * 3 / 2)
        addSubview(bottomLeftImageView)

        addSubview(topImageView)
        rightImageView.transform = .init(rotationAngle: CGFloat.pi / 2)
        addSubview(rightImageView)
        bottomImageView.transform = .init(rotationAngle: CGFloat.pi)
        addSubview(bottomImageView)
        leftImageView.transform = .init(rotationAngle: CGFloat.pi * 3 / 2)
        addSubview(leftImageView)
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

        safeAreaZoneView.pin.all(pin.safeArea)

        centerImageView.pin.center().size(40)

        topRightImageView.pin.top(pin.safeArea).right(pin.safeArea).size(40)
        topLeftImageView.pin.top(pin.safeArea).left(pin.safeArea).size(40)
        bottomRightImageView.pin.bottom(pin.safeArea).right(pin.safeArea).size(40)
        bottomLeftImageView.pin.bottom(pin.safeArea).left(pin.safeArea).size(40)

        topImageView.pin.top(pin.safeArea).hCenter().size(40)
        rightImageView.pin.right(pin.safeArea).vCenter().size(40)
        bottomImageView.pin.bottom(pin.safeArea).hCenter().size(40)
        leftImageView.pin.left(pin.safeArea).vCenter().size(40)
    }
}
