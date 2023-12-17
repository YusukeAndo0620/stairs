import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'loom_theme_data.dart';
import 'package:flutter/foundation.dart';
import 'loom.dart';

@sealed
abstract class LoomTheme {
  const LoomTheme._();

  static Widget loomTheme({
    Key? key,
    required Widget child,
    Curve curve = Curves.linear,
    Duration duration = const Duration(milliseconds: 100),
    VoidCallback? onEnd,
  }) =>
      _AnimatedTheme(
        key: key,
        data: Loom.themeDataFor,
        curve: curve,
        duration: duration,
        onEnd: onEnd,
        child: child,
      );

  static LoomThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritedTheme>()!.data;
}

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    required this.data,
    required super.child,
  });

  final LoomThemeData data;

  @override
  bool updateShouldNotify(_InheritedTheme old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty(('data'), data));
  }
}

class _AnimatedTheme extends ImplicitlyAnimatedWidget {
  const _AnimatedTheme({
    super.key,
    required this.data,
    required super.curve,
    required super.duration,
    required super.onEnd,
    required this.child,
  });

  final LoomThemeData data;
  final Widget child;

  @override
  _AnimatedThemeState createState() => _AnimatedThemeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty(('data'), data));
  }
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<_AnimatedTheme> {
  LoomThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
      _data,
      widget.data,
      (dynamic value) => LoomThemeDataTween(begin: value as LoomThemeData),
    ) as LoomThemeDataTween?;
  }

  @override
  Widget build(BuildContext context) => _InheritedTheme(
        data: _data!.evaluate(animation),
        child: widget.child,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty(
      ('data'),
      _data,
      showName: false,
      defaultValue: null,
    ));
  }
}
