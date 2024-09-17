import 'package:imtihon6/data/model/encom.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EncomService {
  final String dbName = "encom.db";
  final String tableName = "encoms";
  final String idColumn = "id";
  final String moneyColumn = "money";
  final String categoryColumn = "category";
  final String dateColumn = "date";
  final String descriptionColumn = "description";
  late final Database _database;

  EncomService._singleton();

  static final _constructor = EncomService._singleton();

  factory EncomService() {
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
    // create table
    final String query = """
        CREATE TABLE $tableName (
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $moneyColumn TEXT NOT NULL,
          $categoryColumn TEXT NOT NULL,
          $dateColumn TEXT NOT NULL,
          $descriptionColumn TEXT NOT NULL,
        )
""";
    await db.execute(query);
  }

  Future<List<Encom>> get() async {
    final data = await _database.query(tableName);
    List<Encom> encoms = [];
    for (var d in data) {
      final encom = Encom(
        id: d[idColumn] as int,
        money: double.parse(d[moneyColumn] as String),
        category: d[categoryColumn] as String,
        date: DateTime.parse(d[dateColumn] as String),
        description: d[descriptionColumn] as String,
      );

      encoms.add(encom);
    }

    return encoms;
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
    required int encomId,
    required String category,
    required double money,
    required String description,
    required DateTime date,
  }) async {
    await _database.update(tableName, where: "id=$encomId", {
      moneyColumn: money,
      categoryColumn: category,
      dateColumn: date.toString(),
      descriptionColumn: description,
    });
  }

  Future<void> delete(int encomId) async {
    await _database.delete(tableName, where: "id=$encomId");
  }
}
