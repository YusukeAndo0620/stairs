import 'package:flutter/material.dart' hide Theme;
import '/loom/theme.dart';

const _kBorder = 1.0;
const _kIconAndContentsSpace = 4.0;
const _kIconSize = 16.0;

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);

enum LabelTipType {
  circle,
  square,
}

class LabelTip extends StatelessWidget {
  const LabelTip({
    super.key,
    this.width,
    this.type = LabelTipType.circle,
    required this.label,
    this.textColor,
    required this.themeColor,
    this.iconData,
  });

  final double? width;
  final LabelTipType type;
  final String label;
  final Color? textColor;
  final Color themeColor;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      width: width,
      padding: _kContentPadding,
      decoration: BoxDecoration(
        color: themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.all(
            Radius.circular(type == LabelTipType.circle ? 20.0 : 5.0)),
        border: Border.all(
          color: themeColor,
          width: _kBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            width != null ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (iconData != null) ...[
            Icon(
              iconData,
              size: _kIconSize,
              color: textColor,
            ),
            const SizedBox(
              width: _kIconAndContentsSpace,
            ),
          ],
          SizedBox(
            width: width != null
                ? (width! - _kContentPadding.horizontal * 1.5) * 0.7
                : null,
            child: Text(
              label,
              style: theme.textStyleFootnote
                  .copyWith(color: textColor ?? theme.colorFgDefault),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
