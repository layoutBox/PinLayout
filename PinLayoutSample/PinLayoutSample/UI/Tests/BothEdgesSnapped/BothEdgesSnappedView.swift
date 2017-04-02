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

class BothEdgesSnappedView: UIView {
    private let contentScrollView = UIScrollView()
    
    private let descriptionLabel = UILabel()
    
    private let noMarginsNoPaddings = BasicView(text: "70x30", color: .black)
    
//    private let noMarginsLeftInsetView = BasicView(text: "LI", color: UIColor.red.withAlphaComponent(1.0))
//    private let noMarginsRightInsetView = BasicView(text: "RI", color: UIColor.red.withAlphaComponent(0.8))
//    private let noMarginsLeftRightInsetView = BasicView(text: "LI-RI", color: UIColor.red.withAlphaComponent(0.6))
//    
//    private let leftMarginView = BasicView(text: "LM", color: UIColor.blue.withAlphaComponent(1.0))
//    private let leftMarginLeftInsetView = BasicView(text: "LM LI", color: UIColor.blue.withAlphaComponent(0.8))
//    private let leftMarginRightInsetView = BasicView(text: "LM RI", color: UIColor.blue.withAlphaComponent(0.6))
//    private let leftMarginLeftRightInsetView = BasicView(text: "LM LI-RI", color: UIColor.blue.withAlphaComponent(0.4))
//    
//    private let rigthMarginView = BasicView(text: "RM", color: UIColor.green.withAlphaComponent(1))
//    private let rigthMarginLeftInsetView = BasicView(text: "RM LI", color: UIColor.green.withAlphaComponent(0.8))
//    private let rigthMarginRightInsetView = BasicView(text: "RM RI", color: UIColor.green.withAlphaComponent(0.6))
//    private let rigthMarginLeftRightInsetView = BasicView(text: "RM LI-RI", color: UIColor.green.withAlphaComponent(0.4))
//    
//    private let leftRightMarginsView = BasicView(text: "LM-RM", color: UIColor.purple.withAlphaComponent(1))
//    private let leftRightMarginsLeftInsetView = BasicView(text: "LM-RM LI", color: UIColor.purple.withAlphaComponent(0.8))
//    private let leftRightMarginsRightInsetView = BasicView(text: "LM-RM RI", color: UIColor.purple.withAlphaComponent(0.6))
//    private let leftRightMarginsLeftRightInsetView = BasicView(text: "LM-RM LI-RI", color: UIColor.purple.withAlphaComponent(0.4))
    
    var rootView: BasicView!
    var aView: BasicView!
    var aViewChild: BasicView!
    
    var bView: BasicView!
    var bViewChild: BasicView!

    var index = 0
    var anchorsList: [(String, Anchor)] = []

    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black
        
        rootView = BasicView(text: "", color: .white)
        addSubview(rootView)
        
        aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
        rootView.addSubview(aView)
        
        aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
        aView.addSubview(aViewChild)
        
        bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
        rootView.addSubview(bView)
        
        bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
        bView.addSubview(bViewChild)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))

        anchorsList = getAnchorList(forView: bView)
        index = anchorsList.count - 1
        setNeedsLayout()

//        contentScrollView.backgroundColor = .yellow
//        addSubview(contentScrollView)
//        
//        descriptionLabel.text = "In this test the topLeft coordinates and the bottomRight have been set.\nMargins and Insets always have a value of 10\nL=Left, R=Right, M=Margin, I=Inset"
//        descriptionLabel.numberOfLines = 0
//        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
//        contentScrollView.addSubview(descriptionLabel)
//        
//        addView(noMarginsNoPaddings)
//        
//        // No margins
//        addView(noMarginsLeftInsetView)
//        addView(noMarginsRightInsetView)
//        addView(noMarginsLeftRightInsetView)
//        
//        // Left margin
//        addView(leftMarginView)
//        addView(leftMarginLeftInsetView)
//        addView(leftMarginRightInsetView)
//        addView(leftMarginLeftRightInsetView)
//        
//        // Right margin
//        addView(rigthMarginView)
//        addView(rigthMarginLeftInsetView)
//        addView(rigthMarginRightInsetView)
//        addView(rigthMarginLeftRightInsetView)
//        
//        // Left and right margins
//        addView(leftRightMarginsView)
//        addView(leftRightMarginsLeftInsetView)
//        addView(leftRightMarginsRightInsetView)
//        addView(leftRightMarginsLeftRightInsetView)
    }

    func didTap() {
        index += 1

        if index >= anchorsList.count {
            index = 0
        }

        setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //print("\n")
        
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        aView.frame = CGRect(x: 100, y: 100, width: 200, height: 160)
//        aViewChild.frame = CGRect(x: 45, y: 50, width: 80, height: 80)
//        bView.frame = CGRect(x: 160, y: 200, width: 40, height: 40)

        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)

