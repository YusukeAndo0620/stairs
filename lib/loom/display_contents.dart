import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/feature/common/provider/account_provider.dart';
import 'package:stairs/feature/project/view/project_screen.dart';
import 'package:stairs/feature/status/view/status_screen.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:stairs/feature/common/provider/view/toast_msg_provider.dart';

final _logger = stairsLogger(name: 'display_contents');
const _kAppBarTitle = 'Stairs';
const _kAppBarHeight = 40.0;
const _kFooterButtons = [
  _FooterInfo(
    screenId: ScreenId.board,
    title: 'ボード',
    buildWidget: ProjectScreen(),
  ),
  _FooterInfo(
    screenId: ScreenId.status,
    title: 'ステータス',
    buildWidget: StatusScreen(),
  ),
  _FooterInfo(
    screenId: ScreenId.resume,
    title: '経歴書',
    buildWidget: Text(''),
  ),
  _FooterInfo(
    screenId: ScreenId.account,
    title: 'アカウント',
    buildWidget: Text(''),
  ),
];

class DisplayContents extends ConsumerStatefulWidget {
  const DisplayContents({super.key, required this.screenId});

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

    final theme = LoomTheme.of(context);
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _kAppBarHeight,
        backgroundColor: theme.colorBgLayer1,
        title: Text(
          _kAppBarTitle,
          style: theme.textStyleHeading,
        ),
      ),
      body: _kFooterButtons
          .firstWhere((element) => element.screenId == selectedScreenId)
          .buildWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _kFooterButtons.indexOf(_kFooterButtons
            .firstWhere((element) => element.screenId == selectedScreenId)),
        showUnselectedLabels: true,
        selectedItemColor: theme.colorPrimary,
        unselectedItemColor: theme.colorFgDisabled,
        items: [
          for (final footerInfo in _kFooterButtons)
            BottomNavigationBarItem(
              icon: Icon(footerInfo.screenId.iconData(themeData: theme)),
              activeIcon: Icon(footerInfo.screenId.iconData(themeData: theme)),
              label: footerInfo.title,
              tooltip: footerInfo.title,
            ),
        ],
        onTap: (value) => _onTapIcon(index: value),
      ),
    );
  }

  void _onTapIcon({required int index}) {
    setState(() {
      selectedScreenId = _kFooterButtons[index].screenId;
    });
  }
}

class _FooterInfo {
  const _FooterInfo({
    required this.screenId,
    required this.title,
    required this.buildWidget,
  });
  final ScreenId screenId;
  final String title;
  final Widget buildWidget;
}
