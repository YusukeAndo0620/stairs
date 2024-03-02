import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/view/component/status_label_table.dart';

import 'package:stairs/loom/loom_package.dart';

const _kCircularPercentRadius = 10.0;
const _kHeaderAndTableSpace = 8.0;
const _kSpaceInHeader = 8.0;

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);

/// 開発言語テーブル
class DevLangTable extends ConsumerWidget {
  const DevLangTable({
    super.key,
    required this.devLangName,
    required this.totalTaskCount,
    required this.taskCount,
    required this.labelStatusList,
  });

  final String devLangName;
  final int totalTaskCount;
  final int taskCount;
  final List<LabelStatusModel> labelStatusList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: _kContentPadding,
      child: Column(
        children: [
          _Header(
            title: devLangName,
            totalTaskCount: totalTaskCount,
            taskCount: taskCount,
          ),
          const SizedBox(height: _kHeaderAndTableSpace),
          StatusLabelTable(
            totalLabelTaskCount:
                labelStatusList.map((item) => item.taskIdList).toList().length,
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
    required this.totalTaskCount,
    required this.taskCount,
  });

  final String title;
  final int totalTaskCount;
  final int taskCount;
  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final percent = taskCount == 0
        ? 0.0
        : double.parse((taskCount / totalTaskCount).toStringAsFixed(2));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textStyleBody,
        ),
        const SizedBox(width: _kSpaceInHeader),
        Row(
          children: [
            _DevLangCircularPercent(
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
    );
  }
}

// 開発言語使用率の円グラフ
class _DevLangCircularPercent extends StatelessWidget {
  const _DevLangCircularPercent({
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
