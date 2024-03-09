import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kTagHintTxt = 'タグ名を追加';
const _kColorHintText = '色を選択';
const _kTagListEmptyTxt = 'ラベルが登録されていません。\nラベルを登録してください。';

const _kColorTxt = '色';

const _kSpaceHeight = 120.0;
const _kColorSelectWidth = 100.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

///タグ（ラベル）入力・追加画面
class TagDisplay extends ConsumerWidget {
  const TagDisplay({
    super.key,
    required this.title,
    required this.tagList,
    required this.onTapBack,
  });
  final String title;
  final List<ColorLabelModel> tagList;
  final Function(Object) onTapBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final scrollController = ScrollController();
    final tagState = ref.watch(tagProvider(tagList: tagList));
    final tagNotifier = ref.watch(tagProvider(tagList: tagList).notifier);

    ref.listen(
      tagProvider(tagList: tagList),
      (previous, next) {
        if (previous!.isNotEmpty && previous.length < next.length) {
          tagNotifier.moveLast(scrollController: scrollController);
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
            tagNotifier.formatTagList();
            onTapBack(tagState);
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          title,
          style: theme.textStyleHeading,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(theme.icons.add),
        onPressed: () {
          tagNotifier.addTag();
        },
      ),
      body: Padding(
        padding: _kContentPadding,
        child: tagState.isEmpty
            ? const EmptyDisplay(
                message: _kTagListEmptyTxt,
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          for (final info in tagState)
                            LinkListItem(
                              id: info.id,
                              inputValue: info.labelName,
                              hintText: _kTagHintTxt,
                              linkHintText: _kColorHintText,
                              linkedWidgets: [
                                ColorBox(
                                  color: info.colorModel.color,
                                ),
                              ],
                              eventAreaWidth: _kColorSelectWidth,
                              isReadOnly: info.isReadOnly,
                              onTextSubmitted: (value, id) {
                                tagNotifier.updateInputValue(
                                    id: id, inputValue: value);
                              },
                              onTap: (id) => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SelectColorDisplay(
                                      title: _kColorTxt,
                                      selectedColorInfo: info.colorModel.color,
                                      onTap: (id) {},
                                      onTapBackIcon: (colorModel) {
                                        tagNotifier.updateLinkColor(
                                            id: id,
                                            themeColorModel: colorModel);
                                      },
                                    );
                                  },
                                ),
                              ),
                              onDeleteItem: (inputValue) {
                                tagNotifier.deleteTag(id: info.id);
                              },
                            ),
                          const SizedBox(
                            height: _kSpaceHeight,
                          ),
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
