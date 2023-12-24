import 'package:stairs/feature/project/view/project_edit_modal.dart';
import 'package:stairs/loom/loom_package.dart';

const _kProjectListItemContentPadding =
    EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0);
const _kProjectListItemTitleMaxLine = 1;
const _kProjectIconSize = 32.0;
const _kProjectListItemEditIconSize = 20.0;
const _kProjectListItemBorder = 1.0;

class ProjectListItem extends StatefulWidget {
  const ProjectListItem({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.themeColor,
    required this.onTap,
  });

  final String projectId;
  final String projectName;
  final Color themeColor;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<ProjectListItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return ListTile(
      leading: Icon(
        Icons.table_chart,
        color: widget.themeColor,
        size: _kProjectIconSize,
      ),
      title: Container(
        padding: _kProjectListItemContentPadding,
        child: Text(
          widget.projectName,
          style: theme.textStyleBody,
          maxLines: _kProjectListItemTitleMaxLine,
          overflow: TextOverflow.ellipsis,
          selectionColor: _pressed ? theme.colorFgDisabled : null,
        ),
      ),
      trailing: GestureDetector(
        child: IconButton(
          icon: Icon(
            theme.icons.edit,
          ),
          iconSize: _kProjectListItemEditIconSize,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return ProjectEditModal(projectId: widget.projectId);
              },
            );
          },
        ),
      ),
      shape: Border(
        bottom: BorderSide(
          color: theme.colorFgDefault,
          width: _kProjectListItemBorder,
        ),
      ),
      onFocusChange: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTap: () {
        setState(() {
          _pressed = true;
        });
        widget.onTap();
      },
    );
  }
}
