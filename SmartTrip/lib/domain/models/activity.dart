enum ActivityType { transport, hotel, food, attraction, other }

class Activity {
  final String id;
  final String title;
  final String location;
  final DateTime time;
  final ActivityType type;
  final String? note;
  final bool isCompleted;

  Activity({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.type,
    this.note,
    this.isCompleted = false,
  });
}
