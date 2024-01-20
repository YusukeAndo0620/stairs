import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/board/component/provider/board_position_provider.dart';
import 'package:stairs/feature/board/component/provider/carousel_provider.dart';
import 'package:stairs/feature/board/component/view/board_adding_card.dart';
import 'package:stairs/feature/board/component/view/board_card.dart';
import 'package:stairs/feature/board/component/view/carousel_display.dart';
import 'package:stairs/feature/board/provider/board_provider.dart';
import 'package:stairs/feature/board/provider/drag_item_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageAction {
  next,
  previous,
}

class BoardScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // ボード
    final boardState = ref.watch(boardProvider(
        projectId: projectId, database: ref.watch(databaseProvider)));
    final boardNotifier = ref.watch(boardProvider(
            projectId: projectId, database: ref.watch(databaseProvider))
        .notifier);

    // ポジション
    final positionNotifier = ref.watch(boardPositionProvider.notifier);

    // ドラッグアイテム
    final dragItemNotifier = ref.watch(dragItemProvider.notifier);

    // Carousel Display
    final carouselDisplayState = ref.watch(carouselProvider);
    final carouselDisplayNotifier = ref.watch(carouselProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        positionNotifier.init(projectId: projectId);
        if (boardState.value != null) {
          carouselDisplayNotifier.init(maxPage: boardState.value!.length);
        }
      },
    );

    final theme = LoomTheme.of(context);
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
          title,
          style: theme.textStyleSubHeading
              .copyWith(color: theme.colorFgDefault.withOpacity(0.9)),
        ),
      ),
      body: Container(
        color: themeColor.withOpacity(0.1),
        child: boardState.when(
          data: (list) {
            return CarouselDisplay(
              pages: [
                for (final item in list)
                  BoardCard(
                    projectId: projectId,
                    boardId: item.boardId,
                    displayedBoardId:
                        list[carouselDisplayState.currentPage].boardId,
                    title: item.title,
                    themeColor: themeColor,
                    taskItemList: item.taskItemList,
                    devLangList: devLangList,
                    labelList: labelList,
                    onPageChanged: (pageAction) {
                      //すでにページ番号が更新されていた場合、処理を行わない
                      if (list[carouselDisplayState.currentPage].boardId !=
                          item.boardId) {
                        return;
                      }
                      final currentBoardIdIndex = list.indexOf(list.firstWhere(
                          (element) => element.boardId == item.boardId));

                      switch (pageAction) {
                        case PageAction.next:
                          if (carouselDisplayState.currentPage <
                              list.length - 1) {
                            carouselDisplayNotifier.moveNextPage();
                            dragItemNotifier.setItem(
                              boardId: list[currentBoardIdIndex + 1].boardId,
                            );
                          }
                        case PageAction.previous:
                          if (carouselDisplayState.currentPage > 0) {
                            carouselDisplayNotifier.movePreviousPage();
                            dragItemNotifier.setItem(
                              boardId: list[currentBoardIdIndex - 1].boardId,
                            );
                          }
                      }
                    },
                  ),
                BoardAddingCard(
                  themeColor: themeColor,
                  onOpenCard: () => carouselDisplayNotifier.moveLastPage(),
                  onTapAddingBtn: (inputValue) {
                    boardNotifier.addBoard(
                        projectId: projectId, title: inputValue);
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
}
