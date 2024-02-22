import 'package:stairs/loom/loom_package.dart';

const _kHeaderSpace = 4.0;
const _kHeaderTitleFooterTxt = "算出基準日: ";

/// ヘッダー（左にタイトルを算出基準日、右に指定されたWidgetを表示）
class StatusHeader extends StatelessWidget {
  const StatusHeader({
    super.key,
    required this.title,
    required this.trailWidget,
  });

  final String title;
  final Widget trailWidget;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    theme.textStyleTitle.copyWith(color: theme.colorFgDefault)),
            const SizedBox(
              height: _kHeaderSpace,
            ),
            Text(
              _kHeaderTitleFooterTxt + getFormattedDateTime(DateTime.now()),
              style:
                  theme.textStyleFootnote.copyWith(color: theme.colorDisabled),
            ),
          ],
        ),
        trailWidget,
      ],
    );
  }
}
