<p align="center">
	<img src="pinlayout-logo-small.png" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout and Xcode Playgrounds</h1>

## Using PinLayout with Xcode Playgrounds <a name="playgrounds"></a>
PinLayout layouts views immediately after the line containing `.pin` has been fully executed, thanks to ARC (Automatic Reference Counting) this works perfectly on iOS/tvOS/macOS simulators and devices. But in Xcode Playgrounds, ARC doesn't work as expected, object references are kept much longer. This is a well documented issue. The impact of this problem is that PinLayout doesn't layout views at the time and in the order required. To handle this situation in playgrounds it is possible to call the `layout()` method to complete the layout.

**Method:**

* **`layout()`**  
The method will execute PinLayout commands immediately. This method is **required only if your source codes should also work in Xcode Playgrounds**. Outside of playgrounds, PinLayout executes this method implicitly, it is not necessary to call it. 

###### Usage Examples:

```swift
    view.pin.top(20).bottom(20).width(100).layout()
    view2.pin.below(of: view).horizontally().layout()
```

**TIP**: If your codes needs to work in Xcode playgrounds, you may set to `true` the property `Pin.logMissingLayoutCalls`, this way any missing call to `layout()` will generate a warning in the Xcode console.
