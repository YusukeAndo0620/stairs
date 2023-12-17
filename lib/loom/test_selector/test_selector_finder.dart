import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_selector.dart';

extension FindTestSelectors on CommonFinders {
  Finder byTestSelectors(
    String key, {
    Object? value,
    List<Object?>? values,
    TestSelectorPredicate1? predicate1,
    TestSelectorPredicate2? predicate2,
    TestSelectorPredicate3? predicate3,
    TestSelectorPredicate4? predicate4,
    bool skipOffstage = true,
  }) {
    assert(
        (value == null &&
                values == null &&
                predicate1 == null &&
                predicate2 == null &&
                predicate3 == null &&
                predicate4 == null) ||
            (value != null &&
                values == null &&
                predicate1 == null &&
                predicate2 == null &&
                predicate3 == null &&
                predicate4 == null) ||
            (value == null &&
                values != null &&
                predicate1 == null &&
                predicate2 == null &&
                predicate3 == null &&
                predicate4 == null) ||
            (value == null &&
                values == null &&
                predicate1 != null &&
                predicate2 == null &&
                predicate3 == null &&
                predicate4 == null) ||
            (value == null &&
                values == null &&
                predicate1 == null &&
                predicate2 != null &&
                predicate3 == null &&
                predicate4 == null) ||
            (value == null &&
                values == null &&
                predicate1 == null &&
                predicate2 == null &&
                predicate3 != null &&
                predicate4 == null) ||
            (value == null &&
                values == null &&
                predicate1 == null &&
                predicate2 == null &&
                predicate3 == null &&
                predicate4 != null),
        'only one of value, values, or a predicate may be provided.');
    return _TestSelectorFinder(key,
        values: values ??
            predicate1 ??
            predicate2 ??
            predicate3 ??
            predicate4 ??
            (value == null ? null : [value]),
        skipOffstage: skipOffstage);
  }
}

class _TestSelectorFinder extends MatchFinder {
  _TestSelectorFinder(
    this.key, {
    this.values,
    bool skipOffstage = true,
  }) : super(skipOffstage: skipOffstage);

  final String key;
  final dynamic values;

  @override
  String get description {
    if (values is List<Object?>) {
      return 'test selector';
    }
    if (values is TestSelectorPredicate1 ||
        values is TestSelectorPredicate2 ||
        values is TestSelectorPredicate3 ||
        values is TestSelectorPredicate4) {
      return 'test selector $key with predicate';
    }
    return 'test selector $key';
  }

  @override
  bool matches(Element candidate) => candidate.widget.hasTestSelector(
        key,
        values,
      );
}
