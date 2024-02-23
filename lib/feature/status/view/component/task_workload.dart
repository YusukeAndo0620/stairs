import 'package:stairs/feature/status/enum/workload_type.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/feature/status/view/component/status_header.dart';
import 'package:stairs/feature/status/view/component/task_workload_card.dart';
import 'package:stairs/feature/status/view/component/task_workload_line.dart';
import 'package:stairs/loom/loom_package.dart';

const _kSelectTypeBarHeight = 30.0;
const _kSelectTypeBarWidth = 20.0;

const _kHeaderTitle = "工数短縮率";

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kSelectTypeBarPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'task_workload');

/// 工数短縮表示エリア
class TaskWorkload extends StatefulWidget {
  const TaskWorkload({
    super.key,
    required this.taskStatusModelList,
  });

  final List<TaskStatusModel> taskStatusModelList;
  @override
  State<StatefulWidget> createState() => _TaskWorkloadState();
}

class _TaskWorkloadState extends State<TaskWorkload> {
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
    final theme = LoomTheme.of(context);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TaskWorkloadCard(
                  selectedWorkloadType: selectedWorkloadType,
                  taskStatusModelList: widget.taskStatusModelList),
              // ダミーデータ
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 70,
                    decoration: BoxDecoration(
                      color: theme.colorFgDefaultWhite,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: theme.colorFgDisabled,
                        width: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 70,
                    decoration: BoxDecoration(
                      color: theme.colorFgDefaultWhite,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: theme.colorFgDisabled,
                        width: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 70,
                    decoration: BoxDecoration(
                      color: theme.colorFgDefaultWhite,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: theme.colorFgDisabled,
                        width: 1,
                      ),
                    ),
                  )
                ],
              )
            ],
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
