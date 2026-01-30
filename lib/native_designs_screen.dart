import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'native_ad_widget.dart';

class NativeDesignsScreen extends StatelessWidget {
  const NativeDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Native Ads: Sizes & Placements"),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("1. Small Template - Top Right Info", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const NativeAdWidget(styleIndex: 0, templateType: TemplateType.small, infoPlacement: Alignment.topRight),
          
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("2. Small Template - Top Left Info", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const NativeAdWidget(styleIndex: 2, templateType: TemplateType.small, infoPlacement: Alignment.topLeft),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("3. Medium Template - Bottom Right Info", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const NativeAdWidget(styleIndex: 1, templateType: TemplateType.medium, infoPlacement: Alignment.bottomRight),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("4. Medium Template - Bottom Left Info", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const NativeAdWidget(styleIndex: 4, templateType: TemplateType.medium, infoPlacement: Alignment.bottomLeft),

          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("More Designs...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          ...List.generate(6, (index) {
            int styleIdx = index + 3;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Design $styleIdx: ${_getDesignName(styleIdx)}"),
                ),
                NativeAdWidget(styleIndex: styleIdx, templateType: index % 2 == 0 ? TemplateType.small : TemplateType.medium),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _getDesignName(int index) {
    const names = [
      "Default Blue",
      "Dark Premium",
      "Modern Orange",
      "Minimalist Gray",
      "Forest Green",
      "Luxury Gold",
      "High Contrast",
      "Soft Pastel",
      "Professional Red",
      "Night Mode"
    ];
    return index < names.length ? names[index] : "Unknown";
  }
}
