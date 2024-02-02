import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/board/component/provider/board_position_provider.dart';
import 'package:stairs/feature/board/component/view/board_adding_card.dart';
import 'package:stairs/feature/board/component/view/board_card.dart';
import 'package:stairs/feature/board/component/view/carousel_display.dart';
import 'package:stairs/feature/board/provider/board_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageAction {
  next,
  previous,
}

final _logger = stairsLogger(name: 'board_screen');

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({
    super.key,
    required this.projectId,
    required this.title,
    required this.themeColor,
    required this.devLangList,
    required this.labelList,
  });

  final String projectId;
  final String title;
  final Color themeColor;
  final List<LabelWithContent> devLangList;
  final List<ColorLabelModel> labelList;
  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  int currentDisplayBoardIdx = 0;
  final ScrollController controller = ScrollController();

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
    _logger.d('ビルド開始 {project_title:${widget.title}}');
    final theme = LoomTheme.of(context);

    // ボード
    final boardState = ref.watch(boardProvider(
        projectId: widget.projectId, database: ref.watch(databaseProvider)));

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // ポジション
        final positionNotifier = ref.read(boardPositionProvider.notifier);
        positionNotifier.init(projectId: widget.projectId);
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          widget.title,
          style: theme.textStyleSubHeading
              .copyWith(color: theme.colorFgDefault.withOpacity(0.9)),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: widget.themeColor.withOpacity(0.1),
        child: boardState.when(
          data: (list) {
            return CarouselDisplay(
              displayedWidgetIdx: currentDisplayBoardIdx,
              controller: controller,
              widgets: [
                for (final item in list)
                  BoardCard(
                    projectId: widget.projectId,
                    boardId: item.boardId,
                    title: item.title,
                    themeColor: widget.themeColor,
                    taskItemList: item.taskItemList,
                    devLangList: widget.devLangList,
                    labelList: widget.labelList,
                    onPageChanged: (pageAction) async {
                      setState(() {
                        currentDisplayBoardIdx = list.indexOf(list.firstWhere(
                            (element) => element.boardId == item.boardId));
                      });

                      switch (pageAction) {
                        case PageAction.next:
                          await _moveNext();
                        case PageAction.previous:
                          await _movePrevious();
                      }
                    },
                  ),
                BoardAddingCard(
                  themeColor: widget.themeColor,
                  onOpenCard: () => _moveLastPage(),
                  onTapAddingBtn: (inputValue) {
                    final boardNotifier = ref.watch(boardProvider(
                            projectId: widget.projectId,
                            database: ref.watch(databaseProvider))
                        .notifier);
                    boardNotifier.addBoard(
                        projectId: widget.projectId, title: inputValue);
                  },
                ),
              ],
            );
          },
          loading: () => const Align(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => Align(child: Text(error.toString())),
        ),
      ),
    );
  }

  Future<void> _moveNext() async {
    if (controller.position.pixels < controller.position.maxScrollExtent) {
      await controller.animateTo(controller.position.pixels + 20,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
    }
  }

  Future<void> _movePrevious() async {
    if (controller.position.pixels != 0) {
      await controller.animateTo(controller.position.pixels - 20,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
    }
  }

  void _moveLastPage() {
    controller.animateTo(controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
