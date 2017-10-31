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

extension UIEdgeInsets {
    func insetBy(dx: CGFloat, dy: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.top + dy, left: self.left + dx, bottom: self.bottom + dy, right: self.right + dx)
    }
    
    func minInsets(_ insets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: minValue(self.top, minValue: insets.top),
                            left: minValue(self.left, minValue: insets.left),
                            bottom: minValue(self.bottom, minValue: insets.bottom),
                            right: minValue(self.right, minValue: insets.right))
    }
    
    func minInsets(dx: CGFloat, dy: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: minValue(self.top, minValue: dy),
                            left: minValue(self.left, minValue: dx),
                            bottom: minValue(self.bottom, minValue: dy),
                            right: minValue(self.right, minValue: dx))
    }
    
    fileprivate func minValue(_ value: CGFloat, minValue: CGFloat) -> CGFloat {
        return value >= minValue ? value : minValue
    }
}
