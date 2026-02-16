import 'package:hive_ce/hive.dart';

part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String destination;
  
  @HiveField(3)
  final DateTime startDate;
  
  @HiveField(4)
  final DateTime endDate;
  
  @HiveField(5)
  final String? imageUrl;
  
  @HiveField(6)
  final double budget;
  
  @HiveField(7)
  final double spent;

  Trip({
    required this.id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    this.budget = 0,
    this.spent = 0,
  });

  double get progress => budget > 0 ? spent / budget : 0;
  int get daysRemaining => startDate.difference(DateTime.now()).inDays;
}
