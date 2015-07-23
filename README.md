# WeCrowd iOS

## Overview
Native application for [WeCrowd] (http://wecrowd.wepay.com/), a sample crowdfunding platform that showcases easy payment transactions courtesy of the WePay [iOS SDK] (https://github.com/wepay/wepay-ios) and [API] (https://www.wepay.com/developer/). Note that WeCrowd does not actually process any payments.

## What the app is for
* The app demonstrates donation flow from two perspectives: a merchant and a payer. A merchant can accept donations via a card swiper or [virtual terminal] (https://en.wikipedia.org/wiki/Virtual_terminal). A virtual terminal is basically a way for someone (presumably a merchant) to enter credit card information on behalf of someone else (presumably a payer).
* The app is meant to be an implementation guide of sorts for platforms integrating the WePay iOS SDK. Best iOS practices have been used as much as possible.

## What the app is NOT for
* This app does not perform actual transactions or donate to any real causes.
* This app is not meant to be a full-fledged version of the WeCrowd web app. Some functionality (such as creating a campaign as a merchant) is not implemented since the primary goal of the app is to showcase the payment trasaction flow.

## External code used
Huge shout out to these awesome open source [pods] (https://cocoapods.org/)!
* [CWStatusBarNotification] (https://github.com/cezarywojcik/CWStatusBarNotification) - Used for confirmation notifications.
* [PPSSignatureView] (https://github.com/jharwig/PPSSignatureView) - Used for payer signing after card swipe donation.
* [WePay] (https://github.com/wepay/wepay-ios) - Used for all the card tokenization and signature handling.

## License
See the [LICENSE] (LICENSE.md) file for license rights and limitations (MIT).
