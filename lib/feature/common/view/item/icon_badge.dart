import 'package:badges/badges.dart';
import 'package:stairs/loom/loom_package.dart';

///丸型アイコンバッチ
class IconBadge extends StatefulWidget {
  const IconBadge({
    super.key,
    required this.icon,
    required this.badgeColor,
    required this.tappedColor,
    required this.count,
    required this.onTap,
  });
  final Icon icon;
  final Color badgeColor;
  final Color tappedColor;
  final int count;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _IconBadge();
}

class _IconBadge extends State<IconBadge> {
  bool _pressed = false;
  final itemKey = GlobalKey<_IconBadge>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return GestureDetector(
      key: itemKey,
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
      child: Badge(
        position: BadgePosition.topEnd(),
        badgeStyle: BadgeStyle(badgeColor: widget.badgeColor),
        badgeContent: Text(
          widget.count.toString(),
          style: theme.textStyleBody,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pressed ? widget.tappedColor.withOpacity(0.7) : null,
          ),
          child: DottedBorder(
            borderType: BorderType.Circle,
            color: theme.colorDisabled,
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
