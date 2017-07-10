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
        warn("\(context()) won't be applied, \(text)\n")
    }
    
    internal func warn(_ text: String) {
        guard PinLayoutLogConflicts else { return }
        displayWarning("\n👉 PinLayout Warning: \(text)\n")
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
    
    internal func displayLayoutWarnings() {
        if let justify = justify {
            func context() -> String { return "justify(.\(justify))" }
            if !((_left != nil && _right != nil) || (shouldPinEdges && width != nil && (_left != nil || _right != nil || _hCenter != nil))) {
                warn("the left and right coordinates must be set to justify the view horizontally.", context)
            }
            
            if _hCenter != nil {
                warn("justification is not applied when hCenter has been set. By default the view will be centered around the hCenter.", context)
            }
        }
        
        if let align = align {
            func context() -> String { return "align(.\(align))" }
            if !((_top != nil && _bottom != nil) || (shouldPinEdges && height != nil && (_top != nil || _bottom != nil || _vCenter != nil))) {
                warn("the top and bottom coordinates must be set to align the view vertically.", context)
            }
            
            if _vCenter != nil {
                warn("alignment is not applied when vCenter has been set. By default the view will be centered around the specified vCenter.", context)
            }
        }
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
