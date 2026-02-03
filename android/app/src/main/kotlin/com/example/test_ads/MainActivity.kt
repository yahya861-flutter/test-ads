package com.example.test_ads

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Register 10 native ad factories (Light)
        for (i in 1..10) {
            val factoryId = "native_ad_factory_$i"
            val layoutId = resources.getIdentifier("native_ad_$i", "layout", packageName)
            if (layoutId != 0) {
                GoogleMobileAdsPlugin.registerNativeAdFactory(
                    flutterEngine, factoryId, MyNativeAdFactory(layoutInflater, layoutId)
                )
            }
        }

        // Register 10 native ad factories (Dark)
        for (i in 1..10) {
            val factoryId = "native_ad_factory_${i}_dark"
            val layoutId = resources.getIdentifier("native_ad_${i}_dark", "layout", packageName)
            if (layoutId != 0) {
                GoogleMobileAdsPlugin.registerNativeAdFactory(
                    flutterEngine, factoryId, MyNativeAdFactory(layoutInflater, layoutId)
                )
            }
        }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        for (i in 1..10) {
            GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "native_ad_factory_$i")
            GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "native_ad_factory_${i}_dark")
        }
    }
}
