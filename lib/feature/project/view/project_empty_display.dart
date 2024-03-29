import 'package:stairs/feature/project/view/project_edit_display.dart';
import 'package:stairs/loom/loom_package.dart';

const _kProjectEmptyContentPadding =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);

class ProjectEmptyDisplay extends StatelessWidget {
  const ProjectEmptyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    final t = Translations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: _kProjectEmptyContentPadding,
          child: Text(
            t.project.projectEmpty,
            style: theme.textStyleBody,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
            onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProjectEditDisplay(
                        projectId: '',
                      );
                    },
                  ),
                ),
            icon: Icon(
              theme.icons.add,
            )),
      ],
    );
  }
}
