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

class MarginsAndInsetsView: UIView {
    private let contentScrollView = UIScrollView()
    
    private let descriptionLabel = UILabel()
    
    var rootView: BasicView!
    var aView: BasicView!
//    var aViewChild: BasicView!
//    
//    var bView: BasicView!
//    var bViewChild: BasicView!
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
        rootView.addSubview(aView)
//
//        aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
//        aView.addSubview(aViewChild)
//        
//        bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
//        rootView.addSubview(bView)
//        
//        bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
//        bView.addSubview(bViewChild)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("\n")
        
        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 120)
        
//        aView.pin.width(100).margin(10)//CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.width(100).inset(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.width(100).insetLeft(10)//CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.width(100).insetLeft(10).insetRight(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.width(100).insetHorizontal(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.width(100).margins(10).insets(10)//CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)

//        aView.pin.left(150).width(100).margin(10) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.left(140).width(100).inset(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).width(100).insetLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.left(140).width(100).insetRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.left(140).width(100).insetLeft(10).insetRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).width(100).insetHorizontal(10)//CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).width(100).margin(10).inset(10)//CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).width(100).marginLeft(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.left(140).width(100).marginRight(10) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.left(140).width(100).marginHorizontal(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)
        
//        aView.pin.left(140).right(240).margin(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).right(240).inset(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).right(240).insetLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.left(140).right(240).insetRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.left(140).right(240).insetLeft(10).insetRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).right(240).insetHorizontal(10)//CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).right(240).margin(10).inset(10)//CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)
//        aView.pin.left(140).right(240).marginLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.left(140).right(240).marginRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.left(140).right(240).marginLeft(10).marginRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.left(140).right(240).marginHorizontal(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)

//        aView.pin.right(140).width(100).margin(10) //CGRect(x: 50.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.right(140).width(100).inset(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.right(140).width(100).insetLeft(10) //CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.right(140).width(100).insetRight(10) //CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)
//        aView.pin.right(140).width(100).insetLeft(10).insetRight(10) //CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.right(140).width(100).insetHorizontal(10)//CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.right(140).width(100).margin(10).inset(10)//CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)
//        aView.pin.right(140).width(100).marginLeft(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.right(140).width(100).marginRight(10) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)
//        aView.pin.right(140).width(100).marginHorizontal(10) //CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)

        // TODO: Test top and bottom
        
        // TODO: Test using sizeThatFits
        
        //
        // sizeThatFits
        //
//        aView.sizeThatFitsExpectedArea = 40 * 40
        
        printViewFrame(aView, name: "aView")
//        printViewFrame(aViewChild, name: "aViewChild")
//        printViewFrame(bView, name: "bView")
//        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("\(name): CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height))")
    }
}
