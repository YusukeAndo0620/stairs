import 'package:flutter/material.dart';

@immutable
abstract class AppFunction {
  const AppFunction();

  Widget buildMainContents(BuildContext context);
  void init() {}
  void dispose() {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppFunction && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
