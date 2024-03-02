import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/view/component/status_header.dart';
import 'package:stairs/feature/status/view/component/status_label_table.dart';

import 'package:stairs/loom/loom_package.dart';

const _kHeaderTitle = "ラベル";
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);

final _logger = stairsLogger(name: 'status_label_area');

/// ラベル一覧表示エリア
class StatusLabelArea extends StatelessWidget {
  const StatusLabelArea({
    super.key,
    this.margin,
    required this.totalLabelTaskCount,
    required this.labelStatusList,
  });

  final EdgeInsets? margin;
  final int totalLabelTaskCount;
  final List<LabelStatusModel> labelStatusList;

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: _kContentPadding,
      child: Column(
        children: [
          const StatusHeader(
            title: _kHeaderTitle,
            isShownDate: false,
          ),
          StatusLabelTable(
            totalLabelTaskCount: totalLabelTaskCount,
            labelStatusList: labelStatusList,
          ),
        ],
      ),
    );
  }
}
