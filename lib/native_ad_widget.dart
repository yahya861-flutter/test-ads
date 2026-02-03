import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatefulWidget {
  final int styleIndex;
  final TemplateType templateType;
  final Alignment infoPlacement;

  const NativeAdWidget({
    super.key,
    this.styleIndex = 0,
    this.templateType = TemplateType.small,
    this.infoPlacement = Alignment.topRight,
  });

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: _adUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd loaded with style index: ${widget.styleIndex}');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      factoryId: 'native_ad_factory_${widget.styleIndex + 1}',
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  void _showAdInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Why you see this ad"),
        content: const Text(
          "This ad is shown based on test configurations. In a real app, ads are personalized by Google based on your interests and activity.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_nativeAdIsLoaded || _nativeAd == null) return const SizedBox.shrink();

    double minHeight;
    double maxHeight;

    switch (widget.styleIndex) {
      case 0: // Design 1: Classic
        minHeight = 80;
        maxHeight = 270;
        break;
      case 1: // Design 2: Dark
        minHeight = 150;
        maxHeight = 280;
        break;
      case 2: // Design 3: High Headline
        minHeight = 250;
        maxHeight = 350;
        break;
      case 3: // Design 4: Media Focused
        minHeight = 100;
        maxHeight = 180;
        break;
      case 4: // Design 5: Compact List (No Media)
        minHeight = 80;
        maxHeight = 80;
        break;
      case 5: // Design 6: Icon Right (No Media)
        minHeight = 100;
        maxHeight = 120;
        break;
      case 6: // Design 7: Purple
        minHeight = 150;
        maxHeight = 250;
        break;
      case 7: // Design 8: Luxury
        minHeight = 200;
        maxHeight = 350;
        break;
      case 8: // Design 9: Modern
        minHeight = 280;
        maxHeight = 320;
        break;
      case 9: // Design 10: Full Media
        minHeight = 180;
        maxHeight = 300;
        break;
      default:
        minHeight = 150;
        maxHeight = 350;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // The Ad
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 320,
              minHeight: minHeight,
              maxWidth: 400,
              maxHeight: maxHeight,
            ),
            child: AdWidget(ad: _nativeAd!),
          ),
        ],
      ),
    );
  }
}
