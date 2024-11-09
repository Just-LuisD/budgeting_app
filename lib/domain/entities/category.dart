List<String> validTags = ["", "fixed", "savings", "fun"];

class Category {
  final int? id;
  final int? budgetId;
  final String name;
  final int spendingLimit;
  final String? tag;

  Category({
    this.id,
    this.budgetId,
    required this.name,
    required this.spendingLimit,
    String? tag,
  }) : tag = validTags.contains(tag) ? tag : "";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budget_id': budgetId,
      'name': name,
      'spending_limit': spendingLimit,
      'tag': tag,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      budgetId: map['budget_id'],
      name: map['name'],
      spendingLimit: map['spending_limit'],
      tag: map['tag'],
    );
  }

  Category copy({
    int? id,
    int? budgetId,
    String? name,
    int? spendingLimit,
    String? tag,
  }) {
    return Category(
      id: id ?? this.id,
      budgetId: budgetId ?? this.budgetId,
      name: name ?? this.name,
      spendingLimit: spendingLimit ?? this.spendingLimit,
      tag: tag ?? this.tag,
    );
  }
}
