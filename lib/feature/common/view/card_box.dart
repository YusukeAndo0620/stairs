import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;

/// カード
class CardBox extends StatelessWidget {
  const CardBox({
    super.key,
    required this.width,
    this.height,
    this.color,
    this.borderColor,
    required this.child,
    this.padding,
    this.margin,
  });

  final double width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? theme.colorFgDefaultWhite,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: borderColor ?? theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
      ),
      child: child,
    );
  }
}
