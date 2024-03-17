import 'package:stairs/loom/loom_package.dart';

const _kListItemContentPadding = EdgeInsets.all(8.0);
const _kIconWidth = 20.0;
const _kLabelIconSpaceWidth = 8.0;
const _kItemSpace = 16.0;
const _kListBottomBorder = 1.0;
const _kNoSelectedName = "-";

enum RowType {
  single,
  double,
}

class CardLstItem extends StatelessWidget {
  const CardLstItem._({
    super.key,
    this.boardId,
    this.rowType = RowType.single,
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

  CardLstItem.inputArea({
    Key? key,
    double? width,
    required String label,
    required Color iconColor,
    required IconData iconData,
    String inputValue = '',
    required String hintText,
    TextInputType inputType = TextInputType.text,
    int maxLines = 3,
    int maxLength = 100,
    bool autoFocus = false,
    required Function(String) onSubmitted,
  }) : this._(
          key: key,
          rowType: RowType.double,
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

  CardLstItem.dropDown({
    Key? key,
    double? width,
    required String label,
    required Color iconColor,
    required IconData iconData,
    required String selectedItemId,
    bool isShownDefaultItem = true,
    required List<LabelModel> itemList,
    required Function(String) onChange,
  }) : this._(
          key: key,
          primaryItem: _PrimaryItem(
            label: label,
            iconColor: iconColor,
            iconData: iconData,
          ),
          secondaryItem: _SecondaryItem(
            widget: _DropDown(
              width: width,
              isShownDefaultItem: isShownDefaultItem,
              selectedItemId: selectedItemId,
              itemList: itemList,
              onChange: (id) => onChange(id),
            ),
          ),
        );
  CardLstItem.labeWithIcon({
    Key? key,
    required double width,
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
          secondaryItem: EventArea(
            width: width,
            itemList: itemList,
            hintText: hintText,
            onTap: onTap,
          ),
        );

  final String? boardId;
  final RowType rowType;
  final Widget primaryItem;
  final Widget? secondaryItem;

  /// Main build
  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      alignment:
          rowType == RowType.single ? Alignment.center : Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorFgDisabled,
            width: _kListBottomBorder,
          ),
        ),
      ),
      padding: _kListItemContentPadding,
      child: rowType == RowType.double
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                primaryItem,
                const SizedBox(
                  height: _kItemSpace,
                ),
                secondaryItem!,
              ],
            )
          : secondaryItem == null
              ? primaryItem
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    primaryItem,
                    const SizedBox(
                      width: _kItemSpace,
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

// ドロップダウン
class _DropDown extends StatelessWidget {
  const _DropDown({
    this.width,
    required this.selectedItemId,
    required this.isShownDefaultItem,
    required this.itemList,
    required this.onChange,
  });
  final double? width;
  final String selectedItemId;
  final bool isShownDefaultItem;
  final List<LabelModel> itemList;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return DropdownButton(
      value: selectedItemId,
      items: [
        if (isShownDefaultItem)
          DropdownMenuItem(
            value: '',
            child: SizedBox(
              width: width ?? MediaQuery.of(context).size.width * 0.4,
              child: Text(
                _kNoSelectedName,
                style: theme.textStyleBody,
              ),
            ),
          ),
        ...itemList
            .map(
              (item) => DropdownMenuItem(
                value: item.id,
                child: SizedBox(
                  width: width ?? MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    item.labelName,
                    style: theme.textStyleBody,
                  ),
                ),
              ),
            )
            .toList(),
      ],
      onChanged: (id) => onChange(id!),
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
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.5,
      child: widget,
    );
  }
}
