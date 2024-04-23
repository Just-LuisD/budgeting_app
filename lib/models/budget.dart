import 'package:budgeting_app/models/transaction.dart';

class BudgetTemplate {
  late String name;
  late double monthlyIncome;
  late Map<String, double> categoryLimits;

  BudgetTemplate(
      {required this.name,
      required this.monthlyIncome,
      Map<String, double>? initialLimits}) {
    categoryLimits = initialLimits ?? <String, double>{};
  }

  void addCategory(String category, double limit) {
    if (!categoryLimits.containsKey(category)) {
      return;
    }
    categoryLimits[category] = limit;
  }

  void removeCategory(String category) {
    categoryLimits.remove(category);
  }

  void changeLimit(String category, double newLimit) {
    if (!categoryLimits.containsKey(category)) {
      return;
    }
    categoryLimits[category] = newLimit;
  }

  void clear() {
    categoryLimits.clear();
  }
}

class Budget {
  BudgetTemplate? budgetTemplate;
  List<FinancialTransaction>? transactions;
}
