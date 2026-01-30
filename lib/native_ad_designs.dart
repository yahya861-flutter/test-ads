import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdDesigns {
  static NativeTemplateStyle getStyle(int index, {TemplateType templateType = TemplateType.small}) {
    switch (index) {
      case 0:
        return _defaultBlue(templateType);
      case 1:
        return _darkPremium(templateType);
      case 2:
        return _modernOrange(templateType);
      case 3:
        return _minimalistGray(templateType);
      case 4:
        return _forestGreen(templateType);
      case 5:
        return _luxuryGold(templateType);
      case 6:
        return _highContrast(templateType);
      case 7:
        return _softPastel(templateType);
      case 8:
        return _professionalRed(templateType);
      case 9:
        return _nightMode(templateType);
      default:
        return _defaultBlue(templateType);
    }
  }

  // 0. Default Blue
  static NativeTemplateStyle _defaultBlue(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: Colors.white,
      cornerRadius: 10.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.black,
        backgroundColor: Colors.white,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
    );
  }

  // 1. Dark Premium
  static NativeTemplateStyle _darkPremium(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: const Color(0xFF1E1E1E),
      cornerRadius: 12.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.black,
        backgroundColor: const Color(0xFFFFD700), // Gold
        style: NativeTemplateFontStyle.bold,
        size: 15.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        style: NativeTemplateFontStyle.normal,
        size: 16.0,
      ),
      secondaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.grey,
        size: 14.0,
      ),
    );
  }

  // 2. Modern Orange
  static NativeTemplateStyle _modernOrange(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: Colors.white,
      cornerRadius: 0.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.deepOrange,
        style: NativeTemplateFontStyle.bold,
        size: 17.0,
      ),
    );
  }

  // 3. Minimalist Gray
  static NativeTemplateStyle _minimalistGray(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: const Color(0xFFF5F5F5),
      cornerRadius: 8.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.black54,
        size: 14.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.black87,
        size: 16.0,
      ),
    );
  }

  // 4. Forest Green
  static NativeTemplateStyle _forestGreen(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: const Color(0xFFE8F5E9),
      cornerRadius: 15.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.green[800],
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.green[900],
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
    );
  }

  // 5. Luxury Gold
  static NativeTemplateStyle _luxuryGold(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: const Color(0xFFFFF8E1),
      cornerRadius: 4.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: const Color(0xFF8C7B32),
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: const Color(0xFF5D4037),
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
    );
  }

  // 6. High Contrast
  static NativeTemplateStyle _highContrast(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: Colors.black,
      cornerRadius: 0.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.black,
        backgroundColor: Colors.white,
        style: NativeTemplateFontStyle.bold,
        size: 18.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
    );
  }

  // 7. Soft Pastel
  static NativeTemplateStyle _softPastel(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: const Color(0xFFF3E5F5),
      cornerRadius: 20.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.purple[300],
        size: 14.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.purple[900],
        size: 16.0,
      ),
    );
  }

  // 8. Professional Red
  static NativeTemplateStyle _professionalRed(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: Colors.white,
      cornerRadius: 5.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.red[700],
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.red[900],
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
    );
  }

  // 9. Night Mode
  static NativeTemplateStyle _nightMode(TemplateType type) {
    return NativeTemplateStyle(
      templateType: type,
      mainBackgroundColor: Colors.black,
      cornerRadius: 12.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        size: 16.0,
      ),
      tertiaryTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white70,
        size: 12.0,
      ),
    );
  }
}
