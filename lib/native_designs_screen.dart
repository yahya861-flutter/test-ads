import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'native_ad_widget.dart';

class NativeDesignsScreen extends StatefulWidget {
  const NativeDesignsScreen({super.key});

  @override
  State<NativeDesignsScreen> createState() => _NativeDesignsScreenState();
}

class _NativeDesignsScreenState extends State<NativeDesignsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Native Ad Designs"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Buttons Row
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                bool isSelected = _selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text("Design ${index + 1}"),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }
                    },
                    selectedColor: Colors.green,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          
          const Divider(height: 1),

          // Selected Ad Display
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Design ${_selectedIndex + 1}: ${_getDesignName(_selectedIndex)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "This design is loaded using custom Android XML. Click the 'i' icon to see why this ad is shown.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Key allows forcing a fresh load when switching designs
                  KeyedSubtree(
                    key: ValueKey('ad_$_selectedIndex'),
                    child: NativeAdWidget(styleIndex: _selectedIndex),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDesignName(int index) {
    const names = [
      "Classic Small",
      "Dark Premium",
      "High Headline",
      "Media Focused",
      "Compact List",
      "Icon on Right",
      "Soft Purple",
      "Gold Luxury",
      "Minimalist Blue",
      "High Coverage"
    ];
    return index < names.length ? names[index] : "Custom Design";
  }
}
