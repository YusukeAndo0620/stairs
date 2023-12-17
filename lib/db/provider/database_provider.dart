import '../database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@riverpod
class Database extends _$Database {
  @override
  StairsDatabase build() => StairsDatabase();

  void init({required StairsDatabase db}) {
    state = db;
  }
}
