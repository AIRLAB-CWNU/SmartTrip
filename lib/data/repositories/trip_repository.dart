import 'package:smarttrip/domain/models/trip.dart';

class TripRepository {
  // TODO: Implement Firestore sync
  // For now, focus on providing a structured place for data access
  
  static Trip getMockTrip() {
    return Trip(
      id: '1',
      title: '파리 여름 휴가',
      destination: '프랑스 파리',
      startDate: DateTime.now().add(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 22)),
      budget: 3000,
      spent: 1250,
    );
  }
}
