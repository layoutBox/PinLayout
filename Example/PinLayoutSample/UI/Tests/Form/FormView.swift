// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
    
    internal func didChangeAgeSwitch(uiSwitch: UISwitch) {
        // Animate the appearance/disapearance of the age UITextField
        UIView.animate(withDuration: 0.2) { 
            self.ageField.alpha = uiSwitch.isOn ? 1 : 0
            self.layoutFormFields()
        }
    }
}
