import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class LoomIcons with Diagnosticable {
  const LoomIcons({
    required this.project,
    required this.board,
    required this.status,
    required this.resume,
    required this.account,
    required this.group,
    required this.add,
    required this.trash,
    required this.calender,
    required this.share,
    required this.reader,
    required this.developers,
    required this.industry,
    required this.description,
    required this.tool,
    required this.back,
    required this.next,
    required this.close,
    required this.edit,
    required this.done,
  });

  final IconData project;
  final IconData board;
  final IconData status;
  final IconData resume;
  final IconData account;
  final IconData group;
  final IconData add;
  final IconData trash;
  final IconData calender;
  final IconData share;
  final IconData reader;
  final IconData developers;
  final IconData industry;
  final IconData description;
  final IconData tool;
  final IconData back;
  final IconData next;
  final IconData close;
  final IconData edit;
  final IconData done;

  LoomIcons copyWith({
    IconData? project,
    IconData? board,
    IconData? status,
    IconData? resume,
    IconData? account,
    IconData? group,
    IconData? add,
    IconData? trash,
    IconData? calender,
    IconData? share,
    IconData? reader,
    IconData? developers,
    IconData? industry,
    IconData? description,
    IconData? tool,
    IconData? back,
    IconData? next,
    IconData? close,
    IconData? edit,
    IconData? done,
  }) =>
      LoomIcons(
        project: project ?? this.project,
        board: board ?? this.board,
        status: status ?? this.status,
        resume: resume ?? this.resume,
        account: account ?? this.account,
        group: group ?? this.group,
        add: add ?? this.add,
        trash: trash ?? this.trash,
        calender: calender ?? this.calender,
        share: share ?? this.share,
        reader: reader ?? this.reader,
        developers: developers ?? this.developers,
        industry: industry ?? this.industry,
        description: description ?? this.description,
        tool: tool ?? this.tool,
        back: back ?? this.back,
        next: next ?? this.next,
        close: close ?? this.close,
        edit: edit ?? this.edit,
        done: done ?? this.done,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is LoomIcons &&
        other.project == project &&
        other.board == board &&
        other.status == status &&
        other.resume == resume &&
        other.account == account &&
        other.group == group &&
        other.add == add &&
        other.trash == trash &&
        other.share == share &&
        other.reader == reader &&
        other.developers == developers &&
        other.industry == industry &&
        other.description == description &&
        other.tool == tool &&
        other.back == back &&
        other.next == next &&
        other.close == close &&
        other.edit == edit &&
        other.done == done &&
        other.calender == calender;
  }

  @override
  int get hashCode => Object.hashAll([
        project,
        board,
        status,
        resume,
        account,
        group,
        add,
        trash,
        calender,
        share,
        reader,
        developers,
        industry,
        description,
        tool,
        back,
        next,
        close,
        edit,
        done,
      ]);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IconDataProperty('project', project))
      ..add(IconDataProperty('board', board))
      ..add(IconDataProperty('status', status))
      ..add(IconDataProperty('resume', resume))
      ..add(IconDataProperty('account', account))
      ..add(IconDataProperty('group', group))
      ..add(IconDataProperty('add', add))
      ..add(IconDataProperty('trash', trash))
      ..add(IconDataProperty('share', share))
      ..add(IconDataProperty('reader', reader))
      ..add(IconDataProperty('developers', developers))
      ..add(IconDataProperty('industry', industry))
      ..add(IconDataProperty('description', description))
      ..add(IconDataProperty('tool', tool))
      ..add(IconDataProperty('back', back))
      ..add(IconDataProperty('next', next))
      ..add(IconDataProperty('close', close))
      ..add(IconDataProperty('edit', edit))
      ..add(IconDataProperty('done', done))
      ..add(IconDataProperty('calender', calender));
  }
}
