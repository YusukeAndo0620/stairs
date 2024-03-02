import 'package:stairs/loom/loom_package.dart';

const _kWorkloadFluctuationAnimation = 500;
const _kWorkloadFluctuationPercentHeight = 20.0;
const _kWorkloadFluctuationIconSize = 18.0;
const _kWorkloadChartIconSize = 14.0;
const _kWorkloadFluctuationSpace = 8.0;

const _kWorkloadFluctuationPositiveTxt = "工数削減時間";
const _kWorkloadFluctuationNegativeTxt = "工数超過時間";
const _kTotalWorkloadTxt = "全工数";
const _kActualWorkloadTxt = "実工数";
const _kWorkloadFluctuationTitlePadding = EdgeInsets.zero;
const _kWorkloadLabelPadding = EdgeInsets.symmetric(vertical: 4.0);

// 工数変動カード
class WorkloadFluctuationCard extends StatelessWidget {
  const WorkloadFluctuationCard({
    super.key,
    required this.width,
    required this.height,
    this.padding,
    required this.workload,
    required this.actualWorkload,
  });
  final double width;
  final double height;
  final EdgeInsets? padding;
  final double workload;
  final double actualWorkload;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    // 工数削減時間
    final workLoadDiff = workload - actualWorkload;
    // 工数タイトル
    final title = 0 <= workLoadDiff
        ? _kWorkloadFluctuationPositiveTxt
        : _kWorkloadFluctuationNegativeTxt;
    // 工数補足のラベル文言
    final workloadLabel =
        0 <= workLoadDiff ? _kActualWorkloadTxt : _kTotalWorkloadTxt;
    // 色
    final color =
        workLoadDiff >= 0 ? theme.colorPrimary : theme.colorDangerBgDefault;
    return CardBox(
      width: width,
      height: height,
      padding: padding,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // タイトル
            TextIcon(
              title: title,
              padding: _kWorkloadFluctuationTitlePadding,
              icon: Icon(
                Icons.info,
                size: _kWorkloadFluctuationIconSize,
                color: theme.colorPrimary,
              ),
            ),
            const SizedBox(
              height: _kWorkloadFluctuationSpace,
            ),
            // 工数削減、超過時間 インジケーター
            LinearPercentIndicator(
              animation: true,
              animationDuration: _kWorkloadFluctuationAnimation,
              lineHeight: _kWorkloadFluctuationPercentHeight,
              percent: workLoadDiff == 0
                  ? 0
                  : workLoadDiff < 0
                      ? workLoadDiff.abs() / actualWorkload
                      : workLoadDiff.abs() / workload,
              center: Text(
                '${workLoadDiff.abs().toString()}H',
                style: theme.textStyleBody,
              ),
              backgroundColor: theme.colorFgDisabled.withOpacity(0.5),
              progressColor: color,
            ),
            // インジケーター補足ラベルエリア
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextIcon(
                  title: title,
                  padding: _kWorkloadLabelPadding,
                  icon: Icon(
                    Icons.bar_chart,
                    color: color,
                    size: _kWorkloadChartIconSize,
                  ),
                  style: theme.textStyleFootnote
                      .copyWith(color: theme.colorDisabled),
                ),
                const SizedBox(
                  width: _kWorkloadFluctuationSpace,
                ),
                TextIcon(
                  title: workloadLabel,
                  padding: _kWorkloadLabelPadding,
                  icon: Icon(
                    Icons.bar_chart,
                    color: theme.colorFgDisabled,
                    size: _kWorkloadChartIconSize,
                  ),
                  style: theme.textStyleFootnote
                      .copyWith(color: theme.colorDisabled),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
