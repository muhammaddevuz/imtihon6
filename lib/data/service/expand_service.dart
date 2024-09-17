import 'package:imtihon6/data/model/expand.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ExpandService {
  final String dbName = "expand.db";
  final String tableName = "expand";
  final String idColumn = "id";
  final String moneyColumn = "money";
  final String categoryColumn = "category";
  final String dateColumn = "date";
  final String descriptionColumn = "description";
  late final Database _database;

  ExpandService._singleton();

  static final _constructor = ExpandService._singleton();

  factory ExpandService() {
    return _constructor;
  }

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$dbName";
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    final String query = """
        CREATE TABLE $tableName (
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $moneyColumn TEXT NOT NULL,
          $categoryColumn TEXT NOT NULL,
          $dateColumn TEXT NOT NULL,
          $descriptionColumn TEXT NOT NULL
        )
""";
    await db.execute(query);
  }

  Future<List<Expand>> get() async {
    print("++$_database");
    final data = await _database.query(tableName);
    print("-------");
    List<Expand> expands = [];
    for (var d in data) {
      final expand = Expand(
        id: d[idColumn] as int,
        money: double.parse(d[moneyColumn] as String),
        category: d[categoryColumn] as String,
        date: DateTime.parse(d[dateColumn] as String),
        description: d[descriptionColumn] as String,
      );

      expands.add(expand);
    }

    return expands;
  }

  Future<void> insert({
    required String category,
    required double money,
    required String description,
    required DateTime date,
  }) async {
    await _database.insert(tableName, {
      moneyColumn: money,
      categoryColumn: category,
      dateColumn: date.toString(),
      descriptionColumn: description,
    });
  }

  Future<void> edit({
    required int expandId,
    required String category,
    required double money,
    required String description,
    required DateTime date,
  }) async {
    await _database.update(tableName, where: "id=$expandId", {
      moneyColumn: money,
      categoryColumn: category,
      dateColumn: date.toString(),
      descriptionColumn: description,
    });
  }

  Future<void> delete(int expandId) async {
    await _database.delete(tableName, where: "id=$expandId");
  }
}
