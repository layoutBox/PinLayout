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

#if os(iOS) || os(tvOS)
import UIKit

extension PinLayoutImpl {
    internal func pointContext(method: String, point: CGPoint) -> String {
        return "\(method)(to: CGPoint(x: \(point.x), y: \(point.y)))"
    }
    
    internal func relativeEdgeContext(method: String, edge: VerticalEdge) -> String {
        let edge = edge as! VerticalEdgeImpl
        return "\(method)(to: .\(edge.type.rawValue), of: \(viewDescription(edge.view)))"
    }
    
    internal func relativeEdgeContext(method: String, edge: HorizontalEdge) -> String {
        let edge = edge as! HorizontalEdgeImpl
        return "\(method)(to: .\(edge.type.rawValue), of: \(viewDescription(edge.view))"
    }
    
    internal func relativeAnchorContext(method: String, anchor: Anchor) -> String {
        let anchor = anchor as! AnchorImpl
        return "\(method)(to: .\(anchor.type.rawValue), of: \(viewDescription(anchor.view)))"
    }
    
    internal func warnWontBeApplied(_ text: String, _ context: Context) {
        guard Pin.logWarnings else { return }
        warn("\(context()) won't be applied, \(text)")
    }
        
    internal func warn(_ text: String) {
        guard Pin.logWarnings else { return }
        displayWarning("PinLayout Warning: \(text)")
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, _ context: Context) {
        guard Pin.logWarnings else { return }
        displayWarning("PinLayout Conflict: \(context()) won't be applied since it value has already been set to \(propertyValue.description).")
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, _ context: Context) {
        guard Pin.logWarnings else { return }
        displayWarning("PinLayout Conflict: \(context()) won't be applied since it value has already been set to CGSize(width: \(propertyValue.width.description), height: \(propertyValue.height.description)).")
    }
    
    internal func warnConflict(_ context: Context, _ properties: [String: Any]) {
        guard Pin.logWarnings else { return }
        var warning = "PinLayout Conflict: \(context()) won't be applied since it conflicts with the following already set properties:"
        properties.forEach { (property) in
            warning += "\n \(property.key): "
            
            if let floatValue = property.value as? CGFloat {
                warning += "\(floatValue.description)"
            } else {
                warning += "\(property.value)"
            }
        }
        
        displayWarning(warning)
    }
    
    internal func displayLayoutWarnings() {
        if !Thread.isMainThread {
            warn("Layout must be executed from the Main Thread!")
        }
        
        if let justify = justify {
            func context() -> String { return "justify(.\(justify.description))" }
            if !((_left != nil && _right != nil) || (shouldPinEdges && width != nil && (_left != nil || _right != nil || _hCenter != nil))) {
                warnWontBeApplied("the left and right coordinates must be set to justify the view horizontally.", context)
            }
            
            if _hCenter != nil {
                warnWontBeApplied("justification is not applied when hCenter has been set. By default the view will be centered around the hCenter.", context)
            }
        }
        
        if let align = align {
            func context() -> String { return "align(.\(align.description))" }
            if !((_top != nil && _bottom != nil) || (shouldPinEdges && height != nil && (_top != nil || _bottom != nil || _vCenter != nil))) {
                warnWontBeApplied("the top and bottom coordinates must be set to align the view vertically.", context)
            }
            
            if _vCenter != nil {
                warnWontBeApplied("alignment is not applied when vCenter has been set. By default the view will be centered around the specified vCenter.", context)
            }
        }
    }
    
    internal func displayWarning(_ text: String) {
        var displayText = "\n👉 \(text)"
        displayText += "\n(Layouted view info: Type: \(viewName(view)), Frame: \(view.frame)"
        
        var currentView = view
        var hierarchy: [String] = []
        while let parent = currentView.superview {
            hierarchy.insert("\(type(of: parent))", at: 0)
            currentView = parent
        }
        if hierarchy.count > 0 {
            displayText += ", Superviews: \(hierarchy.flatMap({ $0 }).joined(separator: " -> "))"
        }
        
        displayText += ", Tag: \(view.tag))\n"
        
        print(displayText)
        Pin.lastWarningText = text
    }
    
    internal func viewDescription(_ view: UIView) -> String {
        return "(\(viewName(view)), Frame: \(view.frame))"
    }
    
    internal func viewName(_ view: UIView) -> String {
        return "\(type(of: view))"
    }
}

#endif
