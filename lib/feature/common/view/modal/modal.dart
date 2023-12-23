import 'package:stairs/loom/loom_package.dart';

const _kModalPadding = EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0);
const _kTrailingWidth = 60.0;
const _kIconSize = 24.0;

class Modal extends StatefulWidget {
  const Modal({
    super.key,
    this.title,
    this.height,
    required this.buildMainContent,
    this.isShowTrailing = true,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSize,
    this.trailingWidth,
    this.onClose,
  });
  final String? title;
  final double? height;
  final Icon? leadingIcon;
  final bool isShowTrailing;
  final Icon? trailingIcon;
  final double? iconSize;
  final double? trailingWidth;
  final Function? onClose;

  final Widget buildMainContent;

  @override
  State<StatefulWidget> createState() => ModalState();
}

class ModalState extends State<Modal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // widget.onClose!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalContent(
      title: widget.title,
      height: widget.height,
      leadingContent: _LeadingContent(
        key: widget.key,
        icon: widget.leadingIcon,
        iconSize: widget.iconSize,
      ),
      mainContent: widget.buildMainContent,
      trailContent: widget.isShowTrailing
          ? _TrailingContent(
              key: widget.key,
              icon: widget.trailingIcon,
              iconSize: widget.iconSize,
              trailingWidth: widget.trailingWidth,
            )
          : null,
    );
  }
}

class ModalContent extends StatelessWidget {
  const ModalContent({
    super.key,
    this.title,
    this.height,
    required this.leadingContent,
    required this.mainContent,
    this.trailContent,
  });
  final String? title;
  final double? height;
  final Widget leadingContent;
  final Widget mainContent;
  final Widget? trailContent;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.95,
      width: MediaQuery.of(context).size.width,
      padding: _kModalPadding,
      decoration: BoxDecoration(
        color: theme.colorBgLayer1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingContent,
              if (title != null)
                Text(
                  title!,
                  style: theme.textStyleTitle,
                ),
              trailContent != null
                  ? trailContent!
                  : const SizedBox(
                      width: 60.0,
                    )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: mainContent,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadingContent extends StatelessWidget {
  const _LeadingContent({
    super.key,
    this.icon,
    this.iconSize,
  });
  final Icon? icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? IconButton(
            icon: icon!,
            iconSize: iconSize ?? _kIconSize,
            onPressed: () => Navigator.pop(context),
          )
        : const SizedBox(
            width: 60.0,
          );
  }
}

class _TrailingContent extends StatelessWidget {
  const _TrailingContent({
    super.key,
    this.icon,
    this.iconSize,
    this.trailingWidth,
  });
  final Icon? icon;
  final double? iconSize;
  final double? trailingWidth;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return SizedBox(
      width: trailingWidth ?? _kTrailingWidth,
      child: IconButton(
        icon: icon ??
            Icon(
              theme.icons.done,
            ),
        color: theme.colorPrimary,
        iconSize: iconSize ?? _kIconSize,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
