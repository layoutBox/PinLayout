<p align="center">
	<img src="pinlayout-logo-small.png" width=100/>
</p>

## PinLayout Right to left languages (RTL) support

Every method/properties with a name containing `left`/`right`, has RTL enabled equivalent methods with a name containing `start`/`end`.

Using `start` or `end` methods, you can position views without having to think about whether your item will show up on the left or the right side of the screen (depending on the person’s language). 

:pushpin: In this documentation all methods that support RTL languages are marked using the following icon :left_right_arrow: 

**Method**:

* **`Pin.layoutDirection(direction: LayoutDirection)`**:left_right_arrow::  
Set the PinLayout layout direction. Note that this set PinLayout's layout direction globally. By default PinLayout use the left-to-right direction.

	Layout direction modes:
	* `.ltr`: Layout views from left to right. (Default)
	* `.rtl`: Layout views from right to left.
	* `.auto`: Layout views based on `UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)` (>= iOS 9) or `UIApplication.shared.userInterfaceLayoutDirection` (< iOS 9). If you want to control the layout direction individually for each views, you should use this mode and control the view's layout direction using `UIView.userInterfaceLayoutDirection` property.

###### Usage examples:

```swift
override func layoutSubviews() {
   super.layoutSubviews() 
   
   // Layout the contentView using the view's safeArea
   contentView.pin.all(pin.safeArea)

   let padding: CGFloat = 10
   logo.pin.top().start(padding).width(100).aspectRatio().marginTop(10)
   segmented.pin.after(of: logo, aligned: .top).end(padding).marginStart(10)
   textLabel.pin.below(of: segmented, aligned: .start).width(of: segmented).pinEdges().marginTop(10).sizeToFit(.width)
   separatorView.pin.below(of: [logo, textLabel], aligned: .start).end(to: segmented.edge.end).marginTop(10)
}
``` 

:pushpin: The complete RTL "Introduction example" [source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/IntroRTL/IntroRTLView.swift). This example is available in the [Examples App](#examples_app)