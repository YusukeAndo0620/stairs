import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);

class CheckListItem extends StatelessWidget {
  const CheckListItem({
    super.key,
    this.isTopBorderShown = false,
    required this.info,
    required this.onTap,
  });
  final bool isTopBorderShown;
  final CheckedLabelModel info;
  final Function(CheckedLabelModel) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return GestureDetector(
      onTap: () => onTap(info),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: isTopBorderShown
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
        child: Row(
          children: [
            CheckIcon(
              isChecked: info.checked,
            ),
            Padding(
                padding: _kContentPadding,
                child: Text(
                  info.labelName,
                  style: theme.textStyleBody,
                )),
          ],
        ),
      ),
    );
  }
}
