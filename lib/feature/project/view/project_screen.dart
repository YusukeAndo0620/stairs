import 'package:stairs/feature/project/provider/project_list_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'project_empty_display.dart';
import 'project_list_display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectListState = ref.watch(projectListProvider);

    return SizedBox(
      child: projectListState.when(
        data: (list) {
          return list.isEmpty
              ? const ProjectEmptyDisplay()
              : ProjectListDisplay(
                  projectList: list,
                );
        },
        loading: () => const Align(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Align(child: Text(error.toString())),
      ),
    );
  }
}
