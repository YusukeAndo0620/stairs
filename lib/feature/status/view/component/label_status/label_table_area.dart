import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/view/component/label_status/label_table.dart';

import 'package:stairs/loom/loom_package.dart';

const _kCircularPercentRadius = 10.0;
const _kHeaderAndTableSpace = 8.0;
const _kSpaceInHeader = 8.0;

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);

/// ラベル一覧領域（ヘッダー+ラベル一覧表）
class LabelTableArea extends StatelessWidget {
  const LabelTableArea({
    super.key,
    required this.title,
    required this.totalLabelTaskCount,
    this.totalTaskCount,
    this.taskCount,
    required this.labelStatusList,
  });

  final String title;

  /// ラベルが紐づいているタスクの総数
  final int totalLabelTaskCount;

  /// タスクの総数
  final int? totalTaskCount;

  /// タスク数
  final int? taskCount;
  final List<LabelStatusModel> labelStatusList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _kContentPadding,
      child: Column(
        children: [
          _Header(
            title: title,
            totalTaskCount: totalTaskCount,
            taskCount: taskCount,
          ),
          const SizedBox(height: _kHeaderAndTableSpace),
          LabelTable(
            totalLabelTaskCount: totalLabelTaskCount,
            labelStatusList: labelStatusList,
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    this.totalTaskCount,
    this.taskCount,
  });

  final String title;
  final int? totalTaskCount;
  final int? taskCount;
  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final percent = totalTaskCount == null || taskCount == null
        ? null
        : taskCount == 0
            ? 0.0
            : double.parse((taskCount! / totalTaskCount!).toStringAsFixed(2));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textStyleBody,
        ),
        const SizedBox(width: _kSpaceInHeader),
        if (percent != null) ...[
          Row(
            children: [
              _CircularPercent(
                percent: percent,
              ),
              const SizedBox(width: _kSpaceInHeader),
              Text(
                '${percent * 100}%'.toString(),
                style: theme.textStyleBody,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// 使用率の円グラフ
class _CircularPercent extends StatelessWidget {
  const _CircularPercent({
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return CircularPercentIndicator(
      radius: _kCircularPercentRadius,
      lineWidth: 5.0,
      animation: true,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.butt,
      progressColor: theme.colorPrimary,
      backgroundColor: theme.colorFgDisabled.withOpacity(0.5),
    );
  }
}
