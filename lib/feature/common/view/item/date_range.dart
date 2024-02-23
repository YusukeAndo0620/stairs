import 'package:stairs/loom/loom_package.dart';

const _kRangeSpaceTxt = '-';
const _kContentSpace = 2.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0);

/// 期間
class DateRange extends StatelessWidget {
  const DateRange({
    super.key,
    required this.startDate,
    required this.endDate,
  });
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      padding: _kContentPadding,
      child: Row(
        children: [
          Text(
            getFormattedDate(startDate),
            style: theme.textStyleBody,
          ),
          const SizedBox(
            width: _kContentSpace,
          ),
          Text(
            _kRangeSpaceTxt,
            style: theme.textStyleBody,
          ),
          const SizedBox(
            width: _kContentSpace,
          ),
          Text(
            getFormattedDate(endDate),
            style: theme.textStyleBody,
          ),
        ],
      ),
    );
  }
}
