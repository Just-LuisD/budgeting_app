import 'package:budgeting_app/domain/entities/budget.dart';
import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/domain/entities/expense.dart';
import 'package:budgeting_app/domain/entities/income.dart';

List<Budget> testBudgets = [
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  ),
  Budget(
    id: 1,
    name: "First Budget",
    income: 20000,
  )
];

List<Expense> testExpesnses1 = [
  Expense(
    title: "expense 1",
    categoryId: 1,
    budgetId: 1,
    amount: 50,
    date: DateTime.now().toString(),
  ),
  Expense(
    title: "expense 1",
    categoryId: 1,
    budgetId: 1,
    amount: 50,
    date: DateTime.now().toString(),
  ),
  Expense(
    title: "expense 1",
    categoryId: 1,
    budgetId: 1,
    amount: 50,
    date: DateTime.now().toString(),
  ),
];

List<Category> testCategories1 = [
  Category(name: "Category 1", spendingLimit: 5000),
  Category(name: "Category 2", spendingLimit: 5000),
  Category(name: "Category 3", spendingLimit: 5000),
  Category(name: "Category 4", spendingLimit: 5000),
  Category(name: "Category 5", spendingLimit: 5000),
];

List<Income> testIncome1 = [
  Income(
    id: 1,
    budgetId: 1,
    title: "Paycheck 1",
    amount: 100,
    date: DateTime.now().toString(),
  ),
  Income(
    id: 2,
    budgetId: 1,
    title: "Paycheck 2",
    amount: 104,
    date: DateTime.now().toString(),
  ),
  Income(
    id: 3,
    budgetId: 1,
    title: "Paycheck 3",
    amount: 10,
    date: DateTime.now().toString(),
  ),
  Income(
    id: 1,
    budgetId: 1,
    title: "Paycheck 1",
    amount: 100,
    date: DateTime.now().toString(),
  ),
  Income(
    id: 2,
    budgetId: 1,
    title: "Paycheck 2",
    amount: 104,
    date: DateTime.now().toString(),
  ),
  Income(
    id: 3,
    budgetId: 1,
    title: "Paycheck 3",
    amount: 10,
    date: DateTime.now().toString(),
  ),
];
