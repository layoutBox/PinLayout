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

    CGFloat margin = 10;
    UIEdgeInsets safeArea = self.pinObjc.safeArea;

    logo.pinObjc.topInsets(safeArea).leftInsets(safeArea).width(100).aspectRatio().margin(margin).layout();
    segmented.pinObjc.rightOfAligned(logo, VerticalAlignTop).rightInsets(safeArea).marginHorizontal(margin).layout();
    textLabel.pinObjc.belowOfAligned(segmented, HorizontalAlignLeft).widthOf(segmented).pinEdges().marginTop(margin).sizeToFitType(FitWidth).layout();
    separatorView.pinObjc.belowOfViewsAligned(@[logo, textLabel], HorizontalAlignLeft).rightToEdge(segmented.edge.right).height(1).marginTop(margin).layout();
}

``` 

:pushpin: This example is available in the Examples App. See example complete [source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/IntroObjectiveC/IntroObjectiveCView.m)

## Important notes about PinLayout's Objective-c interface

#### `pinObjc` property
The PinLayout's objective-c interface is available using the property `pinObjc` (instead of `pin` in Swift)

```
 view.pinObjc.top().layout();
``` 

#### `layout()`

**Method:**

* **`layout()`**  
When using the Objective-c interface, the `layout` method must be called explicitly to complete the view's layout. The method will execute PinLayout commands immediately. In Swift, PinLayout executes this method implicitly, it is not necessary to call it. 


```
 // Swift
 view.pin.width(100)

 // Objective-c
 view.pinObjc.width(100).layout();
``` 

