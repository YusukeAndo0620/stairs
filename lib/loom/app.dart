import 'app_function.dart';
import 'display_contents.dart';
import 'package:stairs/loom/loom_package.dart';

class App extends AppFunction {
  const App();

  @override
  Widget buildMainContents(context) {
    return const DisplayContents(
      screenId: ScreenId.board,
    );
  }
}
