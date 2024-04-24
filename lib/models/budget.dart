import 'package:budgeting_app/models/transaction.dart';

const String budgetTemplatesTable = 'budget_templates';

class BudgetTemplateField {
  static final List<String> columns = [
    id,
    name,
    income,
    categoryLimits,
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String income = 'income';
  static const String categoryLimits = "category_limits";
}

class BudgetTemplate {
  final int? id;
  String name;
  double income;
  Map<String, double> categoryLimits;

  BudgetTemplate({
    this.id,
    required this.name,
    required this.income,
    required this.categoryLimits,
  });

  BudgetTemplate copy({
    int? id,
    String? name,
    double? income,
    Map<String, double>? categoryLimits,
  }) {
    return BudgetTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      income: income ?? this.income,
      categoryLimits: categoryLimits ?? this.categoryLimits,
    );
  }
}

class Budget {
  BudgetTemplate? budgetTemplate;
  List<FinancialTransaction>? transactions;
}
