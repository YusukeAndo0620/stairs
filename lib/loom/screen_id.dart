import 'package:stairs/loom/loom_package.dart';

enum ScreenId {
  board,
  status,
  resume,
  account,
}

extension ScreenIdExtension on ScreenId {
  IconData iconData({required LoomThemeData themeData}) {
    switch (this) {
      case ScreenId.board:
        return themeData.icons.board;
      case ScreenId.status:
        return themeData.icons.status;
      case ScreenId.resume:
        return themeData.icons.resume;
      case ScreenId.account:
        return themeData.icons.account;
    }
  }
}
