import 'package:stairs/feature/project/provider/project_list_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'project_empty_display.dart';
import 'project_list_display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key, required this.onTapFooterIcon});
  final Function(int) onTapFooterIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectListState = ref.watch(projectListProvider);
    final theme = LoomTheme.of(context);

    return ScreenWidget(
      screenId: ScreenId.board,
      buildMainContents: SizedBox(
        child: projectListState.when(
          data: (list) {
            return list.isEmpty
                ? const ProjectEmptyDisplay()
                : ProjectListDisplay(
                    projectList: list,
                  );
          },
          loading: () => Align(
            child: CircularProgressIndicator(
              color: theme.colorPrimary,
            ),
          ),
          error: (error, _) => Align(child: Text(error.toString())),
        ),
      ),
      onTapFooterIcon: (index) => onTapFooterIcon(index),
    );
  }
}
