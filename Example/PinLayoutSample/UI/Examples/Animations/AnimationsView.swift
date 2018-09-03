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

enum LayoutMode: Int {
    case imageLeft
    case imageRight
    case imageTop
    case overImage
}

class AnimationsView: UIView {
    private var currentLayoutMode = LayoutMode.imageLeft

    // This view exists only to support more easily iPhoneX landscape orientation.
    private let safeAreaContainerView = UIView()

    private let textLabel = UILabel()
    private let segmented = UISegmentedControl(items: ["Layout 1", "Layout 2", "Layout 3", "Layout 4"])

    private let houseImageView = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let margin: CGFloat = 10
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let overlayView = UIView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(safeAreaContainerView)

        textLabel.text = "Select the layout mode:"
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        safeAreaContainerView.addSubview(textLabel)

        segmented.selectedSegmentIndex = 0
        segmented.tintColor = .pinLayoutColor
        segmented.addTarget(self, action: #selector(didChangeLayoutMode), for: .valueChanged)
        safeAreaContainerView.addSubview(segmented)

        let url = URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!
        houseImageView.contentMode = .scaleAspectFill
        houseImageView.clipsToBounds = true
        houseImageView.layer.borderColor = UIColor.pinLayoutColor.cgColor
        houseImageView.layer.borderWidth = 1
        houseImageView.download(url: url)
        safeAreaContainerView.addSubview(houseImageView)

        overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        safeAreaContainerView.addSubview(overlayView)

        titleLabel.text = "Castlecrag House"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1
        safeAreaContainerView.addSubview(titleLabel)

        descriptionLabel.text = "The house is located in a unique Sydney bush suburb. The site itself has three particularly special qualities – a beautiful sandstone outcrop to the street, an adjacent bush reserve, and tranquil water views to the bay."
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        safeAreaContainerView.addSubview(descriptionLabel)

        didChangeLayoutMode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // This view exists only to support more easily iPhoneX landscape orientation. On larger
        // screen the view's width is limited to 700 px and centered
        safeAreaContainerView.pin.all(pin.safeArea).maxWidth(700).justify(.center)

        textLabel.pin.top(10).horizontally(margin).sizeToFit(.width)
        segmented.pin.below(of: textLabel, aligned: .left).right(margin).marginTop(4)

        layoutCell()
    }

    private func layoutCell() {
        switch currentLayoutMode {
        case .imageLeft:
            houseImageView.pin.below(of: segmented).left(margin).marginTop(margin).size(140)
            titleLabel.pin.after(of: houseImageView, aligned: .top).marginLeft(margin).sizeToFit()
            descriptionLabel.pin.below(of: titleLabel, aligned: .left).right(margin).marginTop(margin).sizeToFit(.width)

        case .imageRight:
            houseImageView.pin.below(of: segmented).right(margin).marginTop(margin).size(140)
            titleLabel.pin.below(of: segmented, aligned: .left).margin(margin).sizeToFit()
            descriptionLabel.pin.below(of: titleLabel, aligned: .left).before(of: houseImageView).marginTop(margin).marginRight(margin).sizeToFit(.width)

        case .imageTop:
            houseImageView.pin.below(of: segmented).horizontally(margin).marginTop(margin).height(160)
            titleLabel.pin.below(of: houseImageView, aligned: .left).marginTop(margin).sizeToFit()
            descriptionLabel.pin.below(of: titleLabel).horizontally(margin).marginTop(margin).sizeToFit(.width)

        case .overImage:
            houseImageView.pin.below(of: segmented).horizontally(pin.safeArea + margin).marginTop(margin).height(260)
            descriptionLabel.pin.bottomLeft(to: houseImageView.anchor.bottomLeft).right(to: houseImageView.edge.right)
                .margin(margin).sizeToFit(.width)
            titleLabel.pin.above(of: descriptionLabel, aligned: .left).marginBottom(margin).sizeToFit()

            let overlayHeight = houseImageView.frame.maxY - titleLabel.frame.minY + margin
            overlayView.pin.bottomLeft(to: houseImageView.anchor.bottomLeft).right(to: houseImageView.edge.right).height(overlayHeight)
        }

        overlayView.alpha = currentLayoutMode == .overImage ? 1 : 0
    }

    @objc private func didChangeLayoutMode() {
        guard let layoutMode = LayoutMode(rawValue: segmented.selectedSegmentIndex) else { return }
        guard layoutMode != currentLayoutMode else { return }
        self.currentLayoutMode = layoutMode

        UIView.animate(withDuration: 0.3) {
            self.layoutCell()
        }
    }
}
