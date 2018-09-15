import Foundation

class AreaView: UIView {
    private let nameLabel = UILabel()

    init(name: String, color: UIColor) {
        super.init(frame: .zero)

        layer.borderColor = color.cgColor
        layer.borderWidth = 2

        nameLabel.text = name
        nameLabel.textColor = color
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.layer.anchorPoint = CGPoint(x: 0, y: 1)
        nameLabel.transform = .init(rotationAngle: (CGFloat.pi / 2))
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.pin.topLeft(1).sizeToFit()
    }
}
