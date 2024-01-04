import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toast_msg_provider.g.dart';

enum MessageType {
  success,
  warning,
  error,
}

class ToastMsgModel {
  const ToastMsgModel({
    required this.isShown,
    required this.type,
    required this.msg,
  });

  final bool isShown;
  final MessageType type;
  final String msg;

  ToastMsgModel copyWith({
    bool? isShown,
    MessageType? type,
    String? msg,
  }) =>
      ToastMsgModel(
        isShown: isShown ?? this.isShown,
        type: type ?? this.type,
        msg: msg ?? this.msg,
      );
}

@riverpod
class ToastMsg extends _$ToastMsg {
  @override
  ToastMsgModel build() => const ToastMsgModel(
        isShown: false,
        type: MessageType.success,
        msg: '',
      );

  void init() {
    state = const ToastMsgModel(
      isShown: false,
      type: MessageType.success,
      msg: '',
    );
  }

  /// トースト表示。
  Future<void> showToast({MessageType? type, String? msg})async {
    state = state.copyWith(isShown: true, type: type, msg: msg);
  }
}
