import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kIconSize = 16.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

/// 新規追加で表示される選択項目
class NewCheckListItem extends StatefulWidget {
  const NewCheckListItem({
    super.key,
    required this.hintText,
    required this.onSubmitEditedText,
    required this.onTapDelete,
  });
  final String hintText;
  // 編集完了アイコンを押下した際に発火。ラベル名を返す
  final Function(String) onSubmitEditedText;
  // 選択したIDを返す
  final VoidCallback onTapDelete;
  @override
  State<StatefulWidget> createState() => _NewCheckListItemState();
}

class _NewCheckListItemState extends State<NewCheckListItem> {
  // 編集中のコントローラー
  final TextEditingController textController = TextEditingController();

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

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorFgDefault,
            width: _kBorderWidth,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CheckIcon(
                isChecked: false,
              ),
              Padding(
                padding: _kContentPadding,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextInput(
                    textController: textController,
                    hintText: widget.hintText,
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
                onPressed: () => widget.onSubmitEditedText(textController.text),
              ),
              IconButton(
                icon: Icon(
                  theme.icons.close,
                ),
                iconSize: _kIconSize,
                onPressed: widget.onTapDelete,
              ),
            ],
          )
        ],
      ),
    );
  }
}
