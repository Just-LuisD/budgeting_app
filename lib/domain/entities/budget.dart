class Budget {
  final int? id;
  final String name;
  final double income;

  Budget({
    this.id,
    required this.name,
    required this.income,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'income': income,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      name: map['name'],
      income: map['income'],
    );
  }

  Budget copy({
    int? id,
    String? name,
    double? income,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      income: income ?? this.income,
    );
  }
}
