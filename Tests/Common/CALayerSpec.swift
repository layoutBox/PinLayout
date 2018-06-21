//
//  CALayerSpec.swift
//  PinLayout-iOS
//
//  Created by Antoine Lamy on 2018-06-21.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Quick
import Nimble
import PinLayout

class CALayerSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var rootView: BasicView!
        var aLayer: CALayer!
        var bLayer: CALayer!

        /*
         root
         |
          - aLayer
            bLayer
         */

        beforeSuite {
            _pinlayoutSetUnitTest(scale: 2)
        }

        beforeEach {
            Pin.lastWarningText = nil
            Pin.logMissingLayoutCalls = false

            viewController = PViewController()
            viewController.view = BasicView()

            rootView = BasicView()
            aLayer = CALayer()
            bLayer = CALayer()

            #if os(macOS)
            rootView.wantsLayer = true
            rootView.layer?.addSublayer(aLayer)
            rootView.layer?.addSublayer(aLayer)
            #else
            rootView.layer.addSublayer(aLayer)
            rootView.layer.addSublayer(aLayer)
            #endif

            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
        }

        afterEach {
            Pin.logMissingLayoutCalls = false
        }

        //
        // CALayer is already heavily tested since UIView delegate it's layout to it's layer.
        // Validate only the direct usability.
        //
        describe("test CALayer interface") {
            it("basic pinlayout calls") {
                aLayer.pin.top(10).left(10).width(20%).height(80%).layout()
                bLayer.pin.size(CGSize(width: 20, height: 20)).right(of: aLayer, aligned: .center).layout()
                expect(aLayer.frame).to(equal(CGRect(x: 10, y: 10, width: 80, height: 320)))
            }
        }
    }
}
