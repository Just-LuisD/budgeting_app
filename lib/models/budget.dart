import 'package:budgeting_app/models/transaction.dart';

class BudgetTemplate {
  late Map<String, double> categoryLimits;
  Map<String, List<String>>? superCategories;

  BudgetTemplate({Map<String, double>? initialLimits}) {
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
