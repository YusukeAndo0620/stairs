import 'package:stairs/loom/loom_package.dart';

const _kHeaderHeight = 120.0;
const _kSpaceWidth = 16.0;

class ListItemHeader extends StatelessWidget {
  const ListItemHeader._({
    super.key,
    required this.firstLabel,
    this.secondLabel,
  }) : super();

  const ListItemHeader.singleColumn({
    Key? key,
    required String firstLabel,
  }) : this._(
          key: key,
          firstLabel: firstLabel,
        );

  const ListItemHeader.doubleColumn({
    Key? key,
    required String firstLabel,
    required String secondLabel,
  }) : this._(
          key: key,
          firstLabel: firstLabel,
          secondLabel: secondLabel,
        );

  final String firstLabel;
  final String? secondLabel;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      children: [
        SizedBox(
          height: _kHeaderHeight,
          child: Text(firstLabel, style: theme.textStyleBody),
        ),
        if (secondLabel != null) ...[
          const SizedBox(
            width: _kSpaceWidth,
          ),
          SizedBox(
            height: _kHeaderHeight,
            child: Text(firstLabel, style: theme.textStyleBody),
          ),
        ]
      ],
    );
  }
}
