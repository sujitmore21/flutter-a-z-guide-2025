import 'package:dio/dio.dart';
import '../models/candlestick.dart';

/// REST API Service for fetching historical candlestick data
/// Supports Binance, Upstox, Zerodha Kite APIs
class TradingApiService {
  TradingApiService({this.baseUrl});

  final String? baseUrl;
  final Dio _dio = Dio();

  /// Fetch historical candlesticks from Binance
  Future<List<Candlestick>> fetchBinanceCandles({
    required String symbol,
    required String interval,
    int limit = 500,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.binance.com/api/v3/klines',
        queryParameters: {
          'symbol': symbol.toUpperCase(),
          'interval': interval,
          'limit': limit,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((item) {
        return Candlestick(
          timestamp: DateTime.fromMillisecondsSinceEpoch(item[0] as int),
          open: double.parse(item[1].toString()),
          high: double.parse(item[2].toString()),
          low: double.parse(item[3].toString()),
          close: double.parse(item[4].toString()),
          volume: double.parse(item[5].toString()),
          symbol: symbol,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch Binance candles: $e');
    }
  }

  /// Fetch historical candlesticks from Upstox
  Future<List<Candlestick>> fetchUpstoxCandles({
    required String symbol,
    required String interval,
    required String fromDate,
    required String toDate,
    String? accessToken,
  }) async {
    try {
      final headers = <String, String>{};
      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await _dio.get(
        'https://api.upstox.com/v2/historical-candle/$symbol/$interval',
        queryParameters: {'from': fromDate, 'to': toDate},
        options: Options(headers: headers),
      );

      final data = response.data['data']['candles'] as List;
      return data.map((item) {
        return Candlestick(
          timestamp: DateTime.parse(item[0] as String),
          open: double.parse(item[1].toString()),
          high: double.parse(item[2].toString()),
          low: double.parse(item[3].toString()),
          close: double.parse(item[4].toString()),
          volume: double.parse(item[5].toString()),
          symbol: symbol,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch Upstox candles: $e');
    }
  }

  /// Fetch historical candlesticks from Zerodha Kite
  Future<List<Candlestick>> fetchKiteCandles({
    required int instrumentToken,
    required String interval,
    required String fromDate,
    required String toDate,
    String? accessToken,
  }) async {
    try {
      final headers = <String, String>{};
      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await _dio.get(
        'https://kite.zerodha.com/oms/instruments/historical/$instrumentToken/$interval',
        queryParameters: {'from': fromDate, 'to': toDate},
        options: Options(headers: headers),
      );

      final data = response.data['data']['candles'] as List;
      return data.map((item) {
        return Candlestick(
          timestamp: DateTime.parse(item[0] as String),
          open: double.parse(item[1].toString()),
          high: double.parse(item[2].toString()),
          low: double.parse(item[3].toString()),
          close: double.parse(item[4].toString()),
          volume: double.parse(item[5].toString()),
          symbol: instrumentToken.toString(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch Kite candles: $e');
    }
  }
}
