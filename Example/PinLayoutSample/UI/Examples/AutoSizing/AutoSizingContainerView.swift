import UIKit

final class AutoSizingContainerView: UIView {
    private let imageView = UIImageView()
    private let firstTextLabel = UILabel()
    private let secondTextLabel = UILabel()

    private let margin: CGFloat = 10

    @Proxy(\AutoSizingContainerView.imageView.image)
    var image: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }

    @Proxy(\AutoSizingContainerView.firstTextLabel.text)
    var firstText: String? {
        didSet {
            setNeedsLayout()
        }
    }

    @Proxy(\AutoSizingContainerView.secondTextLabel.text)
    var secondText: String? {
        didSet {
            setNeedsLayout()
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)

        firstTextLabel.numberOfLines = 0
        firstTextLabel.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        addSubview(firstTextLabel)

        secondTextLabel.numberOfLines = 0
        secondTextLabel.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        addSubview(secondTextLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        performLayout()
    }

    private func performLayout() {
        imageView.pin.top().horizontally().sizeToFit(.width).margin(margin)
        firstTextLabel.pin.below(of: imageView).horizontally().sizeToFit(.width).margin(margin)
        secondTextLabel.pin.below(of: firstTextLabel).horizontally().sizeToFit(.width).margin(margin)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        autoSizeThatFits(size, layoutClosure: performLayout)
    }
}
