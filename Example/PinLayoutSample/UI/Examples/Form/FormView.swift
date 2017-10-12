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

extension PinLayout {
    func toto() {
        
    }
}

class FormView: BaseFormView {
    
    fileprivate let formContainerView = UIView()
    fileprivate let formTitleLabel = UILabel()
    fileprivate let nameField = UITextField()
    
    fileprivate let ageSwitch = UISwitch()
    fileprivate let ageField = UITextField()
    
    fileprivate let addressField = UITextField()

    override init() {
        super.init()
        
        formContainerView.backgroundColor = UIColor.pinLayoutColor.withAlphaComponent(0.3)
        formContainerView.layer.cornerRadius = 5
        formScrollView.addSubview(formContainerView)
    
        formTitleLabel.text = "Simple Form Example"
        formTitleLabel.font = .boldSystemFont(ofSize: 14)
        formTitleLabel.sizeToFit()
        formContainerView.addSubview(formTitleLabel)
        
        nameField.placeholder = "Name"
        nameField.layer.borderColor = UIColor.gray.cgColor
        nameField.layer.borderWidth = 1
        formContainerView.addSubview(nameField)
        
        ageSwitch.tintColor = .lightGray
        ageSwitch.addTarget(self, action: #selector(didChangeAgeSwitch), for: .valueChanged)
        formContainerView.addSubview(ageSwitch)
        
        ageField.placeholder = "Age"
        ageField.alpha = 0
        ageField.layer.borderColor = UIColor.gray.cgColor
        ageField.layer.borderWidth = 1
        formContainerView.addSubview(ageField)
        
        addressField.placeholder = "Address"
        addressField.layer.borderColor = UIColor.gray.cgColor
        addressField.layer.borderWidth = 1
        formContainerView.addSubview(addressField)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutFormFields()
    }
    
    fileprivate func layoutFormFields() {
        let margin: CGFloat = 12
        let width = max(300, frame.width)
        
        formContainerView.pin.topCenter().width(width).pinEdges().margin(margin, margin, margin)
        
        formTitleLabel.pin.topCenter().margin(margin)

        nameField.pin.below(of: formTitleLabel).left().right().height(40).margin(margin)
        
        ageSwitch.pin.below(of: nameField).left().right().height(40).margin(margin)
        ageField.pin.below(of: ageSwitch).left().right().height(40).margin(margin)
        
        // Layout the Address UITextField below the last visible view, either ageSwitch or ageField.
        addressField.pin.below(of: visible([ageSwitch, ageField])).left().right().height(40).margin(margin)
        
        // Adjust the form container bottom to contains all its childrens
        formContainerView.pin.height(addressField.frame.maxY + margin)
        
        // Adjust UIScrollView contentSize
        formScrollView.contentSize = formContainerView.frame.size
    }
    
    @objc
    internal func didChangeAgeSwitch(uiSwitch: UISwitch) {
        // Animate the appearance/disapearance of the age UITextField
        UIView.animate(withDuration: 0.2) { 
            self.ageField.alpha = uiSwitch.isOn ? 1 : 0
            self.layoutFormFields()
        }
    }
}
