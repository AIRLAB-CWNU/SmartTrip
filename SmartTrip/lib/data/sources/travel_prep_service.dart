enum VisaStatus { green, yellow, red }

class VisaInfo {
  final String Country;
  final VisaStatus status;
  final String message;
  final List<String> requirements;

  VisaInfo({
    required this.Country,
    required this.status,
    required this.message,
    required this.requirements,
  });
}

class TravelPrepService {
  static Future<VisaInfo> getVisaInfo(String destination) async {
    // 실제로는 Travel Buddy API 등을 호출하지만, 여기서는 Mock 데이터를 반환합니다.
    await Future.delayed(const Duration(seconds: 1));
    
    if (destination.toLowerCase().contains('france')) {
      return VisaInfo(
        Country: 'France',
        status: VisaStatus.green,
        message: '무비자 입국 가능',
        requirements: ['유효한 여권 (6개월 이상)', '최대 90일 체류 가능', '여행자 보험 권장'],
      );
    } else {
      return VisaInfo(
        Country: destination,
        status: VisaStatus.yellow,
        message: '사전 확인 필요',
        requirements: ['현지 대사관 확인 필요'],
      );
    }
  }
}
