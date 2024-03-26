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
  Category(
    name: "Paycheck",
    image: "assets/categories/money-bag.png",
    isIncome: true,
  ),
  Category(
    name: "Housing",
    image: "assets/categories/house.png",
    isIncome: false,
  ),
  Category(
    name: "Utilities",
    image: "assets/categories/electric-plug.png",
    isIncome: false,
  ),
  Category(
    name: "Subscriptions",
    image: "assets/categories/calendar.png",
    isIncome: false,
  ),
  Category(
    name: "Groceries",
    image: "assets/categories/shopping-cart.png",
    isIncome: false,
  ),
  Category(
    name: "Shopping",
    image: "assets/categories/shopping-bags.png",
    isIncome: false,
  ),
  Category(
    name: "Miscellaneous",
    image: "assets/categories/asterisk.png",
    isIncome: false,
  ),
  Category(
    name: "Dinning",
    image: "assets/categories/fork-and-knife-with-plate.png",
    isIncome: false,
  ),
  Category(
    name: "Tech",
    image: "assets/categories/mobile-phone.png",
    isIncome: false,
  ),
  Category(
    name: "Savings",
    image: "assets/categories/money-bag.png",
    isIncome: false,
  ),
  Category(
    name: "Travel",
    image: "assets/categories/airplane.png",
    isIncome: false,
  ),
  Category(
    name: "Transportation",
    image: "assets/categories/trolleybus.png",
    isIncome: false,
  ),
  Category(
    name: "Entertainment",
    image: "assets/categories/clapper-board.png",
    isIncome: false,
  ),
  Category(
    name: "Debt",
    image: "assets/categories/chart-decreasing.png",
    isIncome: false,
  ),
  Category(
    name: "Investments",
    image: "assets/categories/chart-increasing.png",
    isIncome: false,
  ),
  Category(
    name: "Gas",
    image: "assets/categories/fuel-pump.png",
    isIncome: false,
  ),
  Category(
    name: "Insurance",
    image: "assets/categories/shield.png",
    isIncome: false,
  ),
  Category(
    name: "Healthcare",
    image: "assets/categories/hospital.png",
    isIncome: false,
  ),
  Category(
    name: "Retirement",
    image: "assets/categories/safe.png",
    isIncome: false,
  ),
  Category(
    name: "Clothing",
    image: "assets/categories/t-shirt.png",
    isIncome: false,
  ),
  Category(
    name: "Fitness",
    image: "assets/categories/dumbbell-large-minimalistic-bold-duotone.png",
    isIncome: false,
  ),
  Category(
    name: "Household Items",
    image: "assets/categories/toilet.png",
    isIncome: false,
  ),
  Category(
    name: "Taxes",
    image: "assets/categories/ballot-box-with-ballot.png",
    isIncome: false,
  ),
  Category(
    name: "Internet",
    image: "assets/categories/wifi.png",
    isIncome: false,
  ),
];
