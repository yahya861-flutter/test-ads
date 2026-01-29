import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:test_ads/third_screen.dart';

import 'app_open_ad_manager.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    _loadBanner();
    _loadRewardedAd();
  }

  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Android ID
      : 'ca-app-pub-3940256099942544/2934735716'; // iOS ID

  final String rewardedAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  // banner ad
  void _loadBanner() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded ad before loaded.');
      Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('Ad showed full screen content.');
        AppOpenAdManager.isOtherAdShowing = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('Ad dismissed full screen content.');
        AppOpenAdManager.isOtherAdShowing = false;
        ad.dispose();
        _loadRewardedAd();
        Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Ad failed to show full screen content: $error');
        AppOpenAdManager.isOtherAdShowing = false;
        ad.dispose();
        _loadRewardedAd();
        Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Banner ad section below"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showRewardedAd,
              child: const Text("Watch Ad to go to Third Screen"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isBannerAdReady
          ? Container(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          : null,
    );
  }
}