import 'package:stairs/feature/status/provider/status_provider.dart';
import 'package:stairs/feature/status/view/component/task_card.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _logger = stairsLogger(name: 'status_screen');
const _kTotalTitle = "全タスク";
const _kProgressTitle = "進行中タスク";
const _kCompletedTitle = "完了タスク";

///ステータス
class StatusScreen extends ConsumerStatefulWidget {
  const StatusScreen({
    super.key,
  });

  @override
  ConsumerState<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends ConsumerState<StatusScreen> {
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
        return SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  for (final item in list) ...[
                    TaskCard(
                      title: _kTotalTitle,
                      headerType: HeaderType.total,
                      count: item.totalTaskCount,
                      changedPercent: 20,
                    ),
                    TaskCard(
                      title: _kProgressTitle,
                      headerType: HeaderType.inProgress,
                      count: item.totalTaskCount - item.completedTaskCount,
                      changedPercent: 20,
                    ),
                    TaskCard(
                      title: _kCompletedTitle,
                      headerType: HeaderType.completed,
                      count: item.completedTaskCount,
                      changedPercent: 20,
                    ),
                  ]
                ],
              )
            ],
          ),
        );
      },
      loading: () => const Align(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Align(child: Text(error.toString())),
    );
  }
}
