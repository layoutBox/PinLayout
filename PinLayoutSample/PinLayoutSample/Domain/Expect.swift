//
//  Expect.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-03-02.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import UIKit

func expect(view: UIView, toMatchRect rect: CGRect) {
    if view.frame != rect {
        print("Doesn't match rect")
    }
}
        
