import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kSpaceHeight = 120.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

class LabelInputDisplay extends ConsumerWidget {
  const LabelInputDisplay({
    super.key,
    required this.title,
    required this.labelList,
    required this.hintText,
    required this.emptyText,
    required this.onTapBack,
  });
  final String title;
  final List<LabelModel> labelList;
  final String hintText;
  final String emptyText;

  final Function(Object) onTapBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    final scrollController = ScrollController();
    final labelInputState = ref.watch(labelInputProvider(labelList: labelList));
    final labelInputNotifier =
        ref.watch(labelInputProvider(labelList: labelList).notifier);

    ref.listen(
      labelInputProvider(labelList: labelList),
      (previous, next) {
        if (previous!.isNotEmpty && previous.length < next.length) {
          labelInputNotifier.moveLast(scrollController: scrollController);
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
            onTapBack(labelInputState);
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
          labelInputNotifier.addLabel();
        },
      ),
      body: Padding(
        padding: _kContentPadding,
        child: labelInputState.isEmpty
            ? EmptyDisplay(
                message: emptyText,
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          for (final info in labelInputState)
                            InputListItem(
                              id: info.id,
                              inputValue: info.labelName,
                              hintText: hintText,
                              autoFocus: info.labelName.isEmpty,
                              onTextSubmitted: (value, id) {
                                labelInputNotifier.updateInputValue(
                                    id: id, inputValue: value);
                              },
                              onDeleteItem: (inputValue) {
                                labelInputNotifier.deleteLabel(id: info.id);
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
