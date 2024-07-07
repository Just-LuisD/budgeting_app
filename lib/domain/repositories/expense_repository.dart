import '../entities/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpensesByBudgetId(int budgetId);
  Future<List<Expense>> getExpensesByCategoryId(int categoryId);
  Future<Expense> getExpenseById(int id);
  Future<int> insertExpense(Expense expense);
  Future<int> updateExpense(Expense expense);
  Future<int> deleteExpense(int id);
}
