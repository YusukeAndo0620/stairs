import 'package:stairs/loom/loom_package.dart';

const _kHeaderSpace = 4.0;
const _kHeaderTitleFooterTxt = "算出基準日: ";
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0);

/// ヘッダー（左にタイトルを算出基準日、右に指定されたWidgetを表示）
class StatusHeader extends StatelessWidget {
  const StatusHeader({
    super.key,
    required this.title,
    required this.trailWidget,
    this.isShownDate = true,
  });

  final String title;
  final Widget trailWidget;
  final bool isShownDate;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      padding: _kContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            isShownDate ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: theme.textStyleTitle
                      .copyWith(color: theme.colorFgDefault)),
              const SizedBox(
                height: _kHeaderSpace,
              ),
              if (isShownDate)
                Text(
                  _kHeaderTitleFooterTxt + getFormattedDateTime(DateTime.now()),
                  style: theme.textStyleFootnote
                      .copyWith(color: theme.colorDisabled),
                ),
            ],
          ),
          trailWidget,
        ],
      ),
    );
  }
}
