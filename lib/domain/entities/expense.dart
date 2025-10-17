class Expense {
  final int? id;
  final String title;
  final int categoryId;
  final int? budgetId;
  final int amount;
  final String date;
  final String? notes;
  final bool isPending;

  Expense({
    this.id,
    required this.title,
    required this.categoryId,
    this.budgetId,
    required this.amount,
    required this.date,
    this.notes,
    required this.isPending,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category_id': categoryId,
      'budget_id': budgetId,
      'amount': amount,
      'date': date,
      'notes': notes,
      'is_pending': isPending ? 1 : 0,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      categoryId: map['category_id'],
      budgetId: map['budget_id'],
      amount: map['amount'],
      date: map['date'],
      notes: map['notes'],
      isPending: map['is_pending'] == 1,
    );
  }

  Expense copy({
    int? id,
    String? title,
    int? categoryId,
    int? budgetId,
    int? amount,
    String? date,
    String? notes,
    bool? isPending,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      budgetId: budgetId ?? this.budgetId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      isPending: isPending ?? this.isPending,
    );
  }
}
