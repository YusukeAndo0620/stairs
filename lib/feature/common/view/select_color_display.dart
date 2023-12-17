import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/m_color_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kSpaceHeight = 120.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

///カラー選択画面
class SelectColorDisplay extends ConsumerWidget {
  const SelectColorDisplay({
    super.key,
    required this.title,
    required this.selectedColorInfo,
    required this.onTapBackIcon,
    required this.onTap,
  });
  final String title;
  final Color selectedColorInfo;
  final Function(Color) onTapBackIcon;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);
    SelectColorModel? selectColorState;
    SelectColor? selectColorNotifier;

    final colorList =
        ref.watch(mColorProvider(database: ref.watch(databaseProvider)));

    colorList.whenData((value) {
      selectColorState = ref.watch(
        selectColorProvider(
          colorList: colorList.value!,
          selectedColorId: getIdByColor(
              colorList: colorList.value!, color: selectedColorInfo),
        ),
      );
      selectColorNotifier = ref.watch(selectColorProvider(
        colorList: colorList.value!,
        selectedColorId:
            getIdByColor(colorList: colorList.value!, color: selectedColorInfo),
      ).notifier);
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            theme.icons.back,
            color: theme.colorFgDefault,
          ),
          onPressed: () {
            if (selectColorNotifier != null) {
              onTapBackIcon(selectColorNotifier!.selectedColorInfo.color);
            }
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
        child: selectColorState == null || selectColorNotifier == null
            ? const Align(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final colorInfo in selectColorState!.colorList)
                            ColorListItem(
                              selectedColorId:
                                  selectColorState!.selectedColorId,
                              colorModel: colorInfo,
                              onTap: (id) {
                                selectColorNotifier!
                                    .changeSelectedColor(colorId: id);
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
