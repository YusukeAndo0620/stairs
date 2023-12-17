import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final Expando<Map<String, List<Object?>>> _selectors = Expando();

const _paramNotProvided = 'paramNotProvided';

typedef TestSelectorPredicate1 = bool Function(Object? value1);

typedef TestSelectorPredicate2 = bool Function(
  Object? value1,
  Object? value2,
);

typedef TestSelectorPredicate3 = bool Function(
  Object? value1,
  Object? value2,
  Object? value3,
);

typedef TestSelectorPredicate4 = bool Function(
  Object? value1,
  Object? value2,
  Object? value3,
  Object? value4,
);

extension TestSelector on Widget {
  Widget testSelector(
    String key, [
    Object? value1 = _paramNotProvided,
    Object? value2 = _paramNotProvided,
    Object? value3 = _paramNotProvided,
    Object? value4 = _paramNotProvided,
  ]) {
    assert(
      () {
        var selectors = _selectors[this];
        if (selectors == null) {
          _selectors[this] = selectors = {};
        }
        selectors[key] = [
          if (!identical(value1, _paramNotProvided)) value1,
          if (!identical(value2, _paramNotProvided)) value2,
          if (!identical(value3, _paramNotProvided)) value3,
          if (!identical(value4, _paramNotProvided)) value4,
        ];
        return true;
      }(),
    );
    return this;
  }

  bool hasTestSelector(String key, [dynamic values]) {
    bool? found;
    assert(
      () {
        final selectors = _selectors[this];
        if (selectors == null) {
          found = false;
          return true;
        }
        if (!selectors.containsKey(key)) {
          found = false;
          return true;
        }
        if (values == null) {
          found = true;
          return true;
        }
        final checkValues = selectors[key]!;
        if (values is List<Object?>) {
          if (values.isEmpty) {
            found = true;
            return true;
          }
          if (values.length > checkValues.length) {
            found = false;
            return true;
          }
          found = listEquals<Object?>(
            values,
            checkValues.sublist(0, values.length),
          );
          return true;
        }
        if (values is TestSelectorPredicate1) {
          found = values(
            checkValues[0],
          );
          return true;
        }
        if (values is TestSelectorPredicate2) {
          found = values(
            checkValues[0],
            checkValues[1],
          );
          return true;
        }
        if (values is TestSelectorPredicate3) {
          found = values(
            checkValues[0],
            checkValues[1],
            checkValues[2],
          );
          return true;
        }
        if (values is TestSelectorPredicate4) {
          found = values(
            checkValues[0],
            checkValues[1],
            checkValues[2],
            checkValues[3],
          );
          return true;
        }
        return true;
      }(),
    );
    if (found != null) {
      return found!;
    }
    throw UnsupportedError('TestSelectors only supported if asserts enabled');
  }
}
