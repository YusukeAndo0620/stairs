import 'package:stairs/loom/loom_package.dart';

const _kListItemBorder = 1.0;
const _kCDeleteIconSize = 16.0;
const _kSpaceWidth = 16.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 16.0);

/// Input text area and add link area
class LinkListItem extends StatelessWidget {
  const LinkListItem({
    super.key,
    required this.id,
    required this.inputValue,
    required this.hintText,
    required this.linkHintText,
    this.maxLength = 100,
    this.autoFocus = false,
    required this.linkedWidgets,
    required this.onTextSubmitted,
    required this.onTap,
    required this.onDeleteItem,
  });

  final String id;
  final String inputValue;
  final String hintText;
  final String linkHintText;
  final List<Widget> linkedWidgets;
  final int maxLength;
  final bool autoFocus;
  final Function(String, String) onTextSubmitted;
  final Function(String) onTap;
  final Function(String) onDeleteItem;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: _kContentPadding,
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        border: Border(
          bottom: BorderSide(
            color: theme.colorFgDisabled,
            width: _kListItemBorder,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextInput(
              textController: TextEditingController(text: inputValue),
              hintText: hintText,
              maxLength: maxLength,
              autoFocus: autoFocus,
              onSubmitted: (value) => onTextSubmitted(value, id),
            ),
          ),
          const SizedBox(
            width: _kSpaceWidth,
          ),
          EventArea(
            itemList: linkedWidgets,
            hintText: linkHintText,
            trailingIconData: Icons.expand_more,
            onTap: () => onTap(id),
          ),
          const SizedBox(
            width: _kSpaceWidth,
          ),
          IconButton(
            icon: Icon(
              theme.icons.close,
            ),
            iconSize: _kCDeleteIconSize,
            onPressed: () => onDeleteItem(inputValue),
          ),
        ],
      ),
    );
  }
}
