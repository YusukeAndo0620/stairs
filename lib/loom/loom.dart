import 'package:stairs/loom/loom_theme_data.dart';
import 'day_color.dart';
import 'icons.dart';
import 'text_style.dart';

class Loom {
  const Loom._();

// ダークモードの対応をするなら修正
  static final themeDataFor = LoomThemeData(
    icons: loomIcons,
    colorBgLayer1: colorBgLayer1,
    colorPrimary: colorPrimary,
    colorSecondary: colorSecondary,
    colorDisabled: colorDisabled,
    colorDangerBgDefault: colorDangerBgDefault,
    colorWarning: colorWarning,
    colorProgress: colorProgress,
    colorFgDefault: colorFgDefault,
    colorFgDefaultWhite: colorFgDefaultWhite,
    colorFgDisabled: colorFgDisabled,
    colorFgStrong: colorFgStrong,
    colorFgSubtitle: colorFgSubtitle,
    textStyleBody: textStyleBody(colorFgDefault),
    textStyleFootnote: textStyleFootnote(colorFgDisabled),
    textStyleTitle: textStyleTitle(colorPrimary),
    textStyleSubtitle: textStyleSubtitle(colorPrimary),
    textStyleHeading: textStyleHeading(colorPrimary),
    textStyleSubHeading: textStyleSubHeading(colorPrimary),
  );
}
