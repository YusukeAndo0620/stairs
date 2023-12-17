import 'package:stairs/loom/loom_package.dart';

const _kListItemContentPadding = EdgeInsets.all(8.0);
const _kListItemPadding = EdgeInsets.only(bottom: 16.0);
const _kLabelWidth = 150.0;
const _kLabelIconSpaceWidth = 8.0;
const _kItemSpaceWidth = 16.0;
const _kListBottomBorder = 1.0;

class CardLstItem extends StatelessWidget {
  const CardLstItem._({
    super.key,
    this.boardId,
    required this.primaryItem,
    this.secondaryItem,
  }) : super();

  CardLstItem.header({
    Key? key,
    required String title,
    required Color bgColor,
  }) : this._(
          key: key,
          primaryItem: _Header(
            title: title,
            bgColor: bgColor,
          ),
        );

  CardLstItem.input({
    Key? key,
    required Icon icon,
    String inputValue = '',
    required String hintText,
    TextInputType inputType = TextInputType.text,
    int maxLength = 100,
    bool autoFocus = false,
    required Function(String) onSubmitted,
  }) : this._(
          key: key,
          primaryItem: TextInput(
            icon: icon,
            textController: TextEditingController(text: inputValue),
            hintText: hintText,
            inputType: inputType,
            maxLength: maxLength,
            autoFocus: autoFocus,
            onSubmitted: onSubmitted,
          ),
        );

  CardLstItem.labeWithIcon({
    Key? key,
    required String label,
    required Color iconColor,
    required IconData iconData,
    required String hintText,
    required List<Widget> itemList,
    required VoidCallback onTap,
  }) : this._(
          key: key,
          primaryItem: _LabelWithIcon(
            label: label,
            iconColor: iconColor,
            iconData: iconData,
          ),
          secondaryItem: EventArea(
            itemList: itemList,
            hintText: hintText,
            onTap: onTap,
          ),
        );

  final String? boardId;
  final Widget primaryItem;
  final Widget? secondaryItem;

  /// Main build
  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Padding(
      padding: _kListItemContentPadding,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorFgDisabled,
              width: _kListBottomBorder,
            ),
          ),
        ),
        child: Padding(
          padding: _kListItemPadding,
          child: secondaryItem == null
              ? primaryItem
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    primaryItem,
                    const SizedBox(
                      width: _kItemSpaceWidth,
                    ),
                    secondaryItem!,
                  ],
                ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.bgColor,
  });
  final String title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      color: bgColor,
      width: double.infinity,
      padding: _kListItemContentPadding,
      child: Text(
        title,
        style: theme.textStyleTitle,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return SizedBox(
      width: _kLabelWidth,
      child: Text(
        label,
        style: theme.textStyleBody,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _LabelWithIcon extends StatelessWidget {
  const _LabelWithIcon({
    required this.label,
    required this.iconColor,
    required this.iconData,
  });
  final String label;
  final Color iconColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return SizedBox(
      width: _kLabelWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              iconData,
              color: iconColor,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: _kLabelIconSpaceWidth,
          ),
          Text(
            label,
            style: theme.textStyleBody,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
