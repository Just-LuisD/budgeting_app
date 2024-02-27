const String transactionsTable = 'transactions';

// fields for the sqlite database
class TransactionField {
  static final List<String> colums = [
    id,
    isIncome,
    title,
    category,
    amount,
    date,
    notes,
  ];
  static const String id = '_id';
  static const String isIncome = "isIncome";
  static const String title = 'title';
  static const String category = 'category';
  static const String amount = 'amount';
  static const String date = 'date';
  static const String notes = "notes";
}

class FinancialTransaction {
  final int? id;
  String title;
  bool isIncome;
  String category;
  double amount;
  DateTime? date;
  String? notes;

  FinancialTransaction({
    this.id,
    required this.title,
    required this.isIncome,
    required this.category,
    required this.amount,
    this.date,
    this.notes,
  }) {
    date ??= DateTime.now();
    notes ??= "";
  }

  Map<String, Object?> toJson() {
    return {
      TransactionField.id: id,
      TransactionField.isIncome: isIncome ? 1 : 0,
      TransactionField.title: title,
      TransactionField.category: category,
      TransactionField.amount: amount,
      TransactionField.date: date.toString(),
      TransactionField.notes: notes,
    };
  }

  static FinancialTransaction fromJson(Map<String, Object?> json) {
    int isIncomeInt = json[TransactionField.isIncome] as int;
    bool isIncomeBool = (isIncomeInt == 1);
    return FinancialTransaction(
      id: json[TransactionField.id] as int?,
      isIncome: isIncomeBool,
      title: json[TransactionField.title] as String,
      category: json[TransactionField.category] as String,
      amount: json[TransactionField.amount] as double,
      date: DateTime.parse(json[TransactionField.date] as String),
      notes: json[TransactionField.notes] as String,
    );
  }

  FinancialTransaction copy({
    int? id,
    bool? isIncome,
    String? title,
    String? category,
    double? amount,
    DateTime? date,
    String? notes,
  }) {
    return FinancialTransaction(
      id: id ?? this.id,
      isIncome: isIncome ?? this.isIncome,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}
