import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/second_screen.dart';
import 'package:test_ads/native_ad_widget.dart';
import 'package:test_ads/app_open_ad_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize AdMob BEFORE runApp
  await MobileAds.instance.initialize();

  // ✅ Set test device IDs to resolve 403 errors on specific devices/emulators
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(testDeviceIds: ["E0F65D1E4F74AFD41F224BB4751E8ADE"]),
  );

  // ✅ Initialize App Open Ad
  AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
  AppLifecycleReactor(appOpenAdManager: appOpenAdManager).listenToAppStateChanges();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: home());
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  InterstitialAd? _interstitialAd; // reference to loaded ad

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _showInterstitialAd(context);
              },
              child: const Text("Show Ad and move", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            const NativeAdWidget(),
            const SizedBox(height: 20),
            const NativeAdWidget(),


          ],
        ),
      ),
    );
  }
// intersetion ad function
  void _loadInterstitialAd() {
    final adUnitId = Platform.isAndroid
        ? "ca-app-pub-3940256099942544/1033173712"
        : "ca-app-pub-3940256099942544/4411468910";

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('Interstitial Ad Loaded');

          _interstitialAd = ad;

        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Interstitial Ad failed to load: $error');
          debugPrint('TIP: If you see "Received error HTTP response code: 403", check your logs for your device ID and add it to MobileAds.instance.updateRequestConfiguration in main.dart');
        },
      ),
    );
  }

  void _showInterstitialAd(BuildContext context) {
    if (_interstitialAd != null) {

      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Ad showed full screen content.');
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Failed to show full screen content: $error');
              ad.dispose();
              _loadInterstitialAd();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Ad dismissed.');
              ad.dispose();
              _loadInterstitialAd(); // reload ad for next time
              Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
            },
            onAdImpression: (ad) {
              debugPrint('Ad impression recorded.');
            },
            onAdClicked: (ad) {
              debugPrint('Ad clicked.');
            },
          );
      _interstitialAd!.show();
      // _interstitialAd = null;
    } else {
      debugPrint('Interstitial ad not ready yet');
      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
    }
  }

}