//        let name = anchorsList[index].0
//        let anchor = anchorsList[index].1
//        print("aViewChild.pin.topCenter(to: bView.anchor.\(name))")
//        aViewChild.pin.topCenter(to: anchor)
//        printViewFrame(aViewChild, name: "aViewChild")

//        aView.pin.left(0).right(0).top(0).bottom(0).margin(10)
//        expect(aView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 380.0, height: 380.0)))

        aView.pin.topLeft(to: .zero).bottomRight(to: .zero).margin(10)

//         topLeft
//        aViewChild.pin.topLeft(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topLeft(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 180.0, width: 50.0, height: 30.0)))

//        topCenter
//        aViewChild.pin.topCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 180.0, width: 50.0, height: 30.0)))

//        topRight
//        aViewChild.pin.topRight(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 140.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 180.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.topRight(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 180.0, width: 50.0, height: 30.0)))

//        leftCenter
//        aViewChild.pin.leftCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 165.0, width: 50.0, height: 30.0)))

//        center
//        aViewChild.pin.center(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.center(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 165.0, width: 50.0, height: 30.0)))

//        rightCenter
//        aViewChild.pin.rightCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 85.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 165.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.rightCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 165.0, width: 50.0, height: 30.0)))

//        bottomLeft
//        aViewChild.pin.bottomLeft(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomLeft(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 150.0, width: 50.0, height: 30.0)))

//        bottomCenter
//        aViewChild.pin.bottomCenter(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomCenter(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 50.0, height: 30.0)))

//        bottomRight
//        aViewChild.pin.bottomRight(to: bView.anchor.topLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.topCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.topRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 70.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.leftCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.center)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.rightCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 110.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.bottomLeft)
//        expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.bottomCenter)
//        expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 150.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.bottomRight(to: bView.anchor.bottomRight)
//        expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 150.0, width: 50.0, height: 30.0)))




//        aView.pin.margin(t: 0, l: 0, b: 0, r: 0)

//        bView.pin.above(of: aView, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 145.0, y: 110.0, width: 40.0, height: 40.0)))
        
//        bView.pin.above(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 180.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 165.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.pin.above(of: aView, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 260.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 40.0, height: 40.0)))
//        bView.pin.right(of: aViewChild, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 150.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 160.0, width: 40.0, height: 40.0)))
//        bView.pin.right(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 170.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 220.0, width: 40.0, height: 40.0)))
//        bView.pin.right(of: aViewChild, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 190.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 100.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild, aligned: .left)
//        expect(bView.frame).to(equal(CGRect(x: 145.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 180.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 165.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 260.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild, aligned: .right)
//        expect(bView.frame).to(equal(CGRect(x: 185.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 160.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 170.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 220.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 190.0, width: 40.0, height: 40.0)))

//        bView.pin.above(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 40.0, height: 40.0)))
//        bView.pin.above(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 40.0, height: 40.0)))

//        bView.pin.left(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 60.0, y: 200.0, width: 40.0, height: 40.0)))
//        bView.pin.left(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 105.0, y: 200.0, width: 40.0, height: 40.0)))

//        bView.pin.below(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 260.0, width: 40.0, height: 40.0)))
//        bView.pin.below(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 160.0, y: 230.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aView)
//        expect(bView.frame).to(equal(CGRect(x: 300.0, y: 200.0, width: 40.0, height: 40.0)))

//        bView.pin.right(of: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 225.0, y: 200.0, width: 40.0, height: 40.0)))

        // MARGINS
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
//        let label = UILabel()
//        label.text = "clafsdj lfkd asdkjkd lkjlksfjd daljs df flkjdslkjf lksfjlkj jaslkj ljdfaj lkajdsfl k asdlkd jassd adskjfksad laksdj fds;alkj l"
//        label.numberOfLines = 0
//        let toto = label.sizeThatFits(CGSize(width: 20, height: CGFloat.greatestFiniteMagnitude))
//        let toto2 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 20))
//        let toto3 = label.sizeThatFits(CGSize(width: 20, height: 20))
//        
//        let toto4 = label.sizeThatFits(CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
//        let toto5 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 100))
//        let toto6 = label.sizeThatFits(CGSize(width: 100, height: 100))
//        
//        let toto7 = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        //
        // sizeThatFits
        //
//        aView.sizeThatFitsExpectedArea = 40 * 40
//        aView.frame = CGRect(x: 140, y: 100, width: 200, height: 160)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        
        //
        // sizeToFit
        //
//        aView.pin.width(100).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))

//        aView.pin.width(of: aViewChild).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))

//        aView.pin.height(100).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))

//        aView.pin.height(of: aViewChild).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0)))

//        aView.pin.size(of: aViewChild).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))

//        aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit()
//        expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))

//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)

//        aViewChild.pin.center(.center, of: aView).height(40).sizeToFit()
//        expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))
        // SHOULD EQUAL THESE 2 LINES:
//        aViewChild.pin.width(40).height(40)
//        aViewChild.pin.center(to: aView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))

//        aViewChild.pin.center(to: aView.anchor.center).width(20).sizeToFit()
//        expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))
        // SHOULD EQUAL THESE 2 LINES:
        //aViewChild.pin.width(20).height(80)
        //aViewChild.pin.center(to: aView)
        //expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))

//        aViewChild.pin.topLeft.topLeft, of: bView).height(40).sizeToFit()
//        aViewChild.pin.topLeft.topLeft, of: aView).height(40).sizeToFit()
//        bView.pin.topLeft.topLeft, of: aViewChild).height(40).sizeToFit()
        
//        aView.pin.sizeThatFits(size: CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude)) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)
//        aView.pin.sizeThatFits(width: 100) // CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)
//        aView.pin.sizeThatFits(widthOf: aViewChild) //CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)
        
//        aView.pin.sizeThatFits(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 100)) //CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)
//        aView.pin.sizeThatFits(height: 100) //CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)
//        aView.pin.sizeThatFits(heightOf: aViewChild)// CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0)
        
//        aView.pin.sizeThatFits(sizeOf: aViewChild)//CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)
        
//        aView.pin.size(of: aViewChild)// CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)
//        aView.pin.size(CGSize(width: 25, height: 25))//CGRect(x: 140.0, y: 100.0, width: 25.0, height: 25.0)
        
        //
        // pin coordinate
        //
//        aViewChild.pin.top(.top, of: aView) //CGRect(x: 10.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.top(.top, of: bView)      // CGRect(x: 10.0, y: 100.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topLeft(to: bView.anchor.bottomRight)
//        bViewChild.pin.top(.top, of: aViewChild) //CGRect(x: 40.0, y: -80.0, width: 60.0, height: 20.0)

//        aViewChild.pin.top(.bottom, of: aView)      //CGRect(x: 10.0, y: 60.0, width: 50.0, height: 30.0)
//        aViewChild.pin.top(.bottom, of: bView)      //CGRect(x: 10.0, y: 180.0, width: 50.0, height: 30.0)
//        bViewChild.pin.top(.bottom, of: aViewChild) //CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)
        
//        aViewChild.pin.bottom(.top, of: aView) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.pin.bottom(.top, of: bView)      //CGRect(x: 10.0, y: 70.0, width: 50.0, height: 30.0)
//        bViewChild.pin.bottom(.top, of: aViewChild) //CGRect(x: 40.0, y: -100.0, width: 60.0, height: 20.0)
//
//        aViewChild.pin.bottom(.bottom, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.pin.bottom(.bottom, of: bView)      //CGRect(x: 10.0, y: 150.0, width: 50.0, height: 30.0)
//        bViewChild.pin.bottom(.bottom, of: aViewChild) //CGRect(x: 40.0, y: -70.0, width: 60.0, height: 20.0)

//        aViewChild.pin.left(.left, of: aView) //CGRect(x: 0.0, y: 20.0, width: 50.0, height: 30.0)
//        aViewChild.pin.left(.left, of: bView)      //CGRect(x: 20.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.pin.left(.left, of: aViewChild) //CGRect(x: -10.0, y: 10.0, width: 60.0, height: 20.0)
//
//        aViewChild.pin.left(.right, of: aView)      //CGRect(x: 100.0, y: 20.0, width: 50.0, height: 30.0)
//        aViewChild.pin.left(.right, of: bView)      //CGRect(x: 130.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.pin.left(.right, of: aViewChild) //CGRect(x: 40.0, y: 10.0, width: 60.0, height: 20.0)

//        aViewChild.pin.right(.left, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.pin.right(.left, of: bView)      //CGRect(x: -30.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.pin.right(.left, of: aViewChild) //CGRect(x: -70.0, y: 10.0, width: 60.0, height: 20.0)
//
//        aViewChild.pin.right(.right, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
//        aViewChild.pin.right(.right, of: bView)      //CGRect(x: 80.0, y: 20.0, width: 50.0, height: 30.0)
//        bViewChild.pin.right(.right, of: aViewChild) //CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)

        //
        // pin point
        //
//        rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
//        aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//        bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
//        bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        
        // topLeft
