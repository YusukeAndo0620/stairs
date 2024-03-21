import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';
import 'package:stairs/loom/loom_package.dart';

const _uuid = Uuid();

final defaultGitList = [
  LabelModel(
    id: _uuid.v4(),
    labelName: 'Git',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: 'Github',
  ),
  LabelModel(
    id: _uuid.v4(),
    labelName: 'GitLab',
  ),
];
