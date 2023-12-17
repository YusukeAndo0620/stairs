// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:stairs/db/old/table_map.dart';
// import 'package:stairs/db/old/table_model.dart';

// class DatabaseHelper {
//   static const _databaseName = "Stairs.db"; // DB名
//   static const _databaseVersion = 1; // スキーマのバージョン指定

//   // DatabaseHelper クラスを定義
//   DatabaseHelper._privateConstructor();
//   // DatabaseHelper._privateConstructor() コンストラクタを使用して生成されたインスタンスを返すように定義
//   // DatabaseHelper クラスのインスタンスは、常に同じものであるという保証
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   // Databaseクラス型のstatic変数_databaseを宣言
//   // クラスはインスタンス化しない
//   static Database? _database;

//   // databaseメソッド定義
//   // 非同期処理
//   Future<Database?> get database async {
//     // _databaseがNULLか判定
//     // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
//     // NULLでない場合、そのまま_database変数を返す
//     // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになります。
//     // このような実装を「遅延初期化 (lazy initialization)」と呼びます。
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }

//   // データベース接続
//   _initDatabase() async {
//     // アプリケーションのドキュメントディレクトリのパスを取得
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     // 取得パスを基に、データベースのパスを生成
//     String path = join(documentsDirectory.path, _databaseName);
//     // データベース接続
//     return await openDatabase(path,
//         version: _databaseVersion,
//         // テーブル作成メソッドの呼び出し
//         onCreate: _onCreate);
//   }

//   // テーブル作成
//   // 引数:dbの名前
//   // 引数:スキーマーのversion
//   // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
//   Future _onCreate(Database db, int version) async {
//     for (final item in tableMap.entries) {
//       String query = 'CREATE TABLE ${item.key}(';
//       for (final col in item.value) {
//         if (col.foreignKeyModel != null) {
//           query += 'FOREIGN KEY (';
//           query += col.columName;
//           query += ') ';
//           query += 'REFERENCES ${col.columName} ';
//           query += '(${col.foreignKeyModel!.targetColumnName}) ';
//           query += 'ON DELETE CASCADE';
//           continue;
//         }
//         query += '${col.columName} ${col.type.text} ';
//         query += col.isPrime ? 'PRIMARY KEY ' : '';
//         query += col.isNotNull ? 'TEXT NOT NULL ' : '';
//         query += ',';
//       }
//       query += ');';
//       await db.execute(query);
//     }
//   }
//   // await db.execute('''
//   //     CREATE TABLE todo_item(
//   //       id INTEGER PRIMARY KEY,
//   //       todo_list_id INTEGER,
//   //       title TEXT,
//   //       is_done BOOLEAN,
//   //       FOREIGN KEY (todo_list_id)
//   //         REFERENCES todo_list (id)
//   //         ON DELETE CASCADE
//   //     );
//   //       ''');

//   // await db.execute('''
//   //       CREATE TABLE $table (
//   //         $columnId INTEGER PRIMARY KEY,
//   //         $columnName TEXT NOT NULL,
//   //         $columnAge INTEGER NOT NULL
//   //       )
//   //       ''');
// }
