import 'dart:ui';
import 'package:stairs/db/provider/database_provider.dart';
import 'package:stairs/loom/loom_package.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta/meta.dart';
import 'package:stairs/loom/app.dart';

const _kAppName = 'Stairs';

final _scaffoldKey = GlobalKey();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

BuildContext get scaffoldContext {
  return _scaffoldKey.currentContext!;
}

void main() {
  // Flutterのウィジェットバインディングの初期化
  WidgetsFlutterBinding.ensureInitialized();
  // デバイスのロケール設定に基づいて初期言語を設定
  // LocaleSettings.useDeviceLocale();
  // デフォルト：日本語にしておく
  LocaleSettings.setLocale(AppLocale.ja);
  runApp(
    TranslationProvider(
      child: const ProviderScope(
        child: AppLaunch(
          app: App(),
        ),
      ),
    ),
  );
}

@sealed
class AppLaunch extends ConsumerStatefulWidget {
  const AppLaunch({
    super.key,
    required this.app,
  });

  final App app;

  @override
  ConsumerState<AppLaunch> createState() => _AppLaunchState();
}

class _AppLaunchState extends ConsumerState<AppLaunch> {
  Widget? _cache;

  @override
  void initState() {
    super.initState();
    widget.app.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cache = null;
  }

  @override
  void didUpdateWidget(covariant AppLaunch oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.app == oldWidget.app, 'App Launch is changed.');
  }

  @override
  void dispose() {
    widget.app.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(databaseProvider);
    return _cache ?? _themeBuilder(context);
  }

  Widget _buildMainContents(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior()
          .copyWith(dragDevices: {...PointerDeviceKind.values}),
      child: MaterialApp(
        title: _kAppName,
        home: widget.app.buildMainContents(context),
        navigatorObservers: <NavigatorObserver>[routeObserver],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocaleUtils.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
      ),
    );
  }

  Widget _themeBuilder(BuildContext context) {
    return LoomTheme.loomTheme(
        key: _scaffoldKey, child: _buildMainContents(context));
  }
}
