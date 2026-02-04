import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

class NativeAdWidget extends StatefulWidget {
  final int styleIndex;
  final TemplateType templateType;
  final Alignment infoPlacement;
  final bool isDark;

  const NativeAdWidget({
    super.key,
    this.styleIndex = 0,
    this.templateType = TemplateType.small,
    this.infoPlacement = Alignment.topRight,
    this.isDark = false,
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
      factoryId: 'native_ad_factory_${widget.styleIndex + 1}${widget.isDark ? '_dark' : ''}',
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double minHeight;
    double maxHeight;

    switch (widget.styleIndex) {
      case 0:
        minHeight = 80;
        maxHeight = 270;
        break;
      case 1:
        minHeight = 120;
        maxHeight = 180;
        break;
      case 2:
        minHeight = 80;
        maxHeight = 100;
        break;
      case 3:
        minHeight = 350;
        maxHeight = 380;
        break;
      case 4:
        minHeight = 85;
        maxHeight = 85;
        break;
      case 5:
        minHeight = 150;
        maxHeight = 160;
        break;
      case 6:
        minHeight = 150;
        maxHeight = 300;
        break;
      case 7:
        minHeight = 200;
        maxHeight = 380;
        break;
      case 8:
        minHeight = 80;
        maxHeight = 120;
        break;
      case 9:
        minHeight = 100;
        maxHeight = 150;
        break;
      default:
        minHeight = 150;
        maxHeight = 350;
    }

    if (!_nativeAdIsLoaded || _nativeAd == null) {
      return _buildShimmerPlaceholder(maxHeight);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 320,
          minHeight: minHeight,
          maxWidth: 400,
          maxHeight: maxHeight,
        ),
        child: AdWidget(ad: _nativeAd!),
      ),
    );
  }

  Widget _buildShimmerPlaceholder(double maxHeight) {
    final baseColor = widget.isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = widget.isDark ? Colors.grey[800]! : Colors.grey[100]!;
    
    // Style 4 is very short (85dp), so we use less padding to prevent overflow
    final padding = (widget.styleIndex == 4) ? 0.0 : 12.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      height: maxHeight,
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildShimmerContent(baseColor),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildShimmerContent(Color baseColor) {
    if (widget.styleIndex == 3) {
      return [
        // Media placeholder
        Container(
          width: double.infinity,
          height: 200,
          color: baseColor,
        ),
        const SizedBox(height: 12),
        // Icon + Headline row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: baseColor,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 12,
                    color: baseColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Big CTA Button placeholder
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ];
    }

    if (widget.styleIndex == 4) {
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            // Middle section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Badge + Headline
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 14,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 16,
                          color: baseColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Body
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: baseColor,
                    margin: const EdgeInsets.only(right: 12),
                  ),
                ],
              ),
            ),
            // Vertical CTA
            Container(
              width: 100,
              height: 85,
              color: baseColor,
            ),
          ],
        ),
      ];
    }

    if (widget.styleIndex == 5) {
      return [
        // Top Row: Icon + (Headline, Badge & Body)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            // Text Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Headline
                  Container(
                    width: double.infinity,
                    height: 18,
                    color: baseColor,
                  ),
                  const SizedBox(height: 8),
                  // Badge + Body
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 16,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 12,
                              color: baseColor,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 150,
                              height: 12,
                              color: baseColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // CTA Button
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ];
    }

    // Default shimmer content
    return [
      Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: baseColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 14,
                  color: baseColor,
                ),
                const SizedBox(height: 6),
                Container(
                  width: 100,
                  height: 10,
                  color: baseColor,
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Expanded(
        child: Container(
          width: double.infinity,
          color: baseColor,
        ),
      ),
      const SizedBox(height: 16),
      Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ];
  }
}
