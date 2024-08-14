import 'package:budgeting_app/domain/entities/income.dart';

abstract class IncomeRepository {
  Future<List<Income>> getBudgetIncome(int budgetId);
  Future<int> insertIncome(Income income);
  Future<int> deleteIncome(int incomeId);
  Future<int> updateIncome(Income income);
  Future<int> getTotalIncome(int budgetId);
}
