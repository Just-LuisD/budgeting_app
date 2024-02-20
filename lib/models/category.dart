class Category {
  final String name;
  final String icon;
  final bool isIncome;

  const Category({
    required this.name,
    required this.icon,
    required this.isIncome,
  });
}

const defaultCategories = [
  Category(name: "Paycheck", icon: "", isIncome: true),
  Category(name: "Rent", icon: "", isIncome: false),
  Category(name: "Bills & Fees", icon: "", isIncome: false),
  Category(name: "Subscriptions", icon: "", isIncome: false),
  Category(name: "Groceries", icon: "", isIncome: false),
  Category(name: "Gaming", icon: "", isIncome: false),
  Category(name: "Shopping", icon: "", isIncome: false),
  Category(name: "Miscellaneous", icon: "", isIncome: false),
  Category(name: "Dinning", icon: "", isIncome: false),
  Category(name: "Technology", icon: "", isIncome: false),
  Category(name: "Savings", icon: "", isIncome: false),
  Category(name: "Travel", icon: "", isIncome: false),
  Category(name: "Transit", icon: "", isIncome: false),
  Category(name: "Entertainment", icon: "", isIncome: false),
];
