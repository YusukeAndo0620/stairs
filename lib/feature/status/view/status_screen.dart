import 'package:stairs/feature/status/provider/status_provider.dart';
import 'package:stairs/feature/status/view/component/status_bar_chart.dart';
import 'package:stairs/feature/status/view/component/status_label_table.dart';
import 'package:stairs/feature/status/view/component/status_pie_chart.dart';
import 'package:stairs/feature/status/view/component/task_card.dart';
import 'package:stairs/feature/status/view/component/task_status_chart.dart';
import 'package:stairs/feature/status/view/component/task_workload.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kAppBarHeight = 10.0;
const _kTotalTitle = "全タスク";
const _kProgressTitle = "進行中";
const _kCompletedTitle = "完了";
const _kBarAchievementTitle = "実績";
const _kTaskCountTxt = "タスク数";

final _logger = stairsLogger(name: 'status_screen');

///ステータス
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
  void dispose() {
    super.dispose();
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
                  Tab(
                    icon: Icon(
                      theme.icons.project,
                      color: item.themeColorModel.color,
                    ),
                    text: item.projectName,
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
                      Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          TaskCard(
                            title: _kTotalTitle,
                            headerType: HeaderType.total,
                            count: item.taskStatusList.length,
                            changedPercent: item.totalTaskPercent,
                          ),
                          TaskCard(
                            title: _kProgressTitle,
                            headerType: HeaderType.inProgress,
                            count: item.taskStatusList.length -
                                item.completedTaskCount,
                            changedPercent: 20.0,
                          ),
                          TaskCard(
                            title: _kCompletedTitle,
                            headerType: HeaderType.completed,
                            count: item.completedTaskCount,
                            changedPercent: item.completedTaskPercent,
                          ),
                        ],
                      ),
                      TaskStatusChart(
                        isHorizontal: true,
                        taskStatusModelList: item.taskStatusList,
                      ),
                      StatusLabelTable(
                        totalLabelTaskCount: item.totalLabelTaskCount,
                        labelStatusList: item.labelStatusList,
                      ),
                      TaskWorkload(taskStatusModelList: item.taskStatusList),
                      // 一旦使用しない
                      // StatusBarChart(
                      //   title: _kBarAchievementTitle,
                      //   legendName: _kTaskCountTxt,
                      //   isHorizontal: true,
                      //   chartData: item.labelStatusList
                      //       .map(
                      //         (e) => BarChartData(
                      //           x: e.labelName,
                      //           y: e.taskIdList.length.toDouble(),
                      //         ),
                      //       )
                      //       .toList(),
                      // ),
                      // StatusPieChart(
                      //   legendName: _kTaskCountTxt,
                      //   chartData: item.labelStatusList
                      //       .map(
                      //         (e) => e.taskIdList.isNotEmpty
                      //             ? PieChartData(
                      //                 x: e.labelName,
                      //                 y: e.taskIdList.length.toDouble(),
                      //                 text: getFormattedPercent(
                      //                   percent: (e.taskIdList.length /
                      //                           item.totalLabelTaskCount *
                      //                           100)
                      //                       .toInt(),
                      //                 ),
                      //               )
                      //             : null,
                      //       )
                      //       .whereType<PieChartData>()
                      //       .toList(),
                      // )
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
        buildMainContents: const Align(
          child: CircularProgressIndicator(),
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
