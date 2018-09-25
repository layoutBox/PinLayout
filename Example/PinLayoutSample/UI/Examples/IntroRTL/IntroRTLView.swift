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

class IntroRTLView: UIView {
    private let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    private let segmented = UISegmentedControl(items: ["Intro", "1", "2"])
    private let textLabel = UILabel()
    private let separatorView = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        // PinLayout will detect automatically the layout direction based on 
        // `UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)` (>= iOS 9) or 
        // `UIApplication.shared.userInterfaceLayoutDirection` (< iOS 9)
        Pin.layoutDirection(.auto)
        
        logo.contentMode = .scaleAspectFit
        addSubview(logo)
        
        segmented.selectedSegmentIndex = 0
        segmented.tintColor = .pinLayoutColor
        addSubview(segmented)

        if isLTR() {
            textLabel.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable."
        } else {
            textLabel.text = "ان هذا وكسبت وقدّموا التاريخ،, قد مكن ووصف يعبأ واُسدل. لإنعدام الأبرياء أسر ان. فقد و أراض إتفاقية, حدى و غضون وبولندا الأوروبيّون, لم العصبة معاملة مما. بـ يكن أمّا واُسدل مهمّات. بأيدي الفرنسي بـ نفس, تصفح لفرنسا بها في. لان قد الأوروبي الأوروبية, قد جُل أحدث وحرمان اليميني."
        }

        textLabel.font = .systemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        addSubview(textLabel)
        
        separatorView.pin.height(1)
        separatorView.backgroundColor = .pinLayoutColor
        addSubview(separatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        Pin.layoutDirection(.ltr)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 10
        
        logo.pin.top(pin.safeArea).start(pin.safeArea).width(100).aspectRatio().margin(padding)
        segmented.pin.after(of: logo, aligned: .top).end(pin.safeArea).marginHorizontal(padding)
        textLabel.pin.below(of: segmented, aligned: .start).width(of: segmented).pinEdges().marginTop(10).sizeToFit(.width)
        separatorView.pin.below(of: [logo, textLabel], aligned: .start).end(to: segmented.edge.end).marginTop(10)
    }
}
