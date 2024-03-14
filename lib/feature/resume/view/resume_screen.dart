import 'package:stairs/feature/status/provider/status_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _logger = stairsLogger(name: 'resume_screen');

/// 経歴書
class ResumeScreen extends ConsumerStatefulWidget {
  const ResumeScreen({
    super.key,
    required this.onTapFooterIcon,
  });
  final Function(int) onTapFooterIcon;

  @override
  ConsumerState<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends ConsumerState<ResumeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    final theme = LoomTheme.of(context);
    // 経歴書
    final statusState = ref.watch(statusProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {},
    );
    return statusState.when(
      data: (list) {
        setState(() {
          _tabController = TabController(vsync: this, length: list.length);
        });
        return ScreenWidget(
          screenId: ScreenId.resume,
          appBar: AppBar(
            bottom: TabBar(
              tabAlignment: TabAlignment.center,
              controller: _tabController,
              labelStyle:
                  theme.textStyleFootnote.copyWith(color: theme.colorFgDefault),
              indicatorColor: theme.colorPrimary,
              unselectedLabelColor: theme.colorFgDefault.withOpacity(0.3),
              tabs: <Widget>[
                for (final item in list) ...[
                  Tab(
                    icon: Icon(
                      theme.icons.project,
                      color: item.themeColorModel.color,
                    ),
                    text: item.projectName,
                  ),
                ],
              ],
            ),
          ),
          buildMainContents: TabBarView(
            controller: _tabController,
            children: <Widget>[
              for (final item in list) ...[
                SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ],
          ),
          onTapFooterIcon: (index) => widget.onTapFooterIcon(index),
        );
      },
      loading: () => ScreenWidget(
        screenId: ScreenId.resume,
        appBar: AppBar(),
        buildMainContents: Align(
          child: CircularProgressIndicator(
            color: theme.colorPrimary,
          ),
        ),
        onTapFooterIcon: (index) => widget.onTapFooterIcon(index),
      ),
      error: (error, _) => ScreenWidget(
        screenId: ScreenId.resume,
        appBar: AppBar(),
        buildMainContents: Scaffold(body: Align(child: Text(error.toString()))),
        onTapFooterIcon: (index) => widget.onTapFooterIcon(index),
      ),
    );
  }
}
