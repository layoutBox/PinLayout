//
//  PinLayoutImpl+Warning.swift
//  PinLayout
//
//  Created by DION, Luc (MTL) on 2017-06-17.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
#if os(iOS) || os(tvOS)
import UIKit

extension PinLayoutImpl {
    internal func pointContext(method: String, point: CGPoint) -> String {
        return "\(method)(to: CGPoint(x: \(point.x), y: \(point.y)))"
    }
    
    internal func relativeEdgeContext(method: String, edge: VerticalEdge) -> String {
        let edge = edge as! VerticalEdgeImpl
        return "\(method)(to: \(edge.type.rawValue), of: \(edge.view))"
    }
    
    internal func relativeEdgeContext(method: String, edge: HorizontalEdge) -> String {
        let edge = edge as! HorizontalEdgeImpl
        return "\(method)(to: \(edge.type.rawValue), of: \(edge.view))"
    }
    
    internal func relativeAnchorContext(method: String, anchor: Anchor) -> String {
        let anchor = anchor as! AnchorImpl
        return "\(method)(to: \(anchor.type.rawValue), of: \(anchor.view))"
    }
    
    internal func warn(_ text: String, _ context: Context) {
        guard PinLayoutLogConflicts else { return }
        displayWarning("\n👉 PinLayout Warning: \(context()) won't be applied, \(text)\n")
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, _ context: Context) {
        guard PinLayoutLogConflicts else { return }
        displayWarning("\n👉 PinLayout Conflict: \(context()) won't be applied since it value has already been set to \(propertyValue).\n")
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, _ context: Context) {
        guard PinLayoutLogConflicts else { return }
        displayWarning("\n👉 PinLayout Conflict: \(context()) won't be applied since it value has already been set to CGSize(width: \(propertyValue.width), height: \(propertyValue.height)).\n")
    }
    
    internal func warnConflict(_ context: Context, _ properties: [String: CGFloat]) {
        guard PinLayoutLogConflicts else { return }
        var warning = "\n👉 PinLayout Conflict: \(context()) won't be applied since it conflicts with the following already set properties:\n"
        properties.forEach { (property) in
            warning += " \(property.key): \(property.value)\n"
        }
        
        displayWarning(warning)
    }
    
    internal func displayWarning(_ text: String) {
        print(text)
        unitTestLastWarning = text
    }
    
    internal func viewDescription(_ view: UIView) -> String {
        return "\"\(view.description)\""
    }
}

#endif
