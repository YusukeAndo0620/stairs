import 'package:flutter/material.dart';
import '/loom/theme.dart';

const _kAnimatedDuration = Duration(milliseconds: 100);
const _kItemPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kIconWidth = 24.0;
const _kEventAreaMinHeight = 40.0;

class EventArea extends StatefulWidget {
  const EventArea({
    super.key,
    required this.width,
    this.height = _kEventAreaMinHeight,
    required this.hintText,
    required this.itemList,
    this.trailingIconData,
    required this.onTap,
  });

  final double width;
  final double height;
  final String hintText;
  final List<Widget> itemList;
  final IconData? trailingIconData;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _EventAreaState();
}

class _EventAreaState extends State<EventArea> {
  bool _pressed = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _pressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _pressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _pressed = false;
          });
        },
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: _kAnimatedDuration,
          decoration: BoxDecoration(
            color: _pressed ? theme.colorPrimary : null,
          ),
          constraints: BoxConstraints(minHeight: widget.height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: widget.width - _kIconWidth,
                child: widget.itemList.isEmpty
                    ? Text(
                        widget.hintText,
                        style: theme.textStyleFootnote,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    : _Content(
                        itemList: widget.itemList,
                      ),
              ),
              Icon(
                widget.trailingIconData ?? theme.icons.next,
                size: _kIconWidth,
                color: theme.colorPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.itemList,
  });

  final List<Widget> itemList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final item in itemList)
          Padding(
            padding: _kItemPadding,
            child: item,
          ),
      ],
    );
  }
}
