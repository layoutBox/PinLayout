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

class BaseFormView: BaseView {
    let formScrollView = UIScrollView()
    
    override init() {
        super.init()
        
        formScrollView.showsVerticalScrollIndicator = false
        formScrollView.keyboardDismissMode = .onDrag
        formScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapScrollView)))
        addSubview(formScrollView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        formScrollView.pin.topLeft().bottomRight()
    }
    
    override func didChangeLayoutGuides() {
        super.didChangeLayoutGuides()
        formScrollView.contentOffset = CGPoint(x: 0, y: topLayoutGuide)
    }
    
    internal func keyboardWillShow(notification: Notification) {
        guard let sizeValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        setFormScrollView(bottomInset: sizeValue.cgRectValue.height)
    }
    
    internal func keyboardWillHide(notification: Notification) {
        resetScrollOffset()
    }
    
    internal func didTapScrollView() {
        endEditing(true)
        resetScrollOffset()
    }
    
    fileprivate func resetScrollOffset() {
        guard formScrollView.contentInset != .zero else { return }
        setFormScrollView(bottomInset: 0)
    }
    
    fileprivate func setFormScrollView(bottomInset: CGFloat) {
        formScrollView.contentInset = UIEdgeInsets(top: formScrollView.contentInset.top, left: 0,
                                                   bottom: bottomInset, right: 0)
    }
}
