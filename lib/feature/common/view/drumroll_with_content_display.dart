import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

const _kSpaceHeight = 120.0;
const _kLabelWidth = 130.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);
const _kLabelContentPadding =
    EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
const _kListItemBorder = 1.0;
const _kDeleteIconSize = 16.0;
const _kSpaceWidth = 8.0;
const _kDrumExtent = 40.0;

/// リストボックス＋テキスト入力画面
class DrumrollWithContentDisplay extends ConsumerWidget {
  const DrumrollWithContentDisplay({
    super.key,
    required this.title,
    required this.hintText,
    required this.selectedListEmptyText,
    required this.labeList,
    required this.selectedList,
    required this.onTapBack,
  });
  final String title;
  final String hintText;
  final String selectedListEmptyText;
  final List<LabelModel> labeList;
  final List<LabelWithContent> selectedList;
  final Function(List<LabelWithContent>) onTapBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final scrollController = ScrollController();
    final selectItemState = ref.watch(drumrollWithContentProvider(
        labeList: labeList, selectedList: selectedList));
    final selectItemNotifier = ref.watch(drumrollWithContentProvider(
            labeList: labeList, selectedList: selectedList)
        .notifier);

    ref.listen(
      drumrollWithContentProvider(
          labeList: labeList, selectedList: selectedList),
      (previous, next) {
        if (previous!.selectedList.isNotEmpty &&
            previous.selectedList.length < next.selectedList.length) {
          selectItemNotifier.moveLast(scrollController: scrollController);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () => _onTapBack(
              context: context,
              selectedList: selectItemState.selectedList,
              isMovingBack: true),
        ),
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          title,
          style: theme.textStyleHeading,
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 25) {
            _onTapBack(
                context: context,
                selectedList: selectItemState.selectedList,
                isMovingBack: true);
          }
        },
        child: Padding(
          padding: _kContentPadding,
          child: selectItemState.selectedList.isEmpty
              ? EmptyDisplay(
                  message: selectedListEmptyText,
                )
              : Column(
                  children: [
                    _Content(
                      key: key,
                      selectItemListModel: selectItemState,
                      scrollController: scrollController,
                      hintText: hintText,
                      onChangeSelectedItem: (id, labelId) => selectItemNotifier
                          .updateSelectedLabel(id: id, labelId: labelId),
                      onTextSubmitted: (id, value) => selectItemNotifier
                          .updateInputValue(id: id, inputValue: value),
                      onTapDelete: (id) =>
                          selectItemNotifier.deleteSelectedLabel(id: id),
                    )
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(theme.icons.add),
        onPressed: () => selectItemNotifier.addSelectedLabel(),
      ),
    );
  }

  void _onTapBack({
    required BuildContext context,
    required List<LabelWithContent> selectedList,
    required bool isMovingBack,
  }) {
    onTapBack(selectedList);
    if (isMovingBack) Navigator.pop(context);
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    super.key,
    required this.selectItemListModel,
    required this.scrollController,
    required this.hintText,
    required this.onTextSubmitted,
    required this.onChangeSelectedItem,
    required this.onTapDelete,
  });
  final SelectItemListModel selectItemListModel;
  final ScrollController scrollController;
  final String hintText;
  final Function(String, String) onTextSubmitted;
  final Function(String, String) onChangeSelectedItem;
  final Function(String) onTapDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            for (final info in selectItemListModel.selectedList)
              _ListItem(
                key: key,
                labeList: selectItemListModel.labeList,
                selectedItem: info,
                hintText: hintText,
                onTextSubmitted: (value) => onTextSubmitted(info.id, value),
                onChangeSelectedItem: (id) => onChangeSelectedItem(info.id, id),
                onTapDelete: () => onTapDelete(info.id),
              ),
            const SizedBox(
              height: _kSpaceHeight,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    super.key,
    required this.labeList,
    required this.selectedItem,
    required this.hintText,
    required this.onChangeSelectedItem,
    required this.onTextSubmitted,
    required this.onTapDelete,
  });
  final List<LabelModel> labeList;
  final LabelWithContent selectedItem;
  final String hintText;
  final Function(String) onChangeSelectedItem;
  final Function(String) onTextSubmitted;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: _kContentPadding,
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        border: Border(
          bottom: BorderSide(
            color: theme.colorFgDisabled,
            width: _kListItemBorder,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TapAction(
            widget: Container(
              width: _kLabelWidth,
              padding: _kLabelContentPadding,
              decoration: BoxDecoration(
                color: theme.colorFgDefaultWhite,
                border: Border.all(
                  color: theme.colorFgDisabled,
                  width: _kListItemBorder,
                ),
              ),
              child: Text(
                selectedItem.labelName,
                style: theme.textStyleBody,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            tappedColor: theme.colorPrimary,
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CupertinoPicker(
                        itemExtent: _kDrumExtent,
                        onSelectedItemChanged: (index) =>
                            onChangeSelectedItem(labeList[index].id),
                        scrollController: FixedExtentScrollController(
                          initialItem: labeList.indexWhere(
                              (element) => element.id == selectedItem.labelId),
                        ),
                        children: [
                          for (final item in labeList) ...[
                            Align(
                              child: Text(
                                item.labelName,
                                style: theme.textStyleBody,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            width: _kSpaceWidth,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextInput(
              textController: TextEditingController(text: selectedItem.content),
              hintText: hintText,
              onSubmitted: (value) => onTextSubmitted(value),
            ),
          ),
          const SizedBox(
            width: _kSpaceWidth,
          ),
          IconButton(
            icon: Icon(
              theme.icons.close,
            ),
            iconSize: _kDeleteIconSize,
            onPressed: () => onTapDelete(),
          ),
        ],
      ),
    );
  }
}
