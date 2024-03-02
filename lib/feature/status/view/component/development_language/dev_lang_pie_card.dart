import 'package:stairs/loom/loom_package.dart';

const _kWorkLoadHourSpace = 4.0;
const _kCircularPercentRadius = 60.0;

const _kTotalTaskCountTxt = "全タスク数";
const _kTaskCountTxt = "開発言語タスク数";

const _kCircularPercentHeaderPadding =
    EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0);
const _kCircularPercentFooterPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0);

final _logger = stairsLogger(name: 'task_workload_card');

/// 開発言語円グラフ表示カード
class DevLangPieCard extends StatelessWidget {
  const DevLangPieCard({
    super.key,
    required this.width,
    required this.height,
    this.padding,
    required this.title,
    required this.totalTaskCount,
    required this.taskCount,
  });
  final double width;
  final double height;
  final EdgeInsets? padding;
  final String title;
  final int totalTaskCount;
  final int taskCount;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    return CardBox(
      width: width,
      height: height,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _DevLangCircularPercent(
            centerTitle: title,
            totalTaskCount: totalTaskCount,
            taskCount: taskCount,
          ),
        ],
      ),
    );
  }
}

// 開発言語使用率の円グラフ
class _DevLangCircularPercent extends StatelessWidget {
  const _DevLangCircularPercent({
    required this.centerTitle,
    required this.totalTaskCount,
    required this.taskCount,
  });

  final String centerTitle;
  final int totalTaskCount;
  final int taskCount;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final percent = taskCount == 0
        ? 0.0
        : double.parse((taskCount / totalTaskCount * 100).toStringAsFixed(2));

    return CircularPercentIndicator(
      radius: _kCircularPercentRadius,
      lineWidth: 13.0,
      animation: true,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.butt,
      progressColor: theme.colorPrimary,
      backgroundColor: theme.colorDangerBgDefault.withOpacity(0.5),
      header: Padding(
        padding: _kCircularPercentHeaderPadding,
        child: Text(
          centerTitle,
          style: theme.textStyleBody,
        ),
      ),
      center: Text(
        '$percent%',
        style: theme.textStyleSubHeading.copyWith(color: theme.colorPrimary),
      ),
      footer: Padding(
        padding: _kCircularPercentFooterPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 工数
            Text(
              '${getAddingColonTxt(_kTotalTaskCountTxt)}$totalTaskCount件',
              style: theme.textStyleBody,
            ),
            const SizedBox(
              height: _kWorkLoadHourSpace,
            ),
            // 実工数
            Text(
              '${getAddingColonTxt(_kTaskCountTxt)}$taskCount',
              style: theme.textStyleBody,
            ),
          ],
        ),
      ),
    );
  }
}