//        aView.pin.topLeft()                    // CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.pin.topLeft.topLeft, of: aView)  //(of: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topLeftof: aView)      // CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topLeftof: aView).bottomRight()
//        aViewChild.pin.topLeft(of: bView)      // CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.pin.topLeft(of: aViewChild)      // CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.pin.topLeftto: aViewChild)< // CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)
        
//        bView.pin.bottomRight().topLeftto: .zero).below(of: bViewChild)
        
        // topCenter
//        aView.pin..topCenter.()                      // CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)
//        aViewChild.pin.topCenter(to: aView)        //CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)
//        aViewChild.pin.topCenter(to: bView)        //CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)
//        bView.pin.topCenter(to: aViewChild)        //CGRect(x: 120.0, y: 120.0, width: 110.0, height: 80.0)
//        bViewChild.pin.topCenter(to: aViewChild)   //CGRect(x: -15.0, y: -80.0, width: 60.0, height: 20.0)
 
        // topRight
//        aView.pin.topRight()
//        aViewChild.pin.topRight(to: aView)
//        aViewChild.pin.topRight(to: bView)
//        bView.pin.topRight(to: aViewChild)
//        bViewChild.pin.topRight(to: aViewChild)
        
        // leftCenter
//        aView.pin.leftCenter()
//        expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))

//        aViewChild.pin.leftCenter(to: aView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
//        aViewChild.pin.leftCenter(to: bView)
//        expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
//        bView.pin.leftCenter(to: aViewChild)
//        expect(bView.frame).to(equal(CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)))
//        bViewChild.pin.leftCenter(to: aViewChild)
//        expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)))

//        let aViewAnchors = getAnchorList(forView: aView)
//        aViewAnchors.forEach { (tuples) in
//            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
//
//            let name = tuples.0
//            let anchor = tuples.1
//            print("aViewChild.pin.topLeft(to: aView.anchor.\(name))")
//
//            aViewChild.pin.topLeft(to: anchor)
//            printViewFrame(aViewChild, name: "aViewChild")
//        }

        // center
//        aView.pin.center()
//        aViewChild.pin.center(to: aView.anchor.center)
//        aViewChild.pin.center(to: bView.anchor.center)
//        bView.pin.center(to: aViewChild.anchor.center)
//        bViewChild.pin.center(to: aViewChild.anchor.center)

//        aView.pin.center()
//        expect(aView.frame).to(equal(CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)))
//        aViewChild.pin.center(to: aView)
//        aViewChild.pin.center(to: bView)
//        bView.pin.center(to: aViewChild)
//        bViewChild.pin.center(to: aViewChild)
    
        // rightCenter
//        aView.pin.rightCenter()
//        aViewChild.pin.rightCenter(to: aView)
//        aViewChild.pin.rightCenter(to: bView)
//        bView.pin.rightCenter(to: aViewChild)
//        bViewChild.pin.rightCenter(to: aViewChild)

        // bottomLeft
//        aView.pin.bottomLeft()
//        aViewChild.pin.bottomLeft(to: aView)
//        aViewChild.pin.bottomLeft(to: bView)
//        bView.pin.bottomLeft(to: aViewChild)
//        bViewChild.pin.bottomLeft(to: aViewChild)

        // bottomCenter
//        aView.pin.bottomCenter()
//        aViewChild.pin.bottomCenter(to: aView)
//        aViewChild.pin.bottomCenter(to: bView)
//        bView.pin.bottomCenter(to: aViewChild)
//        bViewChild.pin.bottomCenter(to: aViewChild)

        // bottomRight
//        aView.pin.bottomRight()
//        aViewChild.pin.bottomRight(of: aView)
//        aViewChild.pin.bottomRight(of: bView)
//        bView.pin.bottomRight(of: aViewChild)
//        bViewChild.pin.bottomRight(of: aViewChild) 

        printViewFrame(aView, name: "aView")
//        printViewFrame(aViewChild, name: "aViewChild")
//        
//        printViewFrame(bView, name: "bView")
//        printViewFrame(bViewChild, name: "bViewChild")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        print("expect(\(name).frame).to(equal(CGRect(x: \(view.frame.origin.x), y: \(view.frame.origin.y), width: \(view.frame.size.width), height: \(view.frame.size.height))))")
    }

    fileprivate func getAnchorList(forView view: UIView) -> [(String, Anchor)] {
        return [
            ("topLeft", view.anchor.topLeft),
            ("topCenter", view.anchor.topCenter),
            ("topRight", view.anchor.topRight),
            ("leftCenter", view.anchor.leftCenter),
            ("center", view.anchor.center),
            ("rightCenter", view.anchor.rightCenter),
            ("bottomLeft", view.anchor.bottomLeft),
            ("bottomCenter", view.anchor.bottomCenter),
            ("bottomRight", view.anchor.bottomRight)
        ]
    }
}
