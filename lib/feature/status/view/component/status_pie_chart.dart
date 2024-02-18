import 'package:stairs/loom/loom_package.dart';

const _kBorderWidth = 1.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'status_pie_chart');

class StatusPieChart extends StatelessWidget {
  const StatusPieChart({
    super.key,
    this.title,
    required this.legendName,
    this.isLegendVisible = true,
    this.color,
    required this.chartData,
  });

  final String? title;
  final String legendName;
  final bool isLegendVisible;
  final Color? color;
  final List<PieChartData> chartData;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final theme = LoomTheme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: chartData.length * 40,
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
      child: SfCircularChart(
        // タイトル
        title: title != null
            ? ChartTitle(text: title!, textStyle: theme.textStyleBody)
            : const ChartTitle(),
        // 凡例の表示
        legend: Legend(isVisible: isLegendVisible),
        series: <PieSeries<PieChartData, String>>[
          PieSeries<PieChartData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: chartData,
              xValueMapper: (PieChartData data, _) => data.x,
              yValueMapper: (PieChartData data, _) => data.y,
              dataLabelMapper: (PieChartData data, _) => data.text,
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class PieChartData {
  PieChartData({required this.x, required this.y, this.text});

  final String x;
  final num y;
  String? text;
}
