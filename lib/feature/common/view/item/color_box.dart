import 'package:flutter/material.dart' hide Theme;

const _kColorSize = 30.0;
const _kColorRadius = 20.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);

/// カラーボックス(円形)
class ColorBox extends StatelessWidget {
  const ColorBox({
    super.key,
    this.size = _kColorSize,
    required this.color,
  });
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: _kContentPadding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(_kColorRadius)),
      ),
    );
  }
}
