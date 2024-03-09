import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

part 'label_table_provider.g.dart';

final _logger = stairsLogger(name: 'label_table_provider');

class LabelTableState extends Equatable {
  const LabelTableState({
    required this.sortAscending,
    required this.sortedColumnIdx,
    required this.list,
  });

  final bool sortAscending;
  final int sortedColumnIdx;
  final List<LabelStatusModel> list;

  @override
  List<Object?> get props => [
        sortAscending,
        sortedColumnIdx,
        list,
      ];

  LabelTableState copyWith({
    bool? sortAscending,
    int? sortedColumnIdx,
    List<LabelStatusModel>? list,
  }) =>
      LabelTableState(
        sortAscending: sortAscending ?? this.sortAscending,
        sortedColumnIdx: sortedColumnIdx ?? this.sortedColumnIdx,
        list: list ?? this.list,
      );
}

@riverpod
class LabelTable extends _$LabelTable {
  @override
  LabelTableState build({
    required List<LabelStatusModel> labelStatusList,
  }) {
    return LabelTableState(
        sortAscending: true, sortedColumnIdx: 0, list: labelStatusList);
  }

  void init() {
    state = const LabelTableState(
        sortAscending: true, sortedColumnIdx: 0, list: []);
  }

  void sortList({required int columnIdx, required bool isAsc}) {
    state.list.sort(
      (a, b) {
        switch (columnIdx) {
          // ラベル名
          case 0:
            return isAsc
                ? a.labelId.compareTo(b.labelId)
                : b.labelId.compareTo(a.labelId);
          case 1:
            // 総数
            return isAsc
                ? a.taskIdList.length.compareTo(b.taskIdList.length)
                : b.taskIdList.length.compareTo(a.taskIdList.length);
          default:
            return isAsc
                ? a.labelId.compareTo(b.labelId)
                : b.labelId.compareTo(a.labelId);
        }
      },
    );
  }
}
