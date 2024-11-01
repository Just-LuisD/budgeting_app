import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Map<int, List<String>> migrationScripts = {
  1: [
    '''
      CREATE TABLE Budgets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        income INTEGER NOT NULL
      )
    ''',
    '''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        budget_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        spending_limit INTEGER NOT NULL,
        FOREIGN KEY (budget_id) REFERENCES Budgets(id) ON DELETE CASCADE
      )
    ''',
    '''
      CREATE TABLE Expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        budget_id INTEGER NOT NULL,
        amount INTEGER NOT NULL,
        date TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
        FOREIGN KEY (budget_id) REFERENCES Budgets(id) ON DELETE CASCADE
      )
    ''',
    '''
        CREATE TABLE Income (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          budget_id INTEGER NOT NULL,
          amount INTEGER NOT NULL,
          date TEXT NOT NULL,
          FOREIGN KEY (budget_id) REFERENCES Budgets(id) ON DELETE CASCADE
        )
      ''',
  ],
  2: [
    "ALTER TABLE Categories ADD tag TEXT",
  ],
};

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
    int latestVersion = migrationScripts.length;

    return await openDatabase(
      path,
      version: latestVersion,
      onCreate: (Database db, int version) async {
        print("WE ARE RUNNING ON CREATE");
        for (int idx = 1; idx <= latestVersion; idx++) {
          for (String script in migrationScripts[idx]!) {
            print("Running: \n$script");
            await db.execute(script);
          }
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("WE ARE RUNNING ON UPGRADE");
        for (int idx = oldVersion + 1; idx <= latestVersion; idx++) {
          for (String script in migrationScripts[idx]!) {
            print("Running: \n$script");
            await db.execute(script);
          }
        }
      },
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
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

  // Insert a new income
  Future<int> insertIncome(Map<String, dynamic> income) async {
    Database db = await database;
    return await db.insert("Income", income);
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

  // Query all income for a specific budget
  Future<List<Map<String, dynamic>>> getIncome(int budgetId) async {
    Database db = await database;
    return await db.query(
      "Income",
      where: 'budget_id = ?',
      whereArgs: [budgetId],
    );
  }

  Future<List<Map<String, dynamic>>> getExpensesByBudgetId(int budgetId) async {
    Database db = await database;
    return await db
        .query('Expenses', where: 'budget_id = ?', whereArgs: [budgetId]);
  }

  Future<Map<String, dynamic>> getBudget(int id) async {
    final db = await database;
    final maps = await db.query('Budgets', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Map<String, dynamic>> getCategory(int id) async {
    final db = await database;
    final maps = await db.query('Categories', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      throw Exception('ID $id not found');
    }
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

// Delete an expense
  Future<int> deleteIncome(int incomeId) async {
    Database db = await database;
    return await db.delete('Income', where: 'id = ?', whereArgs: [incomeId]);
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

  // Update an expense
  Future<int> updateIncome(Map<String, dynamic> income) async {
    Database db = await database;
    int id = income['id'];
    return await db.update('Income', income, where: 'id = ?', whereArgs: [id]);
  }

  // Close the database
  Future close() async {
    Database db = await database;
    db.close();
  }
}
