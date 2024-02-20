const String transactionsTable = 'transactions';

// fields for the sqlite database
class TransactionField {
  static final List<String> colums = [
    id,
    title,
    category,
    amount,
    date,
  ];
  static const String id = '_id';
  static const String title = 'title';
  static const String category = 'category';
  static const String amount = 'amount';
  static const String date = 'date';
}

class FinancialTransaction {
  final int? id;
  String title;
  String category;
  double amount;
  DateTime? date;

  FinancialTransaction({
    this.id,
    required this.title,
    required this.category,
    required this.amount,
    this.date,
  }) {
    date ??= DateTime.now();
  }

  Map<String, Object?> toJson() {
    return {
      TransactionField.id: id,
      TransactionField.title: title,
      TransactionField.category: category,
      TransactionField.amount: amount,
      TransactionField.date: date.toString(),
    };
  }

  static FinancialTransaction fromJson(Map<String, Object?> json) {
    return FinancialTransaction(
      id: json[TransactionField.id] as int?,
      title: json[TransactionField.title] as String,
      category: json[TransactionField.category] as String,
      amount: json[TransactionField.amount] as double,
      date: DateTime.parse(json[TransactionField.date] as String),
    );
  }

  FinancialTransaction copy({
    int? id,
    String? title,
    String? category,
    double? amount,
    DateTime? date,
  }) {
    return FinancialTransaction(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
