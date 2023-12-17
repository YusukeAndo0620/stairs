import 'package:stairs/loom/loom_package.dart';

const _kCheckIconBoxSize = 40.0;
const _kCheckIconSize = 20.0;

class CheckIcon extends StatelessWidget {
  const CheckIcon({
    super.key,
    required this.isChecked,
  });
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return isChecked
        ? SizedBox(
            width: _kCheckIconBoxSize,
            child: IconButton(
              icon: Icon(
                theme.icons.done,
                color: theme.colorPrimary,
              ),
              iconSize: _kCheckIconSize,
              onPressed: () {},
            ),
          )
        : const SizedBox(
            width: _kCheckIconBoxSize,
          );
  }
}
