import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kIconSize = 16.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

/// 選択項目
class CheckListItem extends StatefulWidget {
  const CheckListItem({
    super.key,
    required this.info,
    this.hintText,
    this.isTopBorderShown = false,
    required this.isEditable,
    required this.onTap,
    this.onSubmitEditedText,
    this.onTapDelete,
  });
  final CheckedLabelModel info;
  final bool isTopBorderShown;
  final String? hintText;
  // ラベル名を追加、編集可能かどうか
  final bool isEditable;
  // 選択したIDを返す
  final Function(String) onTap;
  // 編集完了アイコンを押下した際に発火。ラベル名を返す
  final Function(String)? onSubmitEditedText;
  // 選択したIDを返す
  final Function(String)? onTapDelete;
  @override
  State<StatefulWidget> createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  // 編集中かどうか
  bool isEditing = false;
  // 編集中のコントローラー
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.info.labelName);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return GestureDetector(
      onTap: () => isEditing ? {} : widget.onTap(widget.info.id),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: widget.isTopBorderShown
                ? BorderSide(
                    color: theme.colorFgDefault,
                    width: _kBorderWidth,
                  )
                : BorderSide.none,
            bottom: BorderSide(
              color: theme.colorFgDefault,
              width: _kBorderWidth,
            ),
          ),
        ),
        child: widget.isEditable && isEditing
            ? _EditItem(
                key: widget.key,
                info: widget.info,
                hintText: widget.hintText ?? '',
                textController: textController,
                onTapDone: () {
                  if (widget.onSubmitEditedText != null) {
                    widget.onSubmitEditedText!(textController.text);
                  }
                  setState(
                    () {
                      isEditing = false;
                    },
                  );
                },
                onTapDelete: () {
                  if (widget.onTapDelete != null) {
                    widget.onTapDelete!(widget.info.id);
                  }
                  setState(
                    () {
                      isEditing = false;
                    },
                  );
                },
              )
            : _NormalItem(
                key: widget.key,
                info: widget.info,
                isEditable: widget.isEditable,
                onTapEdit: () => setState(
                  () {
                    isEditing = true;
                  },
                ),
              ),
      ),
    );
  }
}

// 通常のレコード要素 編集アイコン押下していない状態の要素
class _NormalItem extends StatelessWidget {
  const _NormalItem({
    super.key,
    required this.info,
    required this.isEditable,
    required this.onTapEdit,
  });
  final CheckedLabelModel info;
  // ラベル名を追加、編集可能かどうか
  final bool isEditable;
  final VoidCallback onTapEdit;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CheckIcon(
              isChecked: info.checked,
            ),
            Padding(
              padding: _kContentPadding,
              child: Text(
                info.labelName,
                style: theme.textStyleBody,
              ),
            ),
          ],
        ),
        if (isEditable)
          IconButton(
            icon: Icon(
              theme.icons.edit,
            ),
            iconSize: _kIconSize,
            onPressed: onTapEdit,
          ),
      ],
    );
  }
}

// 編集状態のレコード
class _EditItem extends StatelessWidget {
  const _EditItem({
    super.key,
    required this.info,
    required this.hintText,
    required this.textController,
    required this.onTapDone,
    required this.onTapDelete,
  });
  final CheckedLabelModel info;
  final String hintText;
  final TextEditingController textController;
  final VoidCallback onTapDone;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CheckIcon(
              isChecked: info.checked,
            ),
            Padding(
              padding: _kContentPadding,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextInput(
                  textController: textController,
                  hintText: hintText,
                  autoFocus: true,
                  onSubmitted: (value) => {},
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                theme.icons.done,
              ),
              color: theme.colorPrimary,
              iconSize: _kIconSize,
              onPressed: onTapDone,
            ),
            IconButton(
              icon: Icon(
                theme.icons.trash,
              ),
              color: theme.colorDangerBgDefault,
              iconSize: _kIconSize,
              onPressed: onTapDelete,
            ),
          ],
        )
      ],
    );
  }
}
