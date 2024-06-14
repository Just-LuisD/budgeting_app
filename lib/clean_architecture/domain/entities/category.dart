class Category {
  final int id;
  final int budgetId;
  final String name;
  final double? spendingLimit;

  Category(
      {required this.id,
      required this.budgetId,
      required this.name,
      this.spendingLimit});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budget_id': budgetId,
      'name': name,
      'spending_limit': spendingLimit,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      budgetId: map['budget_id'],
      name: map['name'],
      spendingLimit: map['spending_limit'],
    );
  }
}
