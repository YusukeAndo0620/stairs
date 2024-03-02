import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stairs/feature/status/enum/workload_type.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/feature/status/provider/component/task_workload_provider.dart';
import 'package:stairs/feature/status/view/component/status_header.dart';
import 'package:stairs/feature/status/view/component/workload/task_workload_pie_card.dart';
import 'package:stairs/feature/status/view/component/workload/task_workload_line.dart';
import 'package:stairs/feature/status/view/component/workload/workload_fluctuation_card.dart';
import 'package:stairs/feature/status/view/component/workload/workload_reduction_card.dart';
import 'package:stairs/loom/loom_package.dart';

const _kWorkloadAreaHeight = 280.0;
const _kSelectTypeBarHeight = 30.0;
const _kSelectTypeBarWidth = 20.0;
const _kInformationCardSpace = 16.0;
const _kWorkloadFluctuationHeight = 85.0;

const _kHeaderTitle = "工数短縮率";

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kSelectTypeBarPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'task_workload_area');

/// 工数短縮表示エリア
class TaskWorkloadArea extends ConsumerStatefulWidget {
  const TaskWorkloadArea({
    super.key,
    required this.taskStatusModelList,
  });

  final List<TaskStatusModel> taskStatusModelList;
  @override
  ConsumerState<TaskWorkloadArea> createState() => _TaskWorkloadAreaState();
}

class _TaskWorkloadAreaState extends ConsumerState<TaskWorkloadArea> {
  WorkloadType selectedWorkloadType = WorkloadType.all;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    final taskWorkloadState = ref.watch(
        taskWorkloadProvider(taskStatusModelList: widget.taskStatusModelList));

    // 表示されている工数情報
    final displayedWorkload = selectedWorkloadType == WorkloadType.all
        ? taskWorkloadState.totalWorkload
        : selectedWorkloadType == WorkloadType.monthly
            ? taskWorkloadState.monthlyWorkload
            : selectedWorkloadType == WorkloadType.weekly
                ? taskWorkloadState.weekLyWorkload
                : taskWorkloadState.totalWorkload;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: _kContentPadding,
      child: Column(
        children: [
          StatusHeader(
            title: _kHeaderTitle,
            isShownDate: false,
            trailWidget: _SelectTypeBar(
              selectedType: selectedWorkloadType,
              onTap: (type) {
                setState(() {
                  selectedWorkloadType = type;
                });
              },
            ),
          ),
          SizedBox(
            height: _kWorkloadAreaHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TaskWorkloadPieCard(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: _kWorkloadAreaHeight,
                  padding: _kContentPadding,
                  title: selectedWorkloadType.typeValue,
                  workload: displayedWorkload,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WorkloadFluctuationCard(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: _kWorkloadFluctuationHeight,
                      workload: displayedWorkload.totalWorkloadHour,
                      actualWorkload: displayedWorkload.actualWorkloadHour,
                    ),
                    const SizedBox(
                      height: _kInformationCardSpace,
                    ),
                    WorkloadReductionCard(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: (_kWorkloadAreaHeight -
                          _kWorkloadFluctuationHeight -
                          _kInformationCardSpace),
                      firstDate: displayedWorkload.firstDate,
                      lastDate: displayedWorkload.lastDate,
                      taskStatusModelList: widget.taskStatusModelList,
                    )
                  ],
                )
              ],
            ),
          ),
          TaskWorkloadLine(
            taskStatusModelList: widget.taskStatusModelList,
          ),
        ],
      ),
    );
  }
}

// 表示タイプ選択エリア
class _SelectTypeBar extends StatelessWidget {
  const _SelectTypeBar({
    required this.selectedType,
    required this.onTap,
  });

  final WorkloadType selectedType;
  final Function(WorkloadType) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return ToggleButtons(
      constraints: const BoxConstraints(
          maxHeight: _kSelectTypeBarHeight, minWidth: _kSelectTypeBarWidth),
      borderRadius: BorderRadius.circular(5.0),
      fillColor: theme.colorPrimary,
      isSelected:
          WorkloadType.values.map((type) => type == selectedType).toList(),
      onPressed: (index) => onTap(WorkloadType.values[index]),
      children: [
        for (final item in WorkloadType.values) ...[
          Padding(
            padding: _kSelectTypeBarPadding,
            child: Text(
              item.typeValue,
              style: theme.textStyleFootnote.copyWith(
                color: item == selectedType
                    ? theme.colorBgLayer1
                    : theme.colorFgDefault,
              ),
            ),
          )
        ]
      ],
    );
  }
}
