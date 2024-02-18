import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/project/view/project_screen.dart';
import 'package:stairs/feature/status/view/status_screen.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:stairs/feature/common/provider/view/toast_msg_provider.dart';

final _logger = stairsLogger(name: 'display_contents');

const footerButtons = [
  FooterInfo(
    screenId: ScreenId.board,
    title: 'ボード',
  ),
  FooterInfo(
    screenId: ScreenId.status,
    title: 'ステータス',
  ),
  FooterInfo(
    screenId: ScreenId.resume,
    title: '経歴書',
  ),
  FooterInfo(
    screenId: ScreenId.account,
    title: 'アカウント',
  ),
];

class DisplayContents extends ConsumerStatefulWidget {
  const DisplayContents({
    super.key,
    required this.screenId,
  });

  final ScreenId screenId;
  @override
  ConsumerState<DisplayContents> createState() => _DisplayContentsState();
}

class _DisplayContentsState extends ConsumerState<DisplayContents> {
  var selectedScreenId = ScreenId.board;

  @override
  void initState() {
    super.initState();
    selectedScreenId = widget.screenId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logger.i('画面表示 {selectedScreenId: $selectedScreenId}');
    // アカウント情報取得
    ref.watch(accountProvider(db: ref.watch(databaseProvider)));

    // トーストメッセージハンドリング
    ref.listen<ToastMsgModel>(
      toastMsgProvider, // 購読対象のProviderを指定
      (previous, current) {
        if (!previous!.isShown && current.isShown) {
          _logger.d('トースト表示 実施');
          _logger.d('type: ${current.type}, msg: ${current.msg}');
          toastification.show(
            context: context,
            title: current.msg,
            style: ToastificationStyle.minimal,
            type: current.type == MessageType.success
                ? ToastificationType.success
                : current.type == MessageType.warning
                    ? ToastificationType.warning
                    : ToastificationType.error,
            autoCloseDuration: const Duration(milliseconds: 3000),
            showProgressBar: false,
            alignment: Alignment.topCenter,
            dragToClose: true,
          );
          _logger.d('トースト表示 終了');
          Future.delayed(const Duration(milliseconds: 3000)).then(
            (value) => ref.watch(toastMsgProvider.notifier).init(),
          );
        }
      },
      // `onError` で何らかのエラーハンドリングが可能（任意）
      onError: (error, stackTrace) => debugPrint('$error'),
    );
    return switch (selectedScreenId) {
      ScreenId.board => ProjectScreen(
          onTapFooterIcon: (index) => _onTapIcon(index: index),
        ),
      ScreenId.status =>
        StatusScreen(onTapFooterIcon: (index) => _onTapIcon(index: index)),
      ScreenId.resume => ScreenWidget(
          screenId: ScreenId.resume,
          buildMainContents: const SizedBox(),
          onTapFooterIcon: (index) => _onTapIcon(index: index),
        ),
      ScreenId.account => ScreenWidget(
          screenId: ScreenId.account,
          buildMainContents: const SizedBox(),
          onTapFooterIcon: (index) => _onTapIcon(index: index),
        ),
    };
  }

  void _onTapIcon({required int index}) {
    setState(() {
      selectedScreenId = footerButtons[index].screenId;
    });
  }
}

class FooterInfo {
  const FooterInfo({
    required this.screenId,
    required this.title,
  });
  final ScreenId screenId;
  final String title;
}
