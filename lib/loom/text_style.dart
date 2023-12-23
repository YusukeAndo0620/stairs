import 'package:flutter/material.dart';

TextStyle textStyleBody(Color color) {
  return TextStyle(
    fontFamily: '',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.33,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    decoration: TextDecoration.none,
  );
}

TextStyle textStyleFootnote(Color color) {
  return TextStyle(
    fontFamily: '',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.66,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    decoration: TextDecoration.none,
  );
}

TextStyle textStyleTitle(Color color) {
  return TextStyle(
    fontFamily: '',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.33,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    decoration: TextDecoration.none,
  );
}

TextStyle textStyleSubtitle(Color color) {
  return TextStyle(
    fontFamily: '',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.33,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    decoration: TextDecoration.none,
  );
}

TextStyle textStyleHeading(Color color) {
  return TextStyle(
    fontFamily: '',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.33,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    decoration: TextDecoration.none,
  );
}

TextStyle textStyleSubHeading(Color color) {
  return TextStyle(
    fontFamily: '',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.33,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
    decoration: TextDecoration.none,
  );
}

extension TextStyleExtension on TextStyle {
  TextStyle copyWith({
    required Color? newColor,
    required double? newFontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: newFontSize ?? fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: height,
      leadingDistribution: leadingDistribution,
      color: newColor ?? color,
      decoration: TextDecoration.none,
    );
  }
}
