<p align="center">
	<img src="pinlayout-logo-small.png" width=100/>
</p>

## PinLayout principles and philosophy

* Manual layouting (doesn't rely on auto layout).

* PinLayout exist to be simple and fast as possible! In fact, it is fast as manual layouting. See [performance results below.](#performance)

* Full control: You're in the middle of the layout process, no magic black box. 
	* You can add conditions (if/switch/guard/...) related to the device orientation, device type, traitCollection, animations, ...
	* You can add iterations and enumerations (for/while/forEach/...)

* Layout one view at a time. Make it simple to code and debug.

* Concise syntax. Layout most views using a single line. 

* Stateless
	* PinLayout doesn’t add any stored properties to UIView/NSView. It simply computes the view's frame property, one view at a time.
	* Since it is stateless, it can be used with any other layout framework without conflicts. 
Each view can use the layout system that better suit it  (PinLayout, autolayout, flexbox, …)

* No Auto layout and constraints
	* Constraints are verbose and quite hard for a human brains to understand when there are many views implicated, even with sugar-syntax frameworks.
	* PinLayout positions views as a designer would explain it (eg: “The TextField is below the Label, aligned left, and is its width matches the other view’s width“). 
	* No priorities, simply layout views in the order that makes sense. No priorities required.

* Before applying the new sets of attributes, PinLayout always start with the view’s current frame. So its possible to set the view’s size during the initialization (ex: view.pin.width(100).height(200)), and later only position the view (ex: view.pin.top(10).left(20)). This makes PinLayout really animation friendly.

* Not too intrusive. PinLayout only adds three properties to existing iOS classes: `UIView.pin`, `UIView.anchor` and `UIView.edge`	
* Minimize as much as possible calculations and constants when layouting views. But it is always possible to add advanced computation if required.

* Method's name match as much as possible other layout frameworks, including [FlexLayout](https://github.com/layoutBox/FlexLayout)/flexbox, CSS, React Native, …