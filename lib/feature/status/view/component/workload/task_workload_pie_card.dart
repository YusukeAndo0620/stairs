import 'package:stairs/feature/status/provider/component/task_workload_provider.dart';
import 'package:stairs/loom/loom_package.dart';

const _kWorkLoadHourSpace = 4.0;
const _kCircularPercentRadius = 60.0;

const _kBlankTxt = "-";
const _kWorkloadStartDateTxt = "開始日";
const _kWorkloadEndDateTxt = "終了日";
const _kTotalWorkloadTxt = "全工数";
const _kActualWorkloadTxt = "実工数";

const _kCircularPercentHeaderPadding =
    EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0);
const _kCircularPercentFooterPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0);

/// 工数短縮円グラフ表示カード
class TaskWorkloadPieCard extends StatelessWidget {
  const TaskWorkloadPieCard({
    super.key,
    required this.width,
    required this.height,
    required this.padding,
    required this.title,
    required this.workload,
  });

  final double width;
  final double height;
  final EdgeInsets padding;
  final String title;
  final Workload workload;

  @override
  Widget build(BuildContext context) {
    return CardBox(
      width: width,
      height: height,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _WorkLoadCircularPercent(
            centerTitle: title,
            workload: workload,
          ),
        ],
      ),
    );
  }
}

// 工数平均の円グラフ
class _WorkLoadCircularPercent extends StatelessWidget {
  const _WorkLoadCircularPercent({
    required this.centerTitle,
    required this.workload,
  });

  final String centerTitle;
  final Workload workload;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    // 短縮率が正の値かどうか
    final isWorkloadPercentPositive = 0 <= workload.workloadPercent;

    // メインカラーを設定
    final color = isWorkloadPercentPositive
        ? theme.colorPrimary
        : theme.colorDangerBgDefault;

    // 短縮率が100, -100をこえる場合、0~100の値になるように修正
    double percent = workload.workloadPercent;
    bool isOverHundred = false;

    if (100 < percent || percent < -100) {
      isOverHundred = true;
      while (percent < -100 || 100 < percent) {
        percent = percent % 100;
      }
    }
    percent = double.parse(percent.toStringAsFixed(2));

    return CircularPercentIndicator(
      radius: _kCircularPercentRadius,
      lineWidth: 13.0,
      animation: true,
      percent: (percent / 100).abs(),
      reverse: !isWorkloadPercentPositive,
      circularStrokeCap: CircularStrokeCap.butt,
      progressColor: color,
      backgroundColor: isWorkloadPercentPositive && isOverHundred
          ? theme.colorPrimary.withOpacity(0.5)
          : !isWorkloadPercentPositive && isOverHundred
              ? theme.colorDangerBgDefault.withOpacity(0.5)
              : theme.colorFgDisabled,
      header: Padding(
        padding: _kCircularPercentHeaderPadding,
        child: Text(
          centerTitle,
          style: theme.textStyleBody,
        ),
      ),
      center: Text(
        '${workload.workloadPercent}%',
        style: theme.textStyleSubHeading.copyWith(color: color),
      ),
      footer: Padding(
        padding: _kCircularPercentFooterPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 工数
            Text(
              '${getAddingColonTxt(_kTotalWorkloadTxt)}${workload.totalWorkloadHour}H',
              style: theme.textStyleBody,
            ),
            const SizedBox(
              height: _kWorkLoadHourSpace,
            ),
            // 実工数
            Text(
              '${getAddingColonTxt(_kActualWorkloadTxt)}${workload.actualWorkloadHour}H',
              style: theme.textStyleBody,
            ),
            const SizedBox(
              height: _kWorkLoadHourSpace,
            ),
            // 開始日
            Text(
              workload.firstDate == null
                  ? getAddingColonTxt(_kWorkloadStartDateTxt) + _kBlankTxt
                  : getAddingColonTxt(_kWorkloadStartDateTxt) +
                      getFormattedDateTime(workload.firstDate!),
              style:
                  theme.textStyleFootnote.copyWith(color: theme.colorDisabled),
            ),
            // 終了日
            Text(
              workload.lastDate == null
                  ? getAddingColonTxt(_kWorkloadEndDateTxt) + _kBlankTxt
                  : getAddingColonTxt(_kWorkloadEndDateTxt) +
                      getFormattedDateTime(workload.lastDate!),
              style:
                  theme.textStyleFootnote.copyWith(color: theme.colorDisabled),
            ),
          ],
        ),
      ),
    );
  }
}
