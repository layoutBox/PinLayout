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
#else
    import AppKit
#endif

private var numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.decimalSeparator = "."
    return numberFormatter
}()

extension PinLayout {
    internal func pointContext(method: String, point: CGPoint) -> String {
        return "\(method)(to: CGPoint(x: \(point.x), y: \(point.y)))"
    }
    
    internal func relativeEdgeContext(method: String, edge: VerticalEdge) -> String {
        let edge = edge as! VerticalEdgeImpl<View>
        return "\(method)(to: .\(edge.type.rawValue), of: \(viewDescription(edge.view)))"
    }
    
    internal func relativeEdgeContext(method: String, edge: HorizontalEdge) -> String {
        let edge = edge as! HorizontalEdgeImpl<View>
        return "\(method)(to: .\(edge.type.rawValue), of: \(viewDescription(edge.view))"
    }
    
    internal func relativeAnchorContext(method: String, anchor: Anchor) -> String {
        let anchor = anchor as! AnchorImpl<View>
        return "\(method)(to: .\(anchor.type.rawValue), of: \(viewDescription(anchor.view)))"
    }
    
    internal func warnWontBeApplied(_ text: String, _ context: Context) {
        guard Pin.logWarnings else { return }
        warn("\(context()) won't be applied, \(text)")
    }
        
    internal func warn(_ text: String) {
        guard Pin.logWarnings else { return }
        pinLayoutDisplayConsoleWarning("PinLayout Warning: \(text)", view)
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, _ context: Context) {
        guard Pin.logWarnings else { return }
        pinLayoutDisplayConsoleWarning("PinLayout Conflict: \(context()) won't be applied since it value has already been set to \(propertyValue.description).", view)
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, _ context: Context) {
        guard Pin.logWarnings else { return }
        pinLayoutDisplayConsoleWarning("PinLayout Conflict: \(context()) won't be applied since it value has already been set to CGSize(width: \(propertyValue.width.description), height: \(propertyValue.height.description)).", view)
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
        
        pinLayoutDisplayConsoleWarning(warning, view)
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

    internal func viewDescription(_ view: View) -> String {
        let rect = view.getRect(keepTransform: keepTransform)
        return "(\(viewName(view)), Frame: \(rect))"
    }
    
    internal func viewName(_ view: View) -> String {
        return "\(type(of: view))"
    }

    internal func insetsDescription(_ insets: PEdgeInsets) -> String {
        return "UIEdgeInsets(top: \(insets.top), left: \(insets.left), bottom: \(insets.bottom), right: \(insets.right))"
    }

    internal func pinLayoutDisplayConsoleWarning(_ text: String, _ view: View) {
        var displayText = "\n👉 \(text)"

        let rect = view.getRect(keepTransform: keepTransform)
        let x = numberFormatter.string(from: NSNumber(value: Float(rect.origin.x)))!
        let y = numberFormatter.string(from: NSNumber(value: Float(rect.origin.y)))!
        let width = numberFormatter.string(from: NSNumber(value: Float(rect.size.width)))!
        let height = numberFormatter.string(from: NSNumber(value: Float(rect.size.height)))!
        let viewName = "\(type(of: view))"
        displayText += "\n(Layouted view info: Type: \(viewName), Frame: x: \(x), y: \(y), width: \(width), height: \(height))"

        var currentView = view
        var hierarchy: [String] = []
        while let parent = currentView.superview {
            hierarchy.insert("\(type(of: parent))", at: 0)
            currentView = parent as! View
        }
        if hierarchy.count > 0 {
            #if swift(>=4.1)
            displayText += ", Superviews: \(hierarchy.compactMap({ $0 }).joined(separator: " -> "))"
            #else
            displayText += ", Superviews: \(hierarchy.flatMap({ $0 }).joined(separator: " -> "))"
            #endif
        }

        displayText += ", Debug description: \(view.debugDescription))\n"

        print(displayText)
        Pin.lastWarningText = text
    }
}
