# Budget Management App

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

The Budget Management App is a Flutter application designed to help users manage their budgets, categories, and expenses efficiently. The app uses the `sqflite` library for local database management and follows clean architecture principles to ensure scalability and maintainability.

## Features

- Create, read, update, and delete budgets.
- Create, read, update, and delete categories within budgets.
- Create, read, update, and delete expenses within categories.
- Auto-delete categories and expenses when their parent budget or category is deleted.

## Architecture

The app follows clean architecture principles, which divide the project into several layers:

- **Entities**: Plain Dart objects representing the data (e.g., `Budget`, `Category`, `Expense`).
- **Repositories**: Interfaces defining the contract for data operations.
- **Repository Implementations**: Concrete classes that implement repository interfaces and interact with the SQLite database through the `DatabaseHelper`.

### Directory Structure

```
lib/
├── data/
│   └── database_helper.dart
├── entities/
│   ├── budget.dart
│   ├── category.dart
│   └── expense.dart
├── repositories/
│   ├── budget_repository.dart
│   ├── category_repository.dart
│   ├── expense_repository.dart
│   ├── budget_repository_impl.dart
│   ├── category_repository_impl.dart
│   └── expense_repository_impl.dart
└── main.dart
```

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Steps

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/budget_management_app.git
   cd budget_management_app
   ```

2. **Get the dependencies:**

   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Usage

1. **Add a Budget:**

   - Navigate to the budget section and click on "Add Budget".
   - Fill in the name and income, then save.

2. **Add a Category:**

   - Select a budget and click on "Add Category".
   - Fill in the name and spending limit, then save.

3. **Add an Expense:**

   - Select a category and click on "Add Expense".
   - Fill in the title, amount, date, and optional notes, then save.

4. **Update or Delete:**
   - Navigate to the item you want to update or delete and use the corresponding options.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature-name`.
3. Make your changes and commit them: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature/your-feature-name`.
5. Open a pull request.

Please ensure your code follows the existing style and includes tests where applicable.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or suggestions, feel free to reach out to me at [your-email@example.com].

## To Do

[] Add form to create a budget (and categories)
[] Add navigation to budget form
[] Transition form to create an expense to new model
[] Update README.md
