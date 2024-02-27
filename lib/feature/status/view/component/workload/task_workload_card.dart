import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;

/// 工数カード
abstract class TaskWorkloadCard extends StatelessWidget {
  const TaskWorkloadCard({
    super.key,
    required this.height,
    this.width,
    this.padding,
  });

  final double height;
  final double? width;
  final EdgeInsets? padding;
  Widget buildMainContents(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.45,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
      ),
      child: buildMainContents(context),
    );
  }
}
