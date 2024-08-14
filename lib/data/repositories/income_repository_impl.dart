import 'package:budgeting_app/data/local_database.dart';
import 'package:budgeting_app/domain/entities/income.dart';
import 'package:budgeting_app/domain/repositories/income_repository.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<List<Income>> getBudgetIncome(int budgetId) async {
    final maps = await dbHelper.getIncome(budgetId);
    return List.generate(maps.length, (i) {
      return Income.fromMap(maps[i]);
    });
  }

  @override
  Future<int> insertIncome(Income income) async {
    return await dbHelper.insertIncome(income.toMap());
  }

  @override
  Future<int> deleteIncome(int incomeId) async {
    return await dbHelper.deleteIncome(incomeId);
  }

  @override
  Future<int> updateIncome(Income income) async {
    return await dbHelper.updateIncome(income.toMap());
  }

  @override
  Future<int> getTotalIncome(int budgetId) async {
    final maps = await dbHelper.getIncome(budgetId);
    int total = 0;
    for (Map<String, dynamic> map in maps) {
      total += map['amount'] as int;
    }
    return total;
  }
}
