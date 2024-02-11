import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kSpaceHeight = 20.0;
const _kTitleAndIconSpace = 8.0;
const _kIconSize = 16.0;

const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'task_card');

enum HeaderType {
  total,
  inProgress,
  completed,
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.headerType,
    required this.count,
    required this.changedPercent,
  });
  final String title;
  final HeaderType headerType;
  final int count;
  final int changedPercent;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final itemKey = GlobalKey();
    final theme = LoomTheme.of(context);

    return Container(
      key: itemKey,
      width: MediaQuery.of(context).size.width * 0.28,
      padding: _kContentPadding,
      margin: _kContentMargin,
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
      ),
      child: Column(
        children: [
          _Header(title: title, headerType: headerType),
          const SizedBox(
            height: _kSpaceHeight,
          ),
          _Content(count: count, changedPercent: changedPercent),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.headerType,
  });
  final String title;
  final HeaderType headerType;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      padding: _kContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textStyleBody,
          ),
          const SizedBox(
            width: _kTitleAndIconSpace,
          ),
          Icon(
            headerType == HeaderType.total
                ? Icons.ac_unit_rounded
                : headerType == HeaderType.inProgress
                    ? Icons.access_time
                    : headerType == HeaderType.completed
                        ? theme.icons.done
                        : Icons.abc,
            size: _kIconSize,
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.count,
    required this.changedPercent,
  });
  final int count;
  final int changedPercent;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final formattedPercent = changedPercent > 0
        ? "+$changedPercent（1ヶ月前）"
        : "-$changedPercent（1ヶ月前）";
    return Container(
      padding: _kContentPadding,
      child: Column(
        children: [
          Text(
            count.toString(),
            style: theme.textStyleSubHeading,
          ),
          Text(
            formattedPercent,
            style: theme.textStyleFootnote,
          ),
        ],
      ),
    );
  }
}
