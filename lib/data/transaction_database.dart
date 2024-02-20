import 'package:budgeting_app/models/transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDatabase {
  static final TransactionDatabase instance = TransactionDatabase._init();

  static Database? _database;

  TransactionDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase('transactions.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future _createDatabase(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'REAL NOT NULL';
    const stringType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $transactionsTable (
      ${TransactionField.id} $idType,
      ${TransactionField.title} $stringType,
      ${TransactionField.category} $stringType,
      ${TransactionField.amount} $doubleType,
      ${TransactionField.date} $stringType
    )
    ''');
  }

  Future<FinancialTransaction> create(FinancialTransaction transaction) async {
    final db = await instance.database;
    final id = await db.insert(transactionsTable, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<FinancialTransaction> readTransaction(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      transactionsTable,
      columns: TransactionField.colums,
      where: '${TransactionField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FinancialTransaction.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<FinancialTransaction>> readAllTransactions() async {
    final db = await instance.database;
    const orderBy = '${TransactionField.date} ASC';
    final results = await db.query(transactionsTable, orderBy: orderBy);
    return results.map((json) => FinancialTransaction.fromJson(json)).toList();
  }

  Future<int> update(FinancialTransaction transaction) async {
    final db = await instance.database;
    return db.update(
      transactionsTable,
      transaction.toJson(),
      where: '${TransactionField.id} = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      transactionsTable,
      where: '${TransactionField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}
