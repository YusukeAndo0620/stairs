import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

class ColorListItem extends StatelessWidget {
  const ColorListItem({
    super.key,
    required this.selectedColorId,
    required this.colorModel,
    required this.onTap,
  });
  final int selectedColorId;
  final ColorModel colorModel;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return GestureDetector(
      onTap: () => onTap(colorModel.id),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorFgDefault,
              width: _kBorderWidth,
            ),
          ),
        ),
        child: Row(
          children: [
            CheckIcon(
              isChecked: selectedColorId == colorModel.id,
            ),
            Padding(
              padding: _kContentPadding,
              child: ColorBox(
                color: colorModel.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
