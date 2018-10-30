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

class BaseFormView: UIView {
    let formScrollView = UIScrollView()

    init() {
        super.init(frame: .zero)

        formScrollView.showsVerticalScrollIndicator = false
        formScrollView.keyboardDismissMode = .onDrag
        
        formScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapScrollView)))
        addSubview(formScrollView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        formScrollView.pin.all()
    }

    @objc
    internal func keyboardWillShow(notification: Notification) {
        guard let sizeValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        setFormScrollView(bottomInset: sizeValue.cgRectValue.height)
    }

    @objc
    internal func keyboardWillHide(notification: Notification) {
        resetScrollOffset()
    }

    @objc
    internal func didTapScrollView() {
        endEditing(true)
        resetScrollOffset()
    }

    private func resetScrollOffset() {
        guard formScrollView.contentInset != .zero else { return }
        setFormScrollView(bottomInset: 0)
    }

    private func setFormScrollView(bottomInset: CGFloat) {
        formScrollView.contentInset = UIEdgeInsets(top: formScrollView.contentInset.top, left: 0,
                                                   bottom: bottomInset, right: 0)
    }
}
