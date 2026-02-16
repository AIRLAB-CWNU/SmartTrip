import 'package:dio/dio.dart';

class CurrencyService {
  final Dio _dio = Dio();
  
  // 실제 API (예: exchange-rate-api.com)를 연동할 수 있는 기본 구조
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest/';

  Future<double> getExchangeRate(String from, String to) async {
    try {
      // 실제 API 호출 (Placeholder)
      // final response = await _dio.get('$_baseUrl$from');
      // return response.data['rates'][to];
      
      // Mock환율: 1 USD = 1350 KRW, 1 EUR = 1.08 USD
      if (from == 'USD' && to == 'KRW') return 1350.0;
      if (from == 'EUR' && to == 'USD') return 1.08;
      return 1.0;
    } catch (e) {
      return 1.0;
    }
  }

  double convert(double amount, double rate) {
    return amount * rate;
  }
}
