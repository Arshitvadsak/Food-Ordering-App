import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../modals/productModal.dart';

class DBHleper {
  DBHleper._();
  static final DBHleper dbHleper = DBHleper._();

  Database? db;

  final String dbname = "food.db";
  final String TableName = "product";
  final String colId = "id";
  final String colname = "name";
  final String colprice = "price";
  final String colquantity = "quantity";
  final String collike = "like";
  final String colimage = "image";

  Future<void> initDB() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbname);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String query =
          "CREATE TABLE IF NOT EXISTS $TableName($colId INTEGER PRIMARY KEY AUTOINCREMENT ,$colname TEXT,$colprice NUMERIC ,$colimage TEXT,$colquantity INTEGER,$collike TEXT)";

      await db.execute(query);
    });
  }

  Future<int?> inserRecode({required Product data}) async {
    await initDB();

    String query =
        "INSERT INTO $TableName($colname,$colprice,$colimage,$colquantity,$collike)VALUES(?,?,?,?,?)";

    List args = [data.name, data.price, data.image, data.quantity, data.like];
    int? id = await db?.rawInsert(query, args);

    return id;
  }

  Future<List<Product>> fetchAllRecode() async {
    await initDB();
    String query = "SELECT * FROM $TableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Product> allProduct =
        data.map((e) => Product.fromMap(data: e)).toList();

    return allProduct;
  }

  Future<int> deleteRecode({required int id}) async {
    await initDB();
    String query = "DELETE FROM $TableName WHERE $colId=?";
    List aegs = [id];

    return db!.rawDelete(query, aegs);
  }

  Future<int> updateRecode({required Product data, required int id}) async {
    await initDB();
    String query =
        "UPDATE $TableName SET $colname=?, $colprice=?, $colimage=?, $colquantity=? ,$collike=? WHERE $colId=?";
    List args = [
      data.name,
      data.price,
      data.image,
      data.quantity,
      data.like,
      id
    ];
    return await db!.rawUpdate(query, args);
  }

  Future<List<Product>> fetchSearchedRecode({required String data}) async {
    await initDB();

    String query = "SELECT * FROM $TableName WHERE $colname LIKE '%$data%'";

    List<Map<String, dynamic>> ProductData = await db!.rawQuery(query);

    List<Product> allProduct =
        ProductData.map((e) => Product.fromMap(data: e)).toList();

    return allProduct;
  }
}
