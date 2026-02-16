import 'package:flutter/material.dart';
import 'package:smarttrip/core/theme/app_theme.dart';
import 'package:smarttrip/domain/models/activity.dart';
import 'package:intl/intl.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 임시 데이터 (Mock Data)
    final List<Activity> mockActivities = [
      Activity(
        id: '1',
        title: '에어프랑스 AF267',
        location: '인천국제공항 (ICN)',
        time: DateTime.now().setHourAndMinute(9, 30),
        type: ActivityType.transport,
        note: '터미널 2, 체크인 카운터 J',
      ),
      Activity(
        id: '2',
        title: '점심 식사 - 카레 가이',
        location: '공항 내 식당가',
        time: DateTime.now().setHourAndMinute(11, 0),
        type: ActivityType.food,
      ),
      Activity(
        id: '3',
        title: '호텔 체크인',
        location: '풀먼 파리 타워 에펠',
        time: DateTime.now().setHourAndMinute(15, 0),
        type: ActivityType.hotel,
      ),
      Activity(
        id: '4',
        title: '에펠탑 관람',
        location: 'Champ de Mars',
        time: DateTime.now().setHourAndMinute(18, 30),
        type: ActivityType.attraction,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 일정'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_month), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: mockActivities.length,
              itemBuilder: (context, index) {
                return _buildTimelineItem(context, mockActivities[index], index == mockActivities.length - 1);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.deepBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            width: 60,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.deepBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? null : Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Day ${index + 1}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${15 + index}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.deepBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, Activity activity, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppTheme.coral,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(activity.time),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.deepBlue,
                      ),
                    ),
                    _getTypeIcon(activity.type),
                  ],
                ),
                const SizedBox(height: 8),
                Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.grey),
                            const SizedBox(width: 4),
                            Text(
                              activity.location,
                              style: const TextStyle(color: AppTheme.grey, fontSize: 13),
                            ),
                          ],
                        ),
                        if (activity.note != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            activity.note!,
                            style: TextStyle(color: AppTheme.deepBlue.withOpacity(0.6), fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTypeIcon(ActivityType type) {
    IconData icon;
    switch (type) {
      case ActivityType.transport:
        icon = Icons.flight_takeoff;
        break;
      case ActivityType.hotel:
        icon = Icons.hotel;
        break;
      case ActivityType.food:
        icon = Icons.restaurant;
        break;
      case ActivityType.attraction:
        icon = Icons.photo_camera;
        break;
      default:
        icon = Icons.event;
    }
    return Icon(icon, size: 18, color: AppTheme.grey);
  }
}

extension DateTimeExtension on DateTime {
  DateTime setHourAndMinute(int hour, int minute) {
    return DateTime(year, month, day, hour, minute);
  }
}
