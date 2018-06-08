<p align="center">
	<img src="pinlayout-logo-small.png" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout using Objective-C</h1>

PinLayout can also be used from Objective-C. The PinLayout interface is slightly different from the Swift interface due to more limited Objective-C parameters definitions.

###### Example 1:
This example implement the PinLayout's Intro example using objective-c 

<a href="https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/Intro/IntroView.swift"><img src="images/pinlayout_intro_example_iphonex.png"/></a>

```
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [[[[[[logo.pinObjc top] left] width:100] aspectRatio] marginWithTop:topLayoutGuide + 10 horizontal:10 bottom:10] layout];
    [[[[segmented.pinObjc rightOf:logo aligned:VerticalAlignTop] right] marginHorizontal:10] layout];
    [[[[[[textLabel.pinObjc belowOf:segmented aligned:HorizontalAlignLeft] widthOf:segmented] pinEdges] marginTop:10] fitSize] layout];
    [[[[[separatorView.pinObjc belowOfViews:@[logo, textLabel] aligned:HorizontalAlignLeft] rightTo:segmented.edge.right] height:1] marginTop:10] layout];
}

``` 

:pushpin: This example is available in the Examples App. See example complete [source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/IntroObjectiveC/IntroObjectiveCView.m)

## Important notes about PinLayout's Objective-c interface

#### `pinObjc` property
The PinLayout's objective-c interface is available using the property `pinObjc` (instead of `pin` in Swift)

```
 [[view.pinObjc top] layout];
``` 

#### `layout()`

**Method:**

* **`layout()`**  
When using the Objective-c interface, the `layout` method must be called explicitly to complete the view's layout. The method will execute PinLayout commands immediately. In Swift, PinLayout executes this method implicitly, it is not necessary to call it. 


```
 // Swift
 view.pin.width(100)

 // Objective-c
 [[view.pinObjc width:100] layout];
``` 

