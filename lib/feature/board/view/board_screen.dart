import 'package:stairs/feature/board/provider/board_position_provider.dart';
import 'package:stairs/feature/board/view/component/board/board_adding_card.dart';
import 'package:stairs/feature/board/view/component/board/board_card.dart';
import 'package:stairs/feature/board/view/component/board/carousel_display.dart';
import 'package:stairs/feature/board/provider/board_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageAction {
  next,
  previous,
}

const _kCompletedTxt = '完了';
const _kCompletedBoardOrderNo = 999;

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
  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.9);

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
    final boardState = ref.watch(boardProvider(projectId: widget.projectId));

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
          data: (state) {
            // 完了ボード作成
            if (state.boardList.isEmpty) {
              // ボード notifier
              final boardNotifier = ref
                  .watch(boardProvider(projectId: widget.projectId).notifier);
              boardNotifier.addBoard(
                projectId: widget.projectId,
                title: _kCompletedTxt,
                orderNo: _kCompletedBoardOrderNo,
                isCompleted: true,
              );
              return const SizedBox.shrink();
            }
            return CarouselDisplay(
              controller: controller,
              widgets: [
                for (final item in state.boardList)
                  BoardCard(
                    projectId: widget.projectId,
                    boardId: item.boardId,
                    title: item.title,
                    themeColor: widget.themeColor,
                    taskItemList: item.taskItemList,
                    devLangList: widget.devLangList,
                    labelList: widget.labelList,
                    onPageChanged: (pageAction) async {
                      switch (pageAction) {
                        case PageAction.next:
                          if (controller.positions.isEmpty) return;
                          if (controller.page!.toInt() <
                              state.boardList.length - 1) {
                            _moveNext();
                          }
                        case PageAction.previous:
                          if (controller.positions.isEmpty ||
                              controller.page!.toInt() == 0) return;
                          _movePrevious();
                      }
                    },
                    onOccurError: () async {
                      // ボード一覧取得し、stateに設定
                      // ボード Notifier
                      final boardNotifier = ref.watch(
                          boardProvider(projectId: widget.projectId).notifier);
                      await boardNotifier.setBoardList(
                          projectId: widget.projectId);
                    },
                  ),
                BoardAddingCard(
                  themeColor: widget.themeColor,
                  onOpenCard: () => _moveLastPage(),
                  onTapAddingBtn: (inputValue) {
                    final boardNotifier = ref.watch(
                        boardProvider(projectId: widget.projectId).notifier);
                    boardNotifier.addBoard(
                        projectId: widget.projectId, title: inputValue);
                  },
                ),
              ],
            );
          },
          loading: () => Align(
            child: CircularProgressIndicator(
              color: theme.colorPrimary,
            ),
          ),
          error: (error, _) => Align(child: Text(error.toString())),
        ),
      ),
    );
  }

  Future<void> _moveNext() async {
    controller.animateToPage(
      controller.page!.toInt() + 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> _movePrevious() async {
    controller.animateToPage(
      controller.page!.toInt() - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _moveLastPage() {
    controller.animateTo(controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
