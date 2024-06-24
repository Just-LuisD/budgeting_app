class Expense {
  final int? id;
  final String title;
  final int categoryId;
  final double amount;
  final String date;
  final String? notes;

  Expense({
    this.id,
    required this.title,
    required this.categoryId,
    required this.amount,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category_id': categoryId,
      'amount': amount,
      'date': date,
      'notes': notes,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      categoryId: map['category_id'],
      amount: map['amount'],
      date: map['date'],
      notes: map['notes'],
    );
  }

  Expense copy({
    int? id,
    String? title,
    int? categoryId,
    double? amount,
    String? date,
    String? notes,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}
