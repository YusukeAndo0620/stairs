import 'package:stairs/loom/loom_package.dart';

const _kPercentIndicatorHeight = 20.0;
const _kPercentIndicatorAnimation = 1000;

// 個数 / 総数と割合インジケーターを表示
class CountIndicator extends StatelessWidget {
  const CountIndicator({
    super.key,
    required this.countWidth,
    required this.percentIndicatorWidth,
    this.lineHeight,
    required this.count,
    required this.totalCount,
  });

  final double countWidth;
  final double percentIndicatorWidth;
  final double? lineHeight;
  final int count;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: countWidth,
          child: Text(
            '$count / $totalCount',
            style: theme.textStyleBody,
            textAlign: TextAlign.center,
          ),
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 0.28,
          animation: true,
          lineHeight: lineHeight ?? _kPercentIndicatorHeight,
          animationDuration: _kPercentIndicatorAnimation,
          percent: count / totalCount,
          center: Text(
            getFormattedPercent(
              percent: (count / totalCount * 100).toInt(),
            ),
            style: theme.textStyleBody,
          ),
          barRadius: const Radius.circular(10),
          backgroundColor: theme.colorFgDisabled,
          progressColor: theme.colorPrimary,
        ),
      ],
    );
  }
}
