import 'package:stairs/loom/loom_package.dart';

const _kTitleAndIconSpace = 4.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);

/// アイコンとテキストを表示
class TextIcon extends StatelessWidget {
  const TextIcon({
    super.key,
    required this.title,
    required this.icon,
    this.style,
    this.padding,
    this.isIconLeading = true,
  });
  final String title;
  final Icon icon;
  final TextStyle? style;
  final EdgeInsets? padding;

  /// アイコンを先に表示するか
  final bool isIconLeading;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      padding: padding ?? _kContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isIconLeading
              ? icon
              : Text(
                  title,
                  style: style ?? theme.textStyleBody,
                ),
          const SizedBox(
            width: _kTitleAndIconSpace,
          ),
          isIconLeading
              ? Text(
                  title,
                  style: style ?? theme.textStyleBody,
                )
              : icon,
        ],
      ),
    );
  }
}
