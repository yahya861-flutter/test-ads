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
      case 0: // Design 1
        minHeight = 240;
        maxHeight = 270;
        break;
      case 1: // Design 2
        minHeight = 140;
        maxHeight = 160;
        break;
      case 2: // Design 3
        minHeight = 80;
        maxHeight = 100;
        break;
      case 3: // Design 4
        minHeight = 350;
        maxHeight = 380;
        break;
      case 4: // Design 5
        minHeight = 85;
        maxHeight = 85;
        break;
      case 5: // Design 6
        minHeight = 150;
        maxHeight = 160;
        break;
      case 6: // Design 7
        minHeight = 340;
        maxHeight = 360;
        break;
      case 7: // Design 8
        minHeight = 350;
        maxHeight = 370;
        break;
      case 8: // Design 9
        minHeight = 340;
        maxHeight = 360;
        break;
      case 9: // Design 10
        minHeight = 140;
        maxHeight = 160;
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
        color: widget.isDark 
            ? (widget.styleIndex == 8 ? const Color(0xFF111827) : const Color(0xFF121212)) 
            : Colors.white,
        borderRadius: (widget.styleIndex == 0 || widget.styleIndex == 8)
            ? BorderRadius.zero 
            : BorderRadius.circular(10),
        boxShadow: (widget.styleIndex == 0 || widget.styleIndex == 8)
            ? [] // No shadow for squared/flat designs to match XML background
            : [
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
    
    // Style 0 (Design 1) and Style 8 (Design 9) use 0dp root padding in XML
    final padding = (widget.styleIndex == 4 || widget.styleIndex == 0 || widget.styleIndex == 8) ? 0.0 : 12.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      height: maxHeight,
      decoration: BoxDecoration(
        color: widget.isDark 
            ? (widget.styleIndex == 8 ? const Color(0xFF111827) : const Color(0xFF121212)) 
            : Colors.white,
        borderRadius: (widget.styleIndex == 0 || widget.styleIndex == 8)
            ? BorderRadius.zero 
            : BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: (widget.styleIndex == 0 || widget.styleIndex == 8) 
                ? MainAxisAlignment.start 
                : MainAxisAlignment.center,
            children: _buildShimmerContent(baseColor),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildShimmerContent(Color baseColor) {
    if (widget.styleIndex == 0) {
      return [
        // Header Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: baseColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 120,
              height: 18,
              color: baseColor,
            ),
            const Spacer(),
            Container(
              width: 25,
              height: 14,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 60,
              height: 14,
              color: baseColor,
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Media Section
        Container(
          width: double.infinity,
          height: 120,
          color: baseColor,
        ),
        const SizedBox(height: 12),
        // CTA Button
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ];
    }

    if (widget.styleIndex == 1) {
      return [
        // Top Divider
        Container(width: double.infinity, height: 1, color: baseColor),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AD Badge indicator
            Container(
              width: 25,
              height: 16,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 15),
            // Media
            Container(
              width: 120,
              height: 120,
              color: baseColor,
            ),
            const SizedBox(width: 10),
            // Text + Button Pillar
            Expanded(
              child: Column(
                children: [
                  Container(height: 18, color: baseColor),
                  const SizedBox(height: 8),
                  Container(height: 14, color: baseColor),
                  const SizedBox(height: 4),
                  Container(width: 80, height: 14, color: baseColor),
                  const SizedBox(height: 25),
                  Container(
                    width: 120,
                    height: 36,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Bottom Divider
        Container(width: double.infinity, height: 1, color: baseColor),
      ];
    }

    if (widget.styleIndex == 2) {
      return [
        // Top Divider
        Container(width: double.infinity, height: 1, color: baseColor),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Pill
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(left: 15, right: 10),
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // Middle Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 16, color: baseColor),
                  const SizedBox(height: 4),
                  Container(width: 100, height: 12, color: baseColor),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // CTA Button Pill
            Container(
              width: 80,
              height: 48,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Bottom Divider
        Container(width: double.infinity, height: 1, color: baseColor),
      ];
    }

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
                    height: 18,
                    color: baseColor,
                  ),
                  const SizedBox(height: 8),
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
                          height: 14,
                          color: baseColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12), // Match XML marginBottom="12dp"
        // Big CTA Button placeholder
        Container(
          width: double.infinity,
          height: 50, // Match XML: 50dp
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(25),
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
                  const SizedBox(height: 4), // Match XML layout_marginTop="4dp"
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
                        child: Container(
                          height: 14,
                          color: baseColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // Match XML layout_marginTop="10dp"
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

    if (widget.styleIndex == 6) {
      return [
        // Header Row (Icon + Text Column)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(height: 18, color: baseColor),
                  const SizedBox(height: 2), // Match XML layout_marginTop="2dp"
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
                      Expanded(child: Container(height: 14, color: baseColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12), // Match XML layout_marginTop="12dp"
        // Media View Skeleton
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 10), // Match XML layout_marginTop="10dp"
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

    if (widget.styleIndex == 7) {
      return [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border.all(color: baseColor.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Top-Left Badge
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 32,
                  height: 24,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Section 2: Square Icon + Text Pillar
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  // Square Icon
                  Container(
                    width: 60,
                    height: 60,
                    color: baseColor,
                  ),
                  const SizedBox(width: 12),
                  // Text Pillar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(height: 18, color: baseColor),
                        const SizedBox(height: 8),
                        Container(height: 14, color: baseColor),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(width: double.infinity, height: 14, color: baseColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Match XML marginTop="12dp"
              // Section 3: Media View Skeleton
              Center(
                child: Container(
                  width: 320, // Match XML layout_width="320dp"
                  height: 180,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 12), // Match XML marginTop="12dp"
              // Section 4: CTA Button
              Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  height: 50,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              // Extra view removed here
            ],
          ),
        ),
      ];
    }
    if (widget.styleIndex == 8) {
      return [
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Top-Left Badge
              Container(
                width: 32,
                height: 20,
                color: baseColor,
              ),
              // Section 2: Header Row: Icon + Texts
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      color: baseColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 18, color: baseColor),
                          const SizedBox(height: 6),
                          Container(width: 150, height: 14, color: baseColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Section 3: Media View
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  color: baseColor,
                ),
              ),
              // Section 4: CTA Button
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 12),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
    }

    if (widget.styleIndex == 9) {
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Pillar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 18, color: baseColor),
                  const SizedBox(height: 6),
                  Container(height: 14, color: baseColor),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Right Media
            Container(
              width: 140,
              height: 120,
              color: baseColor,
            ),
          ],
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
