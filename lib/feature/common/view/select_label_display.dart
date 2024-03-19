import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kEmptyTxt = "選択できる項目がありません";
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

// ラベル選択画面
class SelectLabelDisplay extends ConsumerWidget {
  const SelectLabelDisplay({
    super.key,
    required this.title,
    required this.labelList,
    required this.checkedIdList,
    this.hintText,
    this.emptyText,
    required this.onTapBackIcon,
  });
  final String title;
  final List<LabelModel> labelList;
  final List<String> checkedIdList;
  final String? hintText;
  final String? emptyText;
  final Function(List<String>) onTapBackIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final selectLabelState = ref.watch(selectLabelProvider(
        labelList: labelList, checkedIdList: checkedIdList));
    final selectLabelNotifier = ref.watch(
        selectLabelProvider(labelList: labelList, checkedIdList: checkedIdList)
            .notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () {
            onTapBackIcon(selectLabelNotifier.selectedIdList);
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          title,
          style: theme.textStyleHeading,
        ),
      ),
      body: Padding(
        padding: _kContentPadding,
        child: labelList.isEmpty
            ? EmptyDisplay(
                message: emptyText ?? _kEmptyTxt,
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final info in selectLabelState)
                            CheckListItem(
                              info: info,
                              isTopBorderShown: selectLabelState.indexWhere(
                                      (element) => element.id == info.id) ==
                                  0,
                              onTap: (tappedItem) {
                                selectLabelNotifier.changeCheckedItem(
                                    id: tappedItem.id);
                              },
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
