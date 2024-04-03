import 'package:flutter/material.dart';

class Category {
  final String name;
  final String image;
  final bool isIncome;
  final Color color;

  const Category({
    required this.name,
    required this.image,
    required this.isIncome,
    required this.color,
  });
}

const defaultCategories = [
  Category(
    name: "Paycheck",
    image: "assets/categories/money-bag.png",
    isIncome: true,
    color: Color.fromARGB(255, 131, 191, 79),
  ),
  Category(
    name: "Housing",
    image: "assets/categories/house.png",
    isIncome: false,
    color: Color.fromARGB(255, 137, 102, 76),
  ),
  Category(
    name: "Utilities",
    image: "assets/categories/electric-plug.png",
    isIncome: false,
    color: Color.fromARGB(255, 255, 243, 108),
  ),
  Category(
    name: "Subscriptions",
    image: "assets/categories/calendar.png",
    isIncome: false,
    color: Color.fromARGB(255, 236, 243, 142),
  ),
  Category(
    name: "Groceries",
    image: "assets/categories/shopping-cart.png",
    isIncome: false,
    color: Color.fromARGB(255, 12, 210, 22),
  ),
  Category(
    name: "Shopping",
    image: "assets/categories/shopping-bags.png",
    isIncome: false,
    color: Color.fromARGB(255, 164, 115, 247),
  ),
  Category(
    name: "Miscellaneous",
    image: "assets/categories/asterisk.png",
    isIncome: false,
    color: Color.fromARGB(255, 220, 218, 218),
  ),
  Category(
    name: "Dinning",
    image: "assets/categories/fork-and-knife-with-plate.png",
    isIncome: false,
    color: Color.fromARGB(255, 151, 9, 9),
  ),
  Category(
    name: "Tech",
    image: "assets/categories/mobile-phone.png",
    isIncome: false,
    color: Color.fromARGB(255, 139, 255, 251),
  ),
  Category(
    name: "Savings",
    image: "assets/categories/money-bag.png",
    isIncome: false,
    color: Color.fromARGB(255, 109, 255, 148),
  ),
  Category(
    name: "Travel",
    image: "assets/categories/airplane.png",
    isIncome: false,
    color: Color.fromARGB(255, 103, 189, 255),
  ),
  Category(
    name: "Transportation",
    image: "assets/categories/trolleybus.png",
    isIncome: false,
    color: Color.fromARGB(255, 246, 255, 127),
  ),
  Category(
    name: "Entertainment",
    image: "assets/categories/clapper-board.png",
    isIncome: false,
    color: Color.fromARGB(255, 249, 99, 122),
  ),
  Category(
    name: "Debt",
    image: "assets/categories/chart-decreasing.png",
    isIncome: false,
    color: Color.fromARGB(255, 255, 0, 0),
  ),
  Category(
    name: "Investments",
    image: "assets/categories/chart-increasing.png",
    isIncome: false,
    color: Color.fromARGB(255, 0, 255, 8),
  ),
  Category(
    name: "Gas",
    image: "assets/categories/fuel-pump.png",
    isIncome: false,
    color: Color.fromARGB(244, 202, 59, 27),
  ),
  Category(
    name: "Insurance",
    image: "assets/categories/shield.png",
    isIncome: false,
    color: Color.fromARGB(255, 34, 98, 93),
  ),
  Category(
    name: "Healthcare",
    image: "assets/categories/hospital.png",
    isIncome: false,
    color: Color.fromARGB(255, 255, 96, 149),
  ),
  Category(
    name: "Retirement",
    image: "assets/categories/safe.png",
    isIncome: false,
    color: Color.fromARGB(255, 84, 51, 229),
  ),
  Category(
    name: "Clothing",
    image: "assets/categories/t-shirt.png",
    isIncome: false,
    color: Color.fromARGB(255, 66, 173, 226),
  ),
  Category(
    name: "Fitness",
    image: "assets/categories/dumbbell-large-minimalistic-bold-duotone.png",
    isIncome: false,
    color: Color.fromARGB(255, 36, 36, 36),
  ),
  Category(
    name: "Household Items",
    image: "assets/categories/toilet.png",
    isIncome: false,
    color: Color(0x89664c),
  ),
  Category(
    name: "Taxes",
    image: "assets/categories/ballot-box-with-ballot.png",
    isIncome: false,
    color: Color.fromARGB(255, 40, 37, 206),
  ),
  Category(
    name: "Internet",
    image: "assets/categories/wifi.png",
    isIncome: false,
    color: Color.fromARGB(255, 60, 131, 246),
  ),
  Category(
    name: "Fun",
    image: "assets/categories/party-popper.png",
    isIncome: false,
    color: Color.fromARGB(255, 255, 134, 54),
  ),
];
