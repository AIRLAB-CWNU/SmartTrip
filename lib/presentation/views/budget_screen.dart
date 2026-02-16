import 'package:flutter/material.dart';
import 'package:smarttrip/core/theme/app_theme.dart';
import 'package:smarttrip/domain/models/expense.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 임시 데이터 (Mock Data)
    final List<Expense> mockExpenses = [
      Expense(id: '1', title: '에펠탑 근처 저녁', amount: 85.0, date: DateTime.now(), category: ExpenseCategory.food),
      Expense(id: '2', title: '파리 지하철 1일권', amount: 15.0, date: DateTime.now(), category: ExpenseCategory.transport),
      Expense(id: '3', title: '루브르 박물관 입장료', amount: 20.0, date: DateTime.now(), category: ExpenseCategory.entertainment),
      Expense(id: '4', title: '풀먼 호텔 (1박)', amount: 250.0, date: DateTime.now().subtract(const Duration(days: 1)), category: ExpenseCategory.accommodation),
    ];

    Map<String, double> dataMap = {
      "식비": 85,
      "교통": 15,
      "숙박": 250,
      "문화/여가": 20,
    };

    final totalSpent = mockExpenses.fold(0.0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('여행 가계부'),
        actions: [
          IconButton(icon: const Icon(Icons.file_download_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBudgetSummary(totalSpent),
            _buildChartSection(dataMap),
            _buildExpenseList(mockExpenses),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.deepBlue,
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }

  Widget _buildBudgetSummary(double total) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.deepBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            '총 지출',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '약 ${(total * 1350).toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원 (1,350원/\$ 기준)',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('예산', '\$3,000'),
              Container(width: 1, height: 30, color: Colors.white24),
              _buildSummaryItem('잔액', '\$${(3000 - total).toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildChartSection(Map<String, double> dataMap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('카테고리별 지출', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: 150,
                colorList: const [
                  AppTheme.coral,
                  AppTheme.deepBlue,
                  Colors.amber,
                  Colors.teal,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  decimalPlaces: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseList(List<Expense> expenses) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('최근 지출 내역', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(onPressed: () {}, child: const Text('전체 보기')),
            ],
          ),
          const SizedBox(height: 8),
          ...expenses.map((expense) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getCategoryColor(expense.category).withOpacity(0.1),
                  child: Icon(_getCategoryIcon(expense.category), color: _getCategoryColor(expense.category), size: 18),
                ),
                title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(DateFormat('MMM d').format(expense.date), style: const TextStyle(fontSize: 12)),
                trailing: Text(
                  '-\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
              )),
        ],
      ),
    );
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food: return AppTheme.coral;
      case ExpenseCategory.transport: return AppTheme.deepBlue;
      case ExpenseCategory.accommodation: return Colors.amber;
      case ExpenseCategory.entertainment: return Colors.teal;
      default: return AppTheme.grey;
    }
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food: return Icons.restaurant;
      case ExpenseCategory.transport: return Icons.directions_bus;
      case ExpenseCategory.accommodation: return Icons.hotel;
      case ExpenseCategory.entertainment: return Icons.confirmation_number;
      default: return Icons.shopping_bag;
    }
  }
}
