<p align="center">
	<img src="pinlayout-logo-small.png" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em"> Examples </h1>

The PinLayout's Example exposes some usage example of PinLayout.

The Example App is available in the [`Example`](https://github.com/layoutBox/PinLayout/tree/master/Example) folder. 

### Running the Example app
1. Do a `pod install` from the PinLayout root directory.
2. Open the newly generated `PinLayout.xcworkspace` Xcode workspace.
3. Select the `PinLayoutSample` target.
4. Run the app on your device or simulator.

</br>

## Intro Example
PinLayout introduction example presented in the README.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/Intro/IntroView.swift)

<img src="images/pinlayout_intro_example_iphonex.png" width=420/>

## Relative Edges Layout Example 
Example showing how to layout views relative to other views.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/RelativeView/RelativeView.swift)

<img src="pinlayout_exampleapp_relative_position.png" width=180/>

## Between Example
Example showing how to use [`horizontallyBetween()`](https://github.com/layoutBox/PinLayout#layout-between-other-views) to position a view between two other views.
[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/BetweenView/BetweenView.swift)

<img src="pinlayout_exampleapp_multi_relative_position.png" width=180/>

## UITableView Example
Example using a UITableView with variable height cells.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/TableViewExample/TableViewExampleView.swift)

<img src="pinlayout_exampleapp_tableview.png" width=180/>


## UITableView Example with cells using  `pin.readableMargins`
Similar to the UITableView Example, but in this one cells use `pin.readableMargins` to layout their content inside the zone defined by `UIView.readableContentGuide`.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/TableViewExample/TableViewExampleView.swift)

<img src="images/pinlayout_example_tableview_readable_content_all.png" width=420/>


## UICollectionView Example
Example using a UICollectionView with variable height cells.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/CollectionViewExample/HouseCell.swift)

<img src="pinlayout_exampleapp_collectionview.png" width=180/>

## Animations Example
Example showing how to animate views with PinLayout.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/Animations/AnimationsView.swift)

<img src="images/example-animations.gif" width=180/>

## Right to left language support Example
This example show how PinLayout can support simultaneously Left to right and right to left languages.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/IntroRTL/IntroRTLView.swift)

<img src="images/pinlayout_right_to_left_example.png" width=420/>


## pin.safeArea example
Example showing the usage of `UIView.pin.safeArea`] with UINavigationController and UITabViewController:

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/SafeArea/SafeAreaView.swift)

<img src="images/pinlayout_safearea_example_iphonex.png" width=420/>

Also display the usage of `pin.readableMargins` and `pin.layoutMargins`:

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/SafeArea/SafeAreaAndMarginsView.swift)

<img src="images/pinlayout_example_layout_margins_all.png" width=420/>


## Adjust To Container Example
Example showing how PinLayout can be used to adjust the layout depending of the space available.

In this example the UISegmentedControl is shown below its label if the available width is smaller than 500 pixels, or on the same line as the label if the width is wider.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/AdjustToContainer/Subviews/ChoiceSelectorView.swift)

<img src="pinlayout_example_adjust_to_container2.png" width=420/>


## wrapContent Example
This example show how to use the `wrapContent()` method. This method is particularly useful to wrap a group of views and center them.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/WrapContent/WrapContentView.swift)

<img src="pinlayout_example_wrapContent.png" width=180/>

## Form Example
This example is a basic form containing 4 fields. 

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/Form/FormView.swift)

<img src="pinlayout_example_form.gif" width=180/>

## Auto Adjusting Size Example
This example show how fixed size views and expandable views can be layouted using PinLayout to fill the available space.

[Source code](https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/AutoAdjustingSize/AutoAdjustingSizeView.swift)

<img src="pinlayout_exampleapp_auto_adjusting_size.png" width=180/>


## Automatic Sizing Example
This example show how to use Automatic Sizing (`autoSizeThatFits()`) to compute views size. 
[Source code](https://github.com/layoutBox/PinLayout/tree/master/Example/PinLayoutSample/UI/Examples/AutoSizing)

<img src="pinlayout_exampleapp_automatic_sizing.png" width=180/>
