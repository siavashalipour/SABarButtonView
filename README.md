# SABarButtonView

[![CI Status](http://img.shields.io/travis/Siavash/SABarButtonView.svg?style=flat)](https://travis-ci.org/Siavash/SABarButtonView)
[![Version](https://img.shields.io/cocoapods/v/SABarButtonView.svg?style=flat)](http://cocoapods.org/pods/SABarButtonView)
[![License](https://img.shields.io/cocoapods/l/SABarButtonView.svg?style=flat)](http://cocoapods.org/pods/SABarButtonView)
[![Platform](https://img.shields.io/cocoapods/p/SABarButtonView.svg?style=flat)](http://cocoapods.org/pods/SABarButtonView)

## What it is?

SABarButtonView is a simple UIView subclass that creates tabBarButtons and handle the toggles between the views for you. It is easy to use since you can modify almost all the TabBar component inside the interface builder.

![SABarButtonView Example](http://i.imgur.com/vjPrB05.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SABarButtonView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SABarButtonView"
```
## How to create and use a SABarButtonView

Simply add a UIView to your UIViewController and change to class to SABarButtonView. Then you can modify the properties by tapping on Attribute inspecter.

![SABarButtonView Example](http://i.imgur.com/36qbpEU.gif)


For example lets say you have 3 TabBarButtons. You also need to have 3 toggle able views as well. Simply create 3 custom Views and connect them to toggleAbleViews OutletCollection of the SABarButtonView.

![SABarButtonView Example](http://i.imgur.com/zYzIHeN.gif)

No all you need is to have an outlout for your SABarButtonView in you ViewController and set the "btnsTitles" property of the SABarButtonView.

```swift
 @IBOutlet var tabBar:SABarButtonView!
 tabBar.btnsTitles = ["View 1","View 2","View 3"]
```
## Release Notes

Version 0.1.1
* Fixed delay in toggeling views
* Update podsepec

Version 0.1.0
* Initial release
## Author

[Siavash Alipour](http://www.siavashalipour.com)

## License

SABarButtonView is available under the MIT license. See the LICENSE file for more info.
