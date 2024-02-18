import 'package:stairs/loom/display_contents.dart';
import 'package:stairs/loom/loom_package.dart';

const _kAppBarTitle = 'Stairs';
const _kAppBarHeight = 40.0;

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({
    super.key,
    required this.screenId,
    this.appBar,
    required this.buildMainContents,
    required this.onTapFooterIcon,
  });

  final ScreenId screenId;
  final AppBar? appBar;
  final Widget buildMainContents;
  final Function(int) onTapFooterIcon;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Scaffold(
      appBar: appBar ??
          AppBar(
            toolbarHeight: _kAppBarHeight,
            backgroundColor: theme.colorBgLayer1,
            title: Text(
              _kAppBarTitle,
              style: theme.textStyleHeading,
            ),
          ),
      body: buildMainContents,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: footerButtons.indexOf(footerButtons
            .firstWhere((element) => element.screenId == screenId)),
        showUnselectedLabels: true,
        selectedItemColor: theme.colorPrimary,
        unselectedItemColor: theme.colorFgDisabled,
        items: [
          for (final footerInfo in footerButtons)
            BottomNavigationBarItem(
              icon: Icon(footerInfo.screenId.iconData(themeData: theme)),
              activeIcon: Icon(footerInfo.screenId.iconData(themeData: theme)),
              label: footerInfo.title,
              tooltip: footerInfo.title,
            ),
        ],
        onTap: (index) => onTapFooterIcon(index),
      ),
    );
  }
}
