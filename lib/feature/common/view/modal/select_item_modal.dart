import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kListEmptyTxt = '選択可能なタグがありません。\n ボード設定 > ラベルより、ラベルを追加してください。';
const _kListItemSpace = 16.0;
const _kBorderWidth = 1.0;
const _kCheckIconSize = 20.0;
const _kTileCheckIconSize = 14.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0);

enum DisplayType { list, tile }

/// アイテム選択リスト画面(カラーボックス+タイトル)
class SelectItemModal extends ConsumerWidget {
  const SelectItemModal({
    super.key,
    required this.id,
    this.type = DisplayType.list,
    required this.title,
    required this.height,
    required this.labelList,
    required this.selectedLabelList,
    required this.onTapListItem,
  });
  final String id;
  final DisplayType type;
  final String title;
  final double height;
  final List<ColorLabelModel> labelList;
  final List<ColorLabelModel> selectedLabelList;
  final Function(List<ColorLabelModel>) onTapListItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectItemState = ref.watch(selectItemProvider);
    if (selectItemState.isEmpty) {
      ref.read(selectItemProvider.notifier).init(
          id: id, labelList: labelList, selectedLabelList: selectedLabelList);
    }
    return Modal(
      height: height,
      title: title,
      isShowTrailing: false,
      buildMainContent: _Frame(
        key: key,
        title: title,
        type: type,
        checkList: selectItemState,
        onTapListItem: (_) {
          final notifier = ref.read(selectItemProvider.notifier);
          onTapListItem(notifier.selectedList);
        },
      ),
    );
  }
}

class _Frame extends StatelessWidget {
  const _Frame({
    super.key,
    required this.title,
    required this.checkList,
    required this.type,
    required this.onTapListItem,
  });
  final String title;
  final List<CheckedColorLabelInfo> checkList;
  final DisplayType type;
  final Function(List<CheckedColorLabelInfo>) onTapListItem;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      color: theme.colorBgLayer1,
      padding: _kContentPadding,
      child: checkList.isEmpty
          ? Container(
              color: theme.colorBgLayer1,
              child: Text(
                _kListEmptyTxt,
                style: theme.textStyleBody,
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                type == DisplayType.list
                    ? _ListContent(
                        key: key,
                        checkList: checkList,
                        onTapListItem: (_) => onTapListItem([]),
                      )
                    : _TileContent(
                        key: key,
                        checkList: checkList,
                        onTapListItem: (_) => onTapListItem([]),
                      ),
              ],
            ),
    );
  }
}

/// リスト形式
class _ListContent extends ConsumerWidget {
  const _ListContent({
    super.key,
    required this.checkList,
    required this.onTapListItem,
  });
  final List<CheckedColorLabelInfo> checkList;
  final Function(List<CheckedColorLabelInfo>) onTapListItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    return Column(
      children: [
        for (final info in checkList)
          GestureDetector(
            onTap: () {
              final notifier = ref.read(selectItemProvider.notifier);
              notifier.changeCheckedItem(id: info.id);
              onTapListItem([]);
            },
            child: ListTile(
              leading: info.checked
                  ? IconButton(
                      icon: Icon(
                        theme.icons.done,
                        color: theme.colorPrimary,
                      ),
                      iconSize: _kCheckIconSize,
                      onPressed: () {},
                    )
                  : const SizedBox(
                      width: _kCheckIconSize,
                    ),
              title: _ListItem(
                key: key,
                info: info,
              ),
              shape: Border(
                bottom: BorderSide(
                  color: theme.colorFgDefault,
                  width: _kBorderWidth,
                ),
              ),
            ),
          )
      ],
    );
  }
}

/// タイル形式
class _TileContent extends ConsumerWidget {
  const _TileContent({
    super.key,
    required this.checkList,
    required this.onTapListItem,
  });
  final List<CheckedColorLabelInfo> checkList;
  final Function(List<CheckedColorLabelInfo>) onTapListItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    return Wrap(
      children: [
        for (final info in checkList)
          GestureDetector(
            onTap: () {
              final notifier = ref.read(selectItemProvider.notifier);
              notifier.changeCheckedItem(id: info.id);
              onTapListItem([]);
            },
            child: Badge(
              position: BadgePosition.topEnd(top: 10, end: 0),
              badgeAnimation:
                  const BadgeAnimation.scale(curve: Curves.bounceOut),
              badgeStyle: BadgeStyle(
                  shape: BadgeShape.square,
                  borderSide: info.checked
                      ? const BorderSide(width: _kBorderWidth)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                  badgeColor: info.checked
                      ? theme.colorBgLayer1
                      : theme.colorBgLayer1.withOpacity(0.0)),
              badgeContent: info.checked
                  ? Icon(
                      theme.icons.done,
                      color: theme.colorPrimary,
                      size: _kTileCheckIconSize,
                    )
                  : null,
              child: Container(
                padding: _kContentPadding,
                margin: _kContentMargin,
                decoration: BoxDecoration(
                  color: info.checked ? info.color.withOpacity(0.7) : null,
                  border: Border.all(
                    color: info.color,
                    width: _kBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  info.labelName,
                  style: theme.textStyleBody,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    super.key,
    required this.info,
  });
  final CheckedColorLabelInfo info;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Padding(
      padding: _kContentPadding,
      child: Row(
        children: [
          ColorBox(
            color: info.color,
            size: _kCheckIconSize,
          ),
          const SizedBox(width: _kListItemSpace),
          Text(
            info.labelName,
            style: theme.textStyleBody,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
