import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kIconAndTextSpace = 16.0;
const _kMinWidth = 100.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);

/// テキストボタン
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.icon,
    this.height,
    required this.themeColor,
    this.disabled = false,
    required this.onTap,
  });
  final String title;
  final double? height;
  final Icon? icon;
  final Color themeColor;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: TapAction(
        key: key,
        minWidth: _kMinWidth,
        height: height,
        padding: _kContentPadding,
        border: Border.all(
          color: themeColor,
          width: _kBorderWidth,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(5.0),
        tappedColor: themeColor,
        onTap: onTap,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(
                width: _kIconAndTextSpace,
              ),
            ],
            Text(
              title,
              style: theme.textStyleBody,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
