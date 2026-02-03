import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'native_ad_widget.dart';

class NativeDesignsScreen extends StatefulWidget {
  final bool isDark;
  const NativeDesignsScreen({super.key, this.isDark = false});

  @override
  State<NativeDesignsScreen> createState() => _NativeDesignsScreenState();
}

class _NativeDesignsScreenState extends State<NativeDesignsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
    Color cardColor = widget.isDark ? const Color(0xFF1E1E1E) : Colors.white;
    Color textColor = widget.isDark ? Colors.white : Colors.black;
    Color subTextColor = widget.isDark ? Colors.white70 : Colors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Native Ad Designs ${widget.isDark ? '(Dark)' : ''}"),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Buttons Row
          Container(
            height: 60,
            //padding: const EdgeInsets.symmetric(vertical: 8),
            color: cardColor,
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
                    backgroundColor: widget.isDark ? Colors.grey[800] : null,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : textColor,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(widget.isDark ? 0.3 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Design ${_selectedIndex + 1}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.isDark ? Colors.blueAccent : Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This design is loaded using custom Android XML. Click the 'i' icon to see why this ad is shown.",
                          style: TextStyle(fontSize: 13, color: subTextColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Key allows forcing a fresh load when switching designs
                  KeyedSubtree(
                    key: ValueKey('ad_${_selectedIndex}_${widget.isDark}'),
                    child: NativeAdWidget(
                      styleIndex: _selectedIndex,
                      isDark: widget.isDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
