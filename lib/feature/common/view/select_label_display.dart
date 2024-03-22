import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kColumnSpace = 100.0;
const _kNewItemColumnSpace = 300.0;
const _kEmptyTxt = "選択できる項目がありません";
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

// ラベル選択画面
class SelectLabelDisplay extends ConsumerStatefulWidget {
  const SelectLabelDisplay({
    super.key,
    required this.title,
    required this.labelList,
    required this.checkedIdList,
    this.hintText,
    this.emptyText,
    this.isEditable = false,
    this.onAddLabel,
    this.onSubmitEditedText,
    this.onTapDelete,
    required this.onTapBackIcon,
  });
  final String title;
  final List<LabelModel> labelList;
  final List<String> checkedIdList;
  final String? hintText;
  final String? emptyText;
  // ラベル名を追加、編集可能かどうか
  final bool isEditable;
  // ラベル追加。id, ラベル名を返す
  final Function(String, String)? onAddLabel;
  // 編集完了アイコンを押下した際に発火。id, ラベル名を返す
  final Function(String, String)? onSubmitEditedText;
  // 選択したIDを返す
  final Function(String)? onTapDelete;
  final Function(List<String>) onTapBackIcon;
  @override
  ConsumerState<SelectLabelDisplay> createState() => _SelectLabelDisplayState();
}

class _SelectLabelDisplayState extends ConsumerState<SelectLabelDisplay> {
  // 新規ラベル項目が表示されているかどうか
  bool isNewLabelShown = false;
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
    final theme = LoomTheme.of(context);
    final selectLabelState = ref.watch(selectLabelProvider(
        labelList: widget.labelList, checkedIdList: widget.checkedIdList));
    final selectLabelNotifier = ref.watch(selectLabelProvider(
            labelList: widget.labelList, checkedIdList: widget.checkedIdList)
        .notifier);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // 最後のレコードまでスクロール
        if (isNewLabelShown) {
          Future.delayed(const Duration(milliseconds: 100)).then(
            (value) => controller.animateTo(controller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear),
          );
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
          onPressed: () {
            widget.onTapBackIcon(selectLabelNotifier.selectedIdList);
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          widget.title,
          style: theme.textStyleHeading,
        ),
      ),
      floatingActionButton: widget.isEditable
          ? FloatingActionButton(
              child: Icon(theme.icons.add),
              onPressed: () => setState(
                () {
                  isNewLabelShown = true;
                },
              ),
            )
          : null,
      body: Padding(
        padding: _kContentPadding,
        child: widget.labelList.isEmpty
            ? EmptyDisplay(
                message: widget.emptyText ?? _kEmptyTxt,
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: [
                          for (final info in selectLabelState)
                            CheckListItem(
                              info: info,
                              hintText: widget.hintText,
                              isTopBorderShown: selectLabelState.indexWhere(
                                      (element) => element.id == info.id) ==
                                  0,
                              isEditable: widget.isEditable,
                              onTap: (id) {
                                selectLabelNotifier.changeCheckedItem(id: id);
                              },
                              onSubmitEditedText: (labelName) {
                                if (widget.isEditable &&
                                    widget.onSubmitEditedText != null &&
                                    info.labelName != labelName) {
                                  selectLabelNotifier.changeName(
                                      id: info.id, name: labelName);
                                  widget.onSubmitEditedText!(
                                      info.id, labelName);
                                }
                              },
                              onTapDelete: (id) {
                                if (widget.isEditable &&
                                    widget.onTapDelete != null) {
                                  selectLabelNotifier.deleteItem(id: id);
                                  widget.onTapDelete!(id);
                                }
                              },
                            ),
                          if (isNewLabelShown) ...[
                            NewCheckListItem(
                              hintText: widget.hintText ?? '',
                              onSubmitEditedText: (labelName) {
                                if (widget.isEditable &&
                                    widget.onAddLabel != null) {
                                  final labelId = selectLabelNotifier.addLabel(
                                      name: labelName);
                                  widget.onAddLabel!(labelId, labelName);
                                  setState(
                                    () {
                                      isNewLabelShown = false;
                                    },
                                  );
                                }
                              },
                              onTapDelete: () => setState(
                                () {
                                  isNewLabelShown = false;
                                },
                              ),
                            ),
                            const SizedBox(height: _kNewItemColumnSpace),
                          ],
                          const SizedBox(height: _kColumnSpace),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
