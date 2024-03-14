import 'package:stairs/feature/status/provider/status_provider.dart';
import 'package:stairs/feature/status/view/component/label_status/label_status_area.dart';
import 'package:stairs/feature/status/view/component/task_card.dart';
import 'package:stairs/feature/status/view/component/task_status_chart.dart';
import 'package:stairs/feature/status/view/component/workload/task_workload_area.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kAppBarHeight = 30.0;
const _kTabWidth = 120.0;
const _kTotalTitle = "全タスク";
const _kOverDueDateTitle = "期限切れ";
const _kProgressTitle = "進行中";
const _kCompletedTitle = "完了";

final _logger = stairsLogger(name: 'status_screen');

/// ステータス
class StatusScreen extends ConsumerStatefulWidget {
  const StatusScreen({
    super.key,
    required this.onTapFooterIcon,
  });
  final Function(int) onTapFooterIcon;

  @override
  ConsumerState<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends ConsumerState<StatusScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    final theme = LoomTheme.of(context);
    // ステータス
    final statusState = ref.watch(statusProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {},
    );
    return statusState.when(
      data: (list) {
        setState(() {
          _tabController = TabController(vsync: this, length: list.length);
        });
        return ScreenWidget(
          screenId: ScreenId.status,
          appBar: AppBar(
            toolbarHeight: _kAppBarHeight,
            bottom: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              controller: _tabController,
              labelStyle:
                  theme.textStyleFootnote.copyWith(color: theme.colorFgDefault),
              indicatorColor: theme.colorPrimary,
              unselectedLabelColor: theme.colorFgDefault.withOpacity(0.3),
              tabs: <Widget>[
                for (final item in list) ...[
                  SizedBox(
                    width: _kTabWidth,
                    child: Tab(
                      icon: Icon(
                        theme.icons.project,
                        color: item.themeColorModel.color,
                      ),
                      text: item.projectName,
                    ),
                  ),
                ],
              ],
            ),
          ),
          buildMainContents: TabBarView(
            controller: _tabController,
            children: <Widget>[
              for (final item in list) ...[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // タスクカード
                      Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          TaskCard(
                            title: _kProgressTitle,
                            headerType: HeaderType.inProgress,
                            count: item.taskStatusList.length -
                                item.overDueDateTaskCount -
                                item.completedTaskCount,
                            lastMonthTaskCount: item.lastMonthProgressTaskCount,
                          ),
                          TaskCard(
                            title: _kCompletedTitle,
                            headerType: HeaderType.completed,
                            count: item.completedTaskCount,
                            lastMonthTaskCount:
                                item.lastMonthCompletedTaskCount,
                          ),
                          TaskCard(
                            title: _kOverDueDateTitle,
                            headerType: HeaderType.overDueDate,
                            count: item.overDueDateTaskCount,
                            lastMonthTaskCount:
                                item.lastMonthOverDueDateTaskCount,
                          ),
                          TaskCard(
                            title: _kTotalTitle,
                            headerType: HeaderType.total,
                            count: item.taskStatusList.length,
                            lastMonthTaskCount: item.lastMonthTotalTaskCount,
                          ),
                        ],
                      ),
                      // タスク数推移
                      TaskStatusChart(
                        isHorizontal: true,
                        taskStatusModelList: item.taskStatusList,
                      ),
                      // ラベル内訳テーブル
                      LabelStatusArea(projectStatusModel: item),
                      // 工数短縮率
                      TaskWorkloadArea(
                          taskStatusModelList: item.taskStatusList),
                    ],
                  ),
                ),
              ],
            ],
          ),
          onTapFooterIcon: (index) => widget.onTapFooterIcon(index),
        );
      },
      loading: () => ScreenWidget(
        screenId: ScreenId.status,
        appBar: AppBar(),
        buildMainContents: Align(
          child: CircularProgressIndicator(
            color: theme.colorPrimary,
          ),
        ),
        onTapFooterIcon: (index) => widget.onTapFooterIcon(index),
      ),
      error: (error, _) => ScreenWidget(
        screenId: ScreenId.status,
        appBar: AppBar(),
        buildMainContents: Scaffold(body: Align(child: Text(error.toString()))),
        onTapFooterIcon: (index) => widget.onTapFooterIcon(index),
      ),
    );
  }
}
