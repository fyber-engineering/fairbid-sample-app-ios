# FairBid - iOS Sample App

This sample app demonstrates the FairBid SDK integration best practices. It is aligned with the FairBid developer documentation - [developer.fyber.com](https://developer.fyber.com), which we recommend you to read as well.

Please note that when it comes to actually demonstrating the product "FairBid" as a monetization platform this sample app might fail due to the fact that ad delivery depends on factors like your country, your device your AAID/IDFA or any other kind of information that ad networks might have collected about you and that are taken into consideration when placing a bid to show an ad to you.

## Prerequisites

* Xcode
* CocoaPods

#### Navigating the sample code
* SDK Initialization is located in the [AppDelegate](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AppDelegate.swift)
    * Appid is defined in line 20 of [AppDelegate](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AppDelegate.swift)
* Requesting Banner Ads - [AdsScreenViewController.swift](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AdsScreenViewController.swift)
    * Placement id for Banner Ads is defined in line 16 [AdsScreenViewController.swift](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AdsScreenViewController.swift)
* Requesting Interstitial Ads - [AdsScreenViewController.swift](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AdsScreenViewController.swift)
    * Placement id for Interstitial Ads is defined in line 14 of [AdsScreenViewController.swift](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AdsScreenViewController.swift)
* Requesting Rewarded Ads - [AdsScreenViewController.swift](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AdsScreenViewController.swift)
    * Placement id for Rewarded Ads is defined in line 15 of [AdsScreenViewController.swift](https://github.com/fyber-engineering/fairbid-sample-app-ios/blob/master/Fyber%20FairBid/AdsScreenViewController.swift)

#### Support and documentation
Please visit our [documentation](https://developer.fyber.com/hc/en-us/sections/360002888357-FairBid-iOS-Configuration)

## Setup

Install the pods

```sh
pod install
```

Open `Fyber FairBid.xcworkspace` file.

```sh
open "Fyber FairBid.xcworkspace"
```
