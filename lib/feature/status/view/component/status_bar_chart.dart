import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'status_bar_chart');

class StatusBarChart extends StatelessWidget {
  const StatusBarChart({
    super.key,
    this.title,
    this.color,
    required this.legendName,
    this.isHorizontal = false,
    required this.chartData,
  });

  final String? title;
  final Color? color;
  final String legendName;
  final bool isHorizontal;
  final List<BarChartData> chartData;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final theme = LoomTheme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: chartData.length * 50,
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
      child: _BarChart(
        title: title,
        legendName: legendName,
        color: color ?? theme.colorPrimary,
        isHorizontal: isHorizontal,
        chartData: chartData,
      ),
    );
  }
}

// 棒チャート
class _BarChart extends StatelessWidget {
  const _BarChart({
    super.key,
    this.title,
    required this.color,
    required this.legendName,
    required this.isHorizontal,
    required this.chartData,
  });

  final String? title;
  final Color color;
  final String legendName;
  final bool isHorizontal;
  final List<BarChartData> chartData;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return SfCartesianChart(
      isTransposed: isHorizontal,
      // タイトル
      title: title != null
          ? ChartTitle(text: title!, textStyle: theme.textStyleBody)
          : const ChartTitle(),
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(minimum: 0, interval: 1),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<BarChartData, String>>[
        ColumnSeries<BarChartData, String>(
          dataSource: chartData,
          name: legendName,
          xValueMapper: (BarChartData data, _) => data.x,
          yValueMapper: (BarChartData data, _) => data.y,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          width: 0.2,
          color: color,
          // データ数値の表示
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class BarChartData {
  BarChartData({
    required this.x,
    required this.y,
  });

  final String x;
  final double y;
}
