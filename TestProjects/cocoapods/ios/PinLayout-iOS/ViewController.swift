
import UIKit
import PinLayout

class ViewController: UIViewController {
    // PinLayout
    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    fileprivate let label1 = UILabel()
    fileprivate let label2 = UILabel()
    fileprivate let label3 = UILabel()

    // FlexLayout
    fileprivate let flexContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.layer.borderColor = UIColor.black.cgColor
        logo.layer.borderWidth = 1
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)

        label1.text = "PinLayout Label 1"
        label1.font = .systemFont(ofSize: 14)
        view.addSubview(label1)

        label2.text = "PinLayout Label 2"
        label2.font = .systemFont(ofSize: 14)
        view.addSubview(label2)

        label3.text = "PinLayout Label 3"
        label3.font = .systemFont(ofSize: 14)
        view.addSubview(label3)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // PinLayout
        logo.pin.top().left().size(100).margin(topLayoutGuide.length + 10, 10, 10)
        label1.pin.after(of: logo, aligned: .top).right().marginHorizontal(10).sizeToFit(.width)
        label2.pin.after(of: logo, aligned: .center).right().marginHorizontal(10).sizeToFit(.width)
        label3.pin.after(of: logo, aligned: .bottom).right().marginHorizontal(10).sizeToFit(.width)
    }
}

