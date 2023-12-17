import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kSpaceHeight = 120.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

// ラベル選択画面
class SelectLabelDisplay extends ConsumerWidget {
  const SelectLabelDisplay({
    super.key,
    required this.title,
    required this.labelList,
    required this.selectedLabelList,
    required this.onTapBackIcon,
    required this.onTap,
  });
  final String title;
  final List<LabelModel> labelList;
  final List<LabelModel> selectedLabelList;
  final Function(List<LabelModel>) onTapBackIcon;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final selectLabelState = ref.watch(selectLabelProvider(
        labelList: labelList, selectedLabelList: selectedLabelList));
    final selectLabelNotifier = ref.watch(selectLabelProvider(
            labelList: labelList, selectedLabelList: selectedLabelList)
        .notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () {
            onTapBackIcon(selectLabelNotifier.selectedList);
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final info in selectLabelState)
                      CheckListItem(
                        info: info,
                        onTap: (tappedItem) {
                          selectLabelNotifier.changeCheckedItem(
                              id: tappedItem.id);
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
