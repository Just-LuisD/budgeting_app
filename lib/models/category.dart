class Category {
  final String name;
  final String image;
  final bool isIncome;

  const Category({
    required this.name,
    required this.image,
    required this.isIncome,
  });
}

const defaultCategories = [
  Category(name: "Paycheck", image: "", isIncome: true),
  Category(name: "Rent", image: "", isIncome: false),
  Category(name: "Bills & Fees", image: "", isIncome: false),
  Category(name: "Subscriptions", image: "", isIncome: false),
  Category(name: "Groceries", image: "", isIncome: false),
  Category(name: "Gaming", image: "", isIncome: false),
  Category(name: "Shopping", image: "", isIncome: false),
  Category(name: "Miscellaneous", image: "", isIncome: false),
  Category(name: "Dinning", image: "", isIncome: false),
  Category(name: "Technology", image: "", isIncome: false),
  Category(name: "Savings", image: "", isIncome: false),
  Category(name: "Travel", image: "", isIncome: false),
  Category(name: "Transit", image: "", isIncome: false),
  Category(name: "Entertainment", image: "", isIncome: false),
];

Map categories = {
  "Paycheck": "assets/categories/money-bag.png",
  "Housing": "assets/categories/house.png",
  "Utilities": "assets/categories/electric-plug.png",
  "Subscriptions": "assets/categories/calendar.png",
  "Debt": "assets/categories/chart-decreasing.png",
  "Investments": "assets/categories/chart-increasing.png",
  "Transportation": "assets/categories/trolleybus.png",
  "Gas": "assets/categories/fuel-pump.png",
  "Insurance": "assets/categories/shield.png",
  "Healthcare": "assets/categories/hospital.png",
  "Groceries": "assets/categories/shopping-cart.png",
  "Savings": "assets/categories/money-bag.png",
  "Retirement": "assets/categories/safe.png",
  "Miscellaneous": "assets/categories/asterisk.png",
  "Entertainment": "assets/categories/clapper-board.png",
  "Travel": "assets/categories/airplane.png",
  "Clothing": "assets/categories/t-shirt.png",
  "Shopping": "assets/categories/shopping-bags.png",
  "Fitness": "assets/categories/dumbbell-large-minimalistic-bold-duotone.png",
  "Tech": "assets/categories/mobile-phone.png",
  "Restaurants": "assets/categories/fork-and-knife-with-plate.png",
  "Household Items": "assets/categories/toilet.png",
};
