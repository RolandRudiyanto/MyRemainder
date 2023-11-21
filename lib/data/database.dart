import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:uts2/data/cart.dart';
import 'data.dart';

class DBHelper{


  static Database? _db;

  Future<Database?> get database async {
    if (_db!= null) {
      return _db;
    }

    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'your_database.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE  notes(id INTEGER PRIMARY KEY AUTOINCREMENT, tgl TEXT NOT NULL, judul TEXT NOT NULL, desc TEXT NOT NULL)
        ''');

        await db.execute('''
             CREATE TABLE shopping_items (
                    id_belanja INTEGER PRIMARY KEY AUTOINCREMENT,
                    nama_produk TEXT NOT NULL,
                    img_produk TEXT NOT NULL,
                    harga_produk REAL NOT NULL,
                    quantity INTEGER NOT NULL,
                    complete INTEGER DEFAULT 0,
                    id INTEGER,
                    FOREIGN KEY (id) REFERENCES notes(id)
                  )
        ''');
      },
    );
  }
  Future<int> insertNote(Data data) async {
    final db = await database;
    return await db!.insert('notes', data.toMap());
  }

  Future<List<Data>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('notes');
    return List.generate(maps.length, (i) {
      return Data(
        id: maps[i]['id'],
        tgl: maps[i]['tgl'],
        judul: maps[i]['judul'],
        desc: maps[i]['desc'],
      );
    });

  }

  Future<int> insertShoppingItem(Cart cart) async {
    final db = await database;
    return await db!.insert('shopping_items', cart.toMap());
  }

  Future<List<Cart>> getShoppingItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('shopping_items');
    return List.generate(maps.length, (i) {
      return Cart(
          id_belanja:maps[i]['id_belanja'] ,
          nama_produk: maps[i]['nama_produk'],
          img_produk: maps[i]['img_produk'],
          harga_produk: maps[i]['harga_produk'],
          quantity: maps[i]['quantity'],
          id: maps[i]['id']
      );
    });
  }

  Future<int> delete(int id) async{
    var dbClient =await database;
    return await dbClient!.delete('notes',where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    final dbClient = await database;
    return await dbClient!.delete('shopping_items', where: 'id_belanja = ?', whereArgs: [id]);
  }

  Future<double> calculateTotalShopping() async {
    final db = await database;

    if (db != null) {
      final result = await db.rawQuery('SELECT SUM(harga_produk) AS total FROM shopping_items');

      if (result.isNotEmpty) {
        final total = result.first['total'] as double;
        return total;
      }
    }

    // Kembalikan nilai default jika terdapat kesalahan atau data kosong
    return 0.0;
  }
  //
  // Future<int> update(Data data ) async{
  //   var dbClient = await db;
  //   return await dbClient!.update('notes', data.toMap(),where: 'id = ?', whereArgs: [data.id]);
  // }

}