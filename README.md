# test_ads

A Flutter project demonstrating **complete Google AdMob ads integration** with multiple custom native ad designs on both **Android (Kotlin)** and **iOS (Swift)**.

## Overview

This project is built as a reference implementation for integrating ads in a real-world Flutter application. It focuses on **Native Ads with multiple UI designs**, proper platform separation, and support for **Light and Dark themes** across Android and iOS.

The goal of this project is to show how Flutter can communicate with **platform‑specific native UI code** while keeping the Flutter layer clean and reusable.

## Features

### Native Ads (Main Focus)

* **10 custom Native Ad designs on Android**

  * Implemented separately in **Kotlin**
  * Each design uses its own XML layout

* **10 custom Native Ad designs on iOS**

  * Implemented separately using **Swift (UIView-based layouts)**
  * Each design is registered as an individual Native Ad Factory

* **Light Mode & Dark Mode support**

  * Separate layouts/design handling for both themes
  * Ads automatically adapt to the app theme

* Clean separation of:

  * Flutter UI
  * Android native ad layouts
  * iOS native ad layouts

### Other Ad Formats Included

* **Banner Ads**
* **Interstitial Ads**
* **Rewarded Ads**
* **App Open Ads**

All ad formats are integrated following Google AdMob best practices.

## Platform Details

### Android (Kotlin)

* Native Ads implemented using:

  * `NativeAdView`
  * Custom XML layouts
* 10 different design variants
* Full control over icon, headline, CTA, media view, and layout sizing
* Separate handling for light and dark UI

### iOS (Swift)

* Native Ads implemented using:

  * `GADNativeAdView`
  * Programmatic UI with `UIView`, `UIStackView`, and Auto Layout
* 10 independent Native Ad Factory classes
* Light and dark mode supported via dynamic colors

## Architecture

* Flutter acts as the main UI and navigation layer
* Platform-specific ad rendering handled via:

  * **Platform Views / Native Ad Factories**
* Each native ad design is:

  * Isolated
  * Easily maintainable
  * Replaceable without affecting other designs

## Use Case

This project is ideal for:

* Learning **advanced AdMob Native Ads integration**
* Understanding Flutter ↔ Native (Kotlin/Swift) communication
* Implementing **multiple ad designs for A/B testing**
* Supporting **Dark & Light themes in ads**
* Real production-level ad handling in Flutter apps

## Getting Started

If this is your first Flutter project, check out the resources below:

* [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For full Flutter documentation:

* [Flutter Official Docs](https://docs.flutter.dev/)

## Notes

* Make sure to replace test AdMob IDs with your **own production IDs** before publishing.
* Follow Google AdMob policies strictly when using Native Ads.

---

**Built for learning, testing, and production‑ready ad integration in Flutter.**
