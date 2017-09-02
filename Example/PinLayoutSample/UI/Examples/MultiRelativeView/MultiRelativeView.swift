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

class MultiRelativeView: BaseView {
    fileprivate let view1 = BasicView(text: "Relative view 1 (width: 20%, height: 50%)", color: .lightGray)
    fileprivate let view2 = BasicView(text: "Relative view 2 (width: 20%, height: 50%)", color: .lightGray)
    fileprivate let view = BasicView(text: "View layouted using two relative views: \n  - right(of: view1, aligned: .top)\n  - left(of: view2, aligned: .bottom)",
                                     color: .pinLayoutColor)
    
    override init() {
        super.init()
    
        addSubview(view1)
        addSubview(view2)
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        view1.pin.top(topLayoutGuide).left().width(20%).height(50%)
        view2.pin.top(topLayoutGuide).right().width(20%).height(50%)
        
        view.pin.right(of: view1, aligned: .top).left(of: view2, aligned: .bottom).marginHorizontal(10)
    }
}
