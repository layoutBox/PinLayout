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

struct Method {
    let name: String
    let description: String
}

class TableViewExampleViewController: BaseViewController {
    fileprivate var mainView: TableViewExampleView {
        return self.view as! TableViewExampleView
    }

    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        
        title = pageType.text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = TableViewExampleView()
        mainView.configure(methods: [
            Method(name: "top(_ value: CGFloat)", description: "The value specifies the top edge distance from the superview's top edge in pixels."),
            Method(name: "top(_ percent: Percent)", description: "The value specifies the top edge distance from the superview's top edge in percentage of its superview's height."),
            Method(name: "left(_ value: CGFloat)", description: "The value specifies the left edge distance from the superview's left edge in pixels. The value specifies the left edge distance from the superview's left edge in pixels."),
            Method(name: "left(_ percent: Percent)", description: "The value specifies the left edge distance from the superview's left edge in percentage of its superview's width."),
            Method(name: "bottom(_ value: CGFloat)", description: "The value specifies the bottom edge distance from the superview's bottom edge in pixels."),
            Method(name: "bottom(_ percent: Percent)", description: "The value specifies the bottom edge distance from the superview's bottom edge in percentage of its superview's height."),
            Method(name: "right(_ value: CGFloat)", description: "The value specifies the right edge distance from the superview's right edge in pixels."),
            Method(name: "right(_ percent: Percent)", description: "The value specifies the right edge distance from the superview's right edge in percentage of its superview's width."),
            Method(name: "hCenter(_ value: CGFloat)", description: "The value specifies the horizontal center distance from the superview's left edge in pixels."),
            Method(name: "hCenter(_ percent: Percent)", description: "The value specifies the horizontal center distance from the superview's left edge in percentage of its superview's width."),
            Method(name: "vCenter(_ value: CGFloat)", description: "The value specifies the vertical center distance from the superview's top edge in pixels."),
            Method(name: "vCenter(_ percent: Percent)", description: "The value specifies the vertical center distance from the superview's top edge in percentage of its superview's height.")
        ])
    }
}
