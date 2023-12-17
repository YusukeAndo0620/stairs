import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class LoomIcon with Diagnosticable {
  const LoomIcon({
    required this.color,
    required this.icon,
    required this.width,
  });

  final Color color;
  final IconData icon;
  final double width;

  LoomIcon copyWith({
    Color? color,
    IconData? icon,
    double? width,
  }) =>
      LoomIcon(
          color: color ?? this.color,
          icon: icon ?? this.icon,
          width: width ?? this.width);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is LoomIcon &&
        other.color == color &&
        other.icon == icon &&
        other.width == width;
  }

  @override
  int get hashCode => Object.hash(color, icon, width);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty(('icon'), icon))
      ..add(DiagnosticsProperty(('width'), width));
  }
}

@immutable
class LoomIconStyle with Diagnosticable {
  const LoomIconStyle({
    required this.color,
    required this.width,
  });

  final Color color;
  final double width;

  LoomIconStyle copyWith({
    Color? color,
    double? width,
  }) =>
      LoomIconStyle(color: color ?? this.color, width: width ?? this.width);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is LoomIconStyle &&
        other.color == color &&
        other.width == width;
  }

  @override
  int get hashCode => Object.hash(color, width);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty(('width'), width));
  }
}
