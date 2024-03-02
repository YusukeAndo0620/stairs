import 'package:stairs/feature/board/provider/board_position_provider.dart';
import 'package:stairs/feature/board/view/component/task/task_list_item.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _logger = stairsLogger(name: 'shrink_list_item');

class ShrinkTaskListItem extends ConsumerWidget {
  const ShrinkTaskListItem({
    super.key,
    required this.taskItemId,
  });
  final String taskItemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final itemKey = GlobalKey();
    final theme = LoomTheme.of(context);

    // ポジション
    final positionNotifier = ref.watch(boardPositionProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logger.d('shrink item: position更新');
      positionNotifier.setTaskItemPosition(
        taskItemId: taskItemId,
        key: itemKey,
      );
    });

    return Container(
      key: itemKey,
      width: MediaQuery.of(context).size.width * 0.9,
      height: kDraggedItemHeight,
      color: theme.colorDisabled.withOpacity(0.2),
    );
  }
}
