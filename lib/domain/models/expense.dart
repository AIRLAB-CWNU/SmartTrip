enum ExpenseCategory { food, transport, shopping, accommodation, entertainment, other }

class Expense {
  final String id;
  final String title;
  final double amount;
  final String currency;
  final DateTime date;
  final ExpenseCategory category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    this.currency = 'USD',
    required this.date,
    required this.category,
  });
}
