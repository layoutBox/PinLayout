import Foundation

class MethodReadableInsetsCell: UITableViewCell {
    static let reuseIdentifier = "MethodReadableInsetsCell"

    private let iconImageView = UIImageView(image: UIImage(named: "method"))
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let margin: CGFloat = 10

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        separatorInset = .zero
        preservesSuperviewLayoutMargins = false

        contentView.addSubview(iconImageView)

        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(nameLabel)

        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure(method: Method) {
        nameLabel.text = method.name
        descriptionLabel.text = method.description
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    private func layout() {
        // 1) Layout the contentView
        contentView.pin.top(margin).horizontally(pin.readableMargins)

        // 2) Layout contentView's childs
        iconImageView.pin.topLeft().size(30)
        nameLabel.pin.after(of: iconImageView, aligned: .center).right().marginHorizontal(margin).sizeToFit(.width)
        descriptionLabel.pin.below(of: [iconImageView, nameLabel]).horizontally().marginTop(margin).sizeToFit(.width)

        // 3) Adjust the contentView size to wrap its childs
        contentView.pin.wrapContent(.vertically)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the width to the specified size parameter
        pin.width(size.width)

        // 2) Layout the contentView's controls
        layout()

        // 3) Returns a size that contains all views
        return CGSize(width: size.width, height: contentView.frame.maxY + margin)
    }
}
