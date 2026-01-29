import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  static bool isOtherAdShowing = false;
  DateTime? _loadTime;

  void loadAd() {
    print('AppOpenAdManager: Loading ad...');
    AppOpenAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/9257395921'
          : 'ca-app-pub-3940256099942544/5575463023',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('AppOpenAdManager: Ad loaded successfully.');
          _appOpenAd = ad;
          _loadTime = DateTime.now();
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAdManager: Failed to load ad: $error');
        },
      ),
    );
  }

  bool _isAdAvailable() {
    return _appOpenAd != null &&
        _loadTime != null &&
        DateTime.now().difference(_loadTime!).inHours < 4;
  }

  void showAdIfAvailable() {
    print('AppOpenAdManager: Checking if ad is available...');
    if (!_isAdAvailable()) {
      print('AppOpenAdManager: Ad is not available or expired. Loading new ad.');
      loadAd();
      return;
    }
    if (_isShowingAd || isOtherAdShowing) {
      print('AppOpenAdManager: Already showing an ad (App Open: $_isShowingAd, Other: $isOtherAdShowing).');
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('AppOpenAdManager: Ad showed full screen content.');
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('AppOpenAdManager: Failed to show full screen content: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('AppOpenAdManager: Ad dismissed.');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    print('AppOpenAdManager: Showing ad...');
    _appOpenAd!.show();
  }
}

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;
  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    print('AppLifecycleReactor: Starting to listen to app state changes...');
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      print('AppLifecycleReactor: App state changed to: $state');
      if (state == AppState.foreground) {
        appOpenAdManager.showAdIfAvailable();
      }
    });
  }
}