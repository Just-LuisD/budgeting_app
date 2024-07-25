import 'package:budgeting_app/domain/entities/budget.dart';
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
  )
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
