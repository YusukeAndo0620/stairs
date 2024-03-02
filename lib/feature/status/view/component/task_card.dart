import 'package:stairs/loom/loom_package.dart';

const _kIconSize = 16.0;
const _kTitleAndCountSpace = 8.0;
const _kCountSpace = 8.0;

const _kLastMonthTxt = '（1ヶ月前）';
const _kContentPadding = EdgeInsets.all(4.0);
const _kContentMargin = EdgeInsets.all(8.0);

final _logger = stairsLogger(name: 'task_card');

enum HeaderType {
  total,
  inProgress,
  overDueDate,
  completed,
}

// タスク数を表示するカード
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.headerType,
    required this.count,
    required this.lastMonthTaskCount,
  });
  final String title;
  final HeaderType headerType;
  final int count;
  final int lastMonthTaskCount;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final theme = LoomTheme.of(context);
    final icon = headerType == HeaderType.total
        ? Icons.task
        : headerType == HeaderType.inProgress
            ? Icons.access_time
            : headerType == HeaderType.overDueDate
                ? theme.icons.calender
                : headerType == HeaderType.completed
                    ? theme.icons.done
                    : Icons.abc;
    // アイコン色
    final iconColor = headerType == HeaderType.total
        ? theme.colorFgDefault
        : headerType == HeaderType.inProgress
            ? theme.colorProgress
            : headerType == HeaderType.overDueDate
                ? theme.colorDangerBgDefault
                : headerType == HeaderType.completed
                    ? theme.colorPrimary
                    : theme.colorFgDefault;
    // 背景色
    final color = headerType == HeaderType.total
        ? theme.colorFgDefaultWhite
        : iconColor.withOpacity(0.1);

    return CardBox(
      width: MediaQuery.of(context).size.width * 0.43,
      color: color,
      borderColor: theme.colorFgDefault.withOpacity(0.7),
      padding: _kContentPadding,
      margin: _kContentMargin,
      child: Column(
        children: [
          _Content(
              title: title,
              icon: Icon(
                icon,
                size: _kIconSize,
                color: iconColor,
              ),
              count: count,
              lastMonthTaskCount: lastMonthTaskCount),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.icon,
    required this.count,
    required this.lastMonthTaskCount,
  });
  final String title;
  final Icon icon;
  final int count;
  final int lastMonthTaskCount;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final formattedCount = 0 <= lastMonthTaskCount
        ? "+$lastMonthTaskCount件"
        : "$lastMonthTaskCount件";
    return Container(
      padding: _kContentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    count.toString(),
                    style: theme.textStyleSubHeading
                        .copyWith(color: theme.colorFgDefault),
                  ),
                  const SizedBox(width: _kCountSpace),
                  Text(
                    formattedCount,
                    style: theme.textStyleFootnote
                        .copyWith(color: theme.colorDisabled),
                  ),
                  Text(
                    _kLastMonthTxt,
                    style: theme.textStyleFootnote
                        .copyWith(color: theme.colorDisabled),
                  ),
                ],
              ),
              icon,
            ],
          ),
          const SizedBox(height: _kTitleAndCountSpace),
          Text(
            title,
            style: theme.textStyleBody,
          ),
        ],
      ),
    );
  }
}
