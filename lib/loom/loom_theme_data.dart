import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'loom_icons.dart';

@immutable
class LoomThemeData with Diagnosticable {
  const LoomThemeData({
    required this.icons,
    required this.colorBgLayer1,
    required this.colorPrimary,
    required this.colorSecondary,
    required this.colorDisabled,
    required this.colorDangerBgDefault,
    required this.colorFgDefault,
    required this.colorFgDefaultWhite,
    required this.colorFgDisabled,
    required this.colorFgStrong,
    required this.colorFgSubtitle,
    required this.textStyleBody,
    required this.textStyleFootnote,
    required this.textStyleTitle,
    required this.textStyleSubtitle,
    required this.textStyleHeading,
    required this.textStyleSubHeading,
  });

  final LoomIcons icons;

  final Color colorBgLayer1;
  final Color colorPrimary;
  final Color colorSecondary;
  final Color colorDisabled;
  final Color colorDangerBgDefault;

  final Color colorFgDefault;
  final Color colorFgDefaultWhite;
  final Color colorFgDisabled;
  final Color colorFgStrong;
  final Color colorFgSubtitle;
  final TextStyle textStyleBody;
  final TextStyle textStyleFootnote;
  final TextStyle textStyleTitle;
  final TextStyle textStyleSubtitle;
  final TextStyle textStyleHeading;
  final TextStyle textStyleSubHeading;

  static LoomThemeData lerp(LoomThemeData a, LoomThemeData b, double t) {
    if (t == 0) {
      return a;
    }
    if (t == 1) {
      return b;
    }
    return LoomThemeData(
      icons: t < 0.5 ? a.icons : b.icons,
      colorBgLayer1: Color.lerp(
        a.colorBgLayer1,
        b.colorBgLayer1,
        t,
      )!,
      colorPrimary: Color.lerp(
        a.colorPrimary,
        b.colorPrimary,
        t,
      )!,
      colorSecondary: Color.lerp(
        a.colorSecondary,
        b.colorSecondary,
        t,
      )!,
      colorDisabled: Color.lerp(
        a.colorDisabled,
        b.colorDisabled,
        t,
      )!,
      colorDangerBgDefault: Color.lerp(
        a.colorDangerBgDefault,
        b.colorDangerBgDefault,
        t,
      )!,
      colorFgDefault: Color.lerp(
        a.colorFgDefault,
        b.colorFgDefault,
        t,
      )!,
      colorFgDefaultWhite: Color.lerp(
        a.colorFgDefault,
        b.colorFgDefault,
        t,
      )!,
      colorFgDisabled: Color.lerp(
        a.colorFgDisabled,
        b.colorFgDisabled,
        t,
      )!,
      colorFgStrong: Color.lerp(a.colorFgStrong, b.colorFgStrong, t)!,
      colorFgSubtitle: Color.lerp(a.colorFgSubtitle, b.colorFgSubtitle, t)!,
      textStyleBody: b.textStyleBody,
      textStyleFootnote: b.textStyleFootnote,
      textStyleTitle: b.textStyleTitle,
      textStyleSubtitle: b.textStyleSubtitle,
      textStyleHeading: b.textStyleHeading,
      textStyleSubHeading: b.textStyleSubHeading,
    );
  }
}

class LoomThemeDataTween extends Tween<LoomThemeData> {
  LoomThemeDataTween({LoomThemeData? begin, LoomThemeData? end})
      : super(begin: begin, end: end);

  @override
  LoomThemeData lerp(double t) {
    return LoomThemeData.lerp(begin!, end!, t);
  }
}
