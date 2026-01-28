import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize AdMob BEFORE runApp
  await MobileAds.instance.initialize();
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
    // _loadInterstitialAd();
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
                _showInterstitialAd();
              },
              child: const Text("Show Ad", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _loadInterstitialAd();
              },
              child: const Text("Load Ad", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('Interstitial Ad Loaded');

          _interstitialAd = ad;

        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Interstitial Ad failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {

      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Ad showed full screen content.');
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Failed to show full screen content: $error');
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Ad dismissed.');
              ad.dispose();
              _loadInterstitialAd(); // reload ad for next time
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
    }
  }
}
