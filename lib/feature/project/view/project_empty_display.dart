import 'package:stairs/feature/project/view/project_edit_modal.dart';
import 'package:stairs/loom/loom_package.dart';

const _kProjectEmptyTxt = '表示可能なボードがありません。\nボードを作成してください。';

const _kProjectEmptyContentPadding =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);

class ProjectEmptyDisplay extends StatelessWidget {
  const ProjectEmptyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: _kProjectEmptyContentPadding,
          child: Text(
            _kProjectEmptyTxt,
            style: theme.textStyleBody,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
            onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const ProjectEditModal(
                      projectId: '',
                    );
                  },
                ),
            icon: Icon(
              theme.icons.add,
            )),
      ],
    );
  }
}
