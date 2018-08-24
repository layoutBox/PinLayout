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

class TableViewReadableContentViewController: UIViewController {
    fileprivate var mainView: TableViewReadableContentView {
        return self.view as! TableViewReadableContentView
    }

    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        
        title = pageType.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = TableViewReadableContentView()
        mainView.configure(methods: [
            Method(name: "top(_ value: CGFloat)", description: "The value specifies the top edge distance from the superview's top edge in pixels."),
            Method(name: "top(_ percent: Percent)", description: "The value specifies the top edge distance from the superview's top edge in percentage of its superview's height."),
            Method(name: "vCenter(_ value: CGFloat)", description: "The value specifies the distance vertically of the view's center related to the superview's center in pixels."),
            Method(name: "vCenter(_ percent: Percent)", description: "The value specifies the distance vertically of the view's center related to the superview's center in percentage of its superview's height."),
            Method(name: "bottom(_ value: CGFloat)", description: "The value specifies the bottom edge distance from the superview's bottom edge in pixels."),
            Method(name: "bottom(_ percent: Percent)", description: "The value specifies the bottom edge distance from the superview's bottom edge in percentage of its superview's height."),
            
            Method(name: "left(_ value: CGFloat)", description: "The value specifies the left edge distance from the superview's left edge in pixels. The value specifies the left edge distance from the superview's left edge in pixels."),
            Method(name: "left(_ percent: Percent)", description: "The value specifies the left edge distance from the superview's left edge in percentage of its superview's width."),
            Method(name: "hCenter(_ value: CGFloat)", description: "The value specifies the distance horizontally of the view's center related to the superview's center in pixels."),
            Method(name: "hCenter(_ percent: Percent)", description: "The value specifies the distance horizontally of the view's center related to the superview's center in percentage of its superview's height."),
            Method(name: "right(_ value: CGFloat)", description: "The value specifies the right edge distance from the superview's right edge in pixels."),
            Method(name: "right(_ percent: Percent)", description: "The value specifies the right edge distance from the superview's right edge in percentage of its superview's width.")
        ])
    }
}
