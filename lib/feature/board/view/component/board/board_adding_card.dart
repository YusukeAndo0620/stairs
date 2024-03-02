import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kMaxLength = 30;
const _kAddingButtonHeight = 100.0;
const _kAddingIconSize = 16.0;
const _kInputTextAndButtonSpace = 30.0;

const _kAddingTitleTxt = 'ワークボードを追加';
const _kAddingTitleHintTxt = 'ワークボード';

const _kCancelBtnTxt = 'キャンセル';
const _kAddBtnTxt = '追加';

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);

///ボード追加カード画面
class BoardAddingCard extends StatefulWidget {
  const BoardAddingCard({
    super.key,
    required this.themeColor,
    required this.onOpenCard,
    required this.onTapAddingBtn,
  });
  final Color themeColor;
  final VoidCallback onOpenCard;
  final Function(String) onTapAddingBtn;

  @override
  State<StatefulWidget> createState() => _BoardAddingCardState();
}

class _BoardAddingCardState extends State<BoardAddingCard> {
  // 新規ボード入力画面 表示状態
  bool _isNewBoardCardShown = false;
  // 新規ボードが追加されたかどうか
  bool _isNewBoardAdded = false;
  final textController = TextEditingController(text: '');

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
    if (_isNewBoardAdded) {
      setState(() {
        textController.text = '';
        _isNewBoardAdded = false;
      });
    }

    final theme = LoomTheme.of(context);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: _kContentPadding,
      child: _isNewBoardCardShown
          ? Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: _kContentPadding,
              decoration: BoxDecoration(
                color: theme.colorFgDefaultWhite,
                border: Border.all(
                  color: theme.colorFgDisabled,
                  width: _kBorderWidth,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInput(
                    textController: textController,
                    hintText: _kAddingTitleHintTxt,
                    maxLength: _kMaxLength,
                    autoFocus: true,
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(
                    height: _kInputTextAndButtonSpace,
                  ),
                  _FooterButtonArea(
                    key: widget.key,
                    themeColor: widget.themeColor,
                    disabled: false,
                    onTapAdd: () {
                      setState(
                        () {
                          _isNewBoardCardShown = false;
                          _isNewBoardAdded = true;
                        },
                      );
                      widget.onTapAddingBtn(textController.text);
                    },
                    onTapCancel: () => setState(
                      () {
                        _isNewBoardCardShown = false;
                      },
                    ),
                  )
                ],
              ),
            )
          : CustomTextButton(
              title: _kAddingTitleTxt,
              height: _kAddingButtonHeight,
              icon: Icon(
                theme.icons.add,
                size: _kAddingIconSize,
              ),
              themeColor: widget.themeColor,
              disabled: false,
              onTap: () {
                widget.onOpenCard();
                setState(
                  () {
                    _isNewBoardCardShown = true;
                  },
                );
              },
            ),
    );
  }
}

class _FooterButtonArea extends StatelessWidget {
  const _FooterButtonArea({
    super.key,
    required this.disabled,
    required this.themeColor,
    required this.onTapCancel,
    required this.onTapAdd,
  });
  final bool disabled;
  final Color themeColor;
  final VoidCallback onTapCancel;
  final VoidCallback onTapAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          title: _kCancelBtnTxt,
          themeColor: themeColor,
          onTap: onTapCancel,
        ),
        AbsorbPointer(
          absorbing: disabled,
          child: CustomTextButton(
            title: _kAddBtnTxt,
            themeColor: themeColor,
            disabled: disabled,
            onTap: onTapAdd,
          ),
        ),
      ],
    );
  }
}
