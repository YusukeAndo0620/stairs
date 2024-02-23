import 'package:stairs/feature/status/enum/workload_type.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/feature/status/provider/component/task_workload_card_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kBorderWidth = 1.0;
const _kWorkLoadHourSpace = 4.0;
const _kCircularPercentRadius = 60.0;

const _kBlankTxt = "-";
const _kWorkloadStartDateTxt = "開始日:";
const _kWorkloadEndDateTxt = "終了日:";
const _kTotalWorkloadTxt = "全工数: ";
const _kActualWorkloadTxt = "実工数: ";

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kCircularPercentHeaderPadding =
    EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0);
const _kCircularPercentFooterPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0);

final _logger = stairsLogger(name: 'task_workload_card');

class TaskWorkloadCard extends ConsumerWidget {
  const TaskWorkloadCard({
    super.key,
    required this.taskStatusModelList,
    required this.selectedWorkloadType,
  });

  final List<TaskStatusModel> taskStatusModelList;
  final WorkloadType selectedWorkloadType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final theme = LoomTheme.of(context);

    final taskWorkloadCardState = ref.watch(
        taskWorkloadCardProvider(taskStatusModelList: taskStatusModelList));

    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: _kContentPadding,
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _WorkLoadCircularPercent(
            centerTitle: selectedWorkloadType.typeValue,
            workload: selectedWorkloadType == WorkloadType.all
                ? taskWorkloadCardState.totalWorkload
                : selectedWorkloadType == WorkloadType.monthly
                    ? taskWorkloadCardState.monthlyWorkload
                    : selectedWorkloadType == WorkloadType.weekly
                        ? taskWorkloadCardState.weekLyWorkload
                        : taskWorkloadCardState.totalWorkload,
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
            Text(
              '$_kTotalWorkloadTxt${workload.totalWorkloadHour}H',
              style: theme.textStyleBody,
            ),
            const SizedBox(
              height: _kWorkLoadHourSpace,
            ),
            Text(
              '$_kActualWorkloadTxt${workload.actualWorkloadHour}H',
              style: theme.textStyleBody,
            ),
            const SizedBox(
              height: _kWorkLoadHourSpace,
            ),
            Text(
              workload.firstDate == null
                  ? _kWorkloadStartDateTxt + _kBlankTxt
                  : _kWorkloadStartDateTxt +
                      getFormattedDateTime(workload.firstDate!),
              style:
                  theme.textStyleFootnote.copyWith(color: theme.colorDisabled),
            ),
            Text(
              workload.lastDate == null
                  ? _kWorkloadEndDateTxt + _kBlankTxt
                  : _kWorkloadEndDateTxt +
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
