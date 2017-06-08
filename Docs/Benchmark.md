<p align="center">
	<img src="pinlayout-logo-small.png" alt="PinLayout Performance" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout Benchmark</h1>

## Methodology

##### LayoutKit Benchmark
PinLayout's performance has been tested using a fork of [LayoutKit](https://github.com/mirego/LayoutKit). LayoutKit's example app include a really nice benchmark. 

The benchmark has been modified to also include PinLayout. [See PinLayout implementation source code](https://github.com/mirego/LayoutKit/blob/master/LayoutKitSampleApp/Benchmarks/FeedItemPinLayoutView.swift). Remark that PinLayout's layout code is concise, clean and doesn't contain any computation in `layoutSubviews()`, compared to [Manual Layouting source code](https://github.com/mirego/LayoutKit/blob/master/LayoutKitSampleApp/Benchmarks/FeedItemManualView.swift)

The benchmark include tests for the following layout systems:

* Auto layout
* Auto layout using UIStackViews
* LayoutKit
* Manual layout (i.e. set UIView's frame directly)
* PinLayout

Anyone who would like to integrate any other layout frameworks to this GitHub repository is welcome.

##### Benchmark details
The LayoutKit benchmark layout UICollectionView and UITableView cells in multiple pass, each pass contains more cells than the previous one. The **X axis** in following charts indicates the number of cell contained for each pass. The **Y axis** indicates the number of miliseconds to render all cells from one pass.

Here are the rendering results to compare visual results:
 
* [Auto layout rendering result](Benchmark/Benchmark-Autolayout.png)
* [LayoutKit rendering result](Benchmark/Benchmark-PinLayout.png)
* [PinLayout rendering result](Benchmark/Benchmark-LayoutKit.png)

## Results

As you can see in the following chart, PinLayout's performance is as fast as manual layouting, and up to **12x faster than auto layout**, and **16x faster than UIStackViews**. LayoutKit is also realy fast, slightly slower than PinLayout and manual layouting.

These results also means that PinLayout is by far faster than any layout frameworks that is built over auto layout ([SnapKit](https://github.com/SnapKit/SnapKit), [Stevia](https://github.com/freshOS/Stevia), [PureLayout](https://github.com/PureLayout/PureLayout), ...). 

It takes almost half a second (0.468 ms) to render 100 UICollectionView's cells using UIStackViews, and 1/3 of second (0.344) using auto layout. And all these results are on a iPhone 6S device.


<p align="center">iPhone 6S - iOS 10.3.2</p>
<p align="center">
  <a href="https://mirego.github.io/PinLayout/"><img src="Benchmark/Chart-iPhone6S.png" alt="PinLayout Performance"/></a>
<p align="center" style="font-size:10px;">X axis in the number cells in a UICollectionView, and Y axis is the time in miliseconds to layout all cells.</p>
</p> 

You can have a look at the [spreadsheet containing all the data](Benchmark/Benchmark-iPhone6S.xlsx)

### Other device's chart will be coming soon...
