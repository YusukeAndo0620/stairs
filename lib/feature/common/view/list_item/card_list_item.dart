import 'package:stairs/loom/loom_package.dart';

const _kListItemContentPadding = EdgeInsets.all(8.0);
const _kLabelWidth = 150.0;
const _kIconWidth = 20.0;
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
    double? width,
    required String label,
    required Color iconColor,
    required IconData iconData,
    String inputValue = '',
    required String hintText,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    int maxLength = 100,
    bool autoFocus = false,
    required Function(String) onSubmitted,
  }) : this._(
          key: key,
          primaryItem: _PrimaryItem(
            label: label,
            iconColor: iconColor,
            iconData: iconData,
          ),
          secondaryItem: _SecondaryItem(
            width: width,
            widget: TextInput(
              maxLines: maxLines,
              textController: TextEditingController(text: inputValue),
              hintText: hintText,
              inputType: inputType,
              maxLength: maxLength,
              autoFocus: autoFocus,
              onSubmitted: onSubmitted,
            ),
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
          primaryItem: _PrimaryItem(
            label: label,
            iconColor: iconColor,
            iconData: iconData,
          ),
          secondaryItem: _SecondaryItem(
            widget: EventArea(
              itemList: itemList,
              hintText: hintText,
              onTap: onTap,
            ),
          ),
        );

  final String? boardId;
  final Widget primaryItem;
  final Widget? secondaryItem;

  /// Main build
  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorFgDisabled,
            width: _kListBottomBorder,
          ),
        ),
      ),
      padding: _kListItemContentPadding,
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

class _PrimaryItem extends StatelessWidget {
  const _PrimaryItem({
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
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: _kIconWidth,
          ),
          const SizedBox(
            width: _kLabelIconSpaceWidth,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3 -
                _kIconWidth -
                _kLabelIconSpaceWidth,
            child: Text(
              label,
              style: theme.textStyleBody,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryItem extends StatelessWidget {
  const _SecondaryItem({
    this.width,
    required this.widget,
  });
  final double? width;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width ?? MediaQuery.of(context).size.width * 0.6),
      child: widget,
    );
  }
}
