class Income {
  final int? id;
  final String title;
  final int? budgetId;
  final int amount;
  final String date;

  Income({
    this.id,
    required this.title,
    this.budgetId,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'budget_id': budgetId,
      'amount': amount,
      'date': date,
    };
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      title: map['title'],
      budgetId: map['budget_id'],
      amount: map['amount'],
      date: map['date'],
    );
  }

  Income copy({
    int? id,
    String? title,
    int? budgetId,
    int? amount,
    String? date,
  }) {
    return Income(
      id: id ?? this.id,
      title: title ?? this.title,
      budgetId: budgetId ?? this.budgetId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
