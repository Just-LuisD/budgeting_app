import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'budget.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Budgets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        income REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        budget_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        spending_limit REAL,
        FOREIGN KEY (budget_id) REFERENCES Budgets(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE Expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
      )
    ''');
  }

  // Insert a new budget
  Future<int> insertBudget(Map<String, dynamic> budget) async {
    Database db = await database;
    return await db.insert('Budgets', budget);
  }

  // Insert a new category
  Future<int> insertCategory(Map<String, dynamic> category) async {
    Database db = await database;
    return await db.insert('Categories', category);
  }

  // Insert a new expense
  Future<int> insertExpense(Map<String, dynamic> expense) async {
    Database db = await database;
    return await db.insert('Expenses', expense);
  }

  // Query all budgets
  Future<List<Map<String, dynamic>>> getBudgets() async {
    Database db = await database;
    return await db.query('Budgets');
  }

  // Query all categories for a specific budget
  Future<List<Map<String, dynamic>>> getCategories(int budgetId) async {
    Database db = await database;
    return await db
        .query('Categories', where: 'budget_id = ?', whereArgs: [budgetId]);
  }

  // Query all expenses for a specific category
  Future<List<Map<String, dynamic>>> getExpenses(int categoryId) async {
    Database db = await database;
    return await db
        .query('Expenses', where: 'category_id = ?', whereArgs: [categoryId]);
  }

  // Delete a budget
  Future<int> deleteBudget(int budgetId) async {
    Database db = await database;
    return await db.delete('Budgets', where: 'id = ?', whereArgs: [budgetId]);
  }

  // Delete a category
  Future<int> deleteCategory(int categoryId) async {
    Database db = await database;
    return await db
        .delete('Categories', where: 'id = ?', whereArgs: [categoryId]);
  }

  // Delete an expense
  Future<int> deleteExpense(int expenseId) async {
    Database db = await database;
    return await db.delete('Expenses', where: 'id = ?', whereArgs: [expenseId]);
  }

  // Update a budget
  Future<int> updateBudget(Map<String, dynamic> budget) async {
    Database db = await database;
    int id = budget['id'];
    return await db.update('Budgets', budget, where: 'id = ?', whereArgs: [id]);
  }

  // Update a category
  Future<int> updateCategory(Map<String, dynamic> category) async {
    Database db = await database;
    int id = category['id'];
    return await db
        .update('Categories', category, where: 'id = ?', whereArgs: [id]);
  }

  // Update an expense
  Future<int> updateExpense(Map<String, dynamic> expense) async {
    Database db = await database;
    int id = expense['id'];
    return await db
        .update('Expenses', expense, where: 'id = ?', whereArgs: [id]);
  }

  // Close the database
  Future close() async {
    Database db = await database;
    db.close();
  }
}
