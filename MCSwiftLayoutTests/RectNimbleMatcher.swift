//
//  RectNimbleMatcher.swift
//  PinLayout
//
//  Created by DION, Luc (MTL) on 2017-03-12.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Nimble
import UIKit

public func beCloseTo(_ expectedValues: CGRect, within delta: CGFloat = 0.00001) -> NonNilMatcherFunc <CGRect> {
    return NonNilMatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "be close to CGRect <\(stringify(expectedValues))> (each within \(stringify(delta)))"
        if let actual = try actualExpression.evaluate() {
            failureMessage.actualValue = "<\(stringify(actual))>"
            
            if fabs(actual.origin.x - expectedValues.origin.x) > delta {
                return false
            }
            
            if fabs(actual.origin.y - expectedValues.origin.y) > delta {
                return false
            }

            if fabs(actual.size.width - expectedValues.size.width) > delta {
                return false
            }

            if fabs(actual.size.height - expectedValues.size.height) > delta {
                return false
            }

            return true
        }
        
        return false
    }
}
