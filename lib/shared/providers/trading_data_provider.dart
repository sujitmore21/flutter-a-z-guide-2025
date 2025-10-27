import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/candlestick.dart';
import '../services/trading_websocket_service.dart';
import '../../ui_kit/components/organisms/trading_chart.dart';

/// Provider for Real-Time Trading Data
/// Manages WebSocket connection and candlestick data updates
class TradingDataProvider extends ChangeNotifier {
  TradingDataProvider({
    TradingDataSource? dataSource,
    String? symbol,
    String? interval,
  }) : _dataSource = dataSource ?? TradingDataSource.binance,
       _symbol = symbol ?? 'BTCUSDT',
       _interval = interval ?? '1m' {
    _initializeService();
  }

  final TradingDataSource _dataSource;
  String _symbol;
  String _interval;

  TradingWebSocketService? _service;
  final List<Candlestick> _candlesticks = [];
  StreamSubscription<Candlestick>? _realtimeSubscription;
  bool _isLoading = false;
  String? _error;
  bool _isConnected = false;

  List<Candlestick> get candlesticks => List.unmodifiable(_candlesticks);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isConnected => _isConnected;
  String get symbol => _symbol;
  String get interval => _interval;

  /// Convert candlesticks to TradingDataPoint format for chart
  List<TradingDataPoint> get chartData {
    return _candlesticks.map((candle) {
      return TradingDataPoint(
        value: candle.close,
        label: _formatLabel(candle.timestamp),
        timestamp: candle.timestamp,
        open: candle.open,
        high: candle.high,
        low: candle.low,
        close: candle.close,
        volume: candle.volume,
      );
    }).toList();
  }

  /// Latest candlestick
  Candlestick? get latestCandle =>
      _candlesticks.isNotEmpty ? _candlesticks.last : null;

  /// Current price (latest close)
  double? get currentPrice => latestCandle?.close;

  /// Price change
  double? get priceChange {
    if (_candlesticks.length < 2) return null;
    final current = _candlesticks.last.close;
    final previous = _candlesticks[_candlesticks.length - 2].close;
    return current - previous;
  }

  /// Price change percentage
  double? get priceChangePercent {
    if (_candlesticks.length < 2) return null;
    final current = _candlesticks.last.close;
    final previous = _candlesticks[_candlesticks.length - 2].close;
    if (previous == 0) return null;
    return ((current - previous) / previous) * 100;
  }

  void _initializeService() {
    _service = TradingWebSocketService(
      dataSource: _dataSource,
      symbol: _symbol,
      interval: _interval,
    );

    _realtimeSubscription = _service!.realtimeStream.listen(
      _handleRealtimeUpdate,
      onError: _handleError,
    );
  }

  /// Connect to WebSocket
  Future<void> connect() async {
    if (_isConnected) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service?.connect();
      _isConnected = _service?.isConnected ?? false;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Disconnect from WebSocket
  void disconnect() {
    _service?.disconnect();
    _isConnected = false;
    notifyListeners();
  }

  /// Change symbol
  void changeSymbol(String newSymbol) {
    _symbol = newSymbol;
    _service?.subscribe(newSymbol);
    notifyListeners();
  }

  /// Change interval
  void changeInterval(String newInterval) {
    _interval = newInterval;
    _service?.changeInterval(newInterval);
    notifyListeners();
  }

  /// Add historical candlesticks (for initial load)
  void addHistoricalCandles(List<Candlestick> candles) {
    _candlesticks.clear();
    _candlesticks.addAll(candles);
    notifyListeners();
  }

  /// Add a single candlestick
  void addCandlestick(Candlestick candle) {
    _candlesticks.add(candle);
    notifyListeners();
  }

  /// Update latest candlestick (for real-time updates)
  void updateLatestCandlestick(Candlestick candle) {
    if (_candlesticks.isEmpty) {
      _candlesticks.add(candle);
    } else {
      // Check if it's a new candle or update to existing
      final lastCandle = _candlesticks.last;
      final sameTimeframe = _isSameTimeframe(
        lastCandle.timestamp,
        candle.timestamp,
      );

      if (sameTimeframe) {
        // Update existing candle
        _candlesticks[_candlesticks.length - 1] = candle;
      } else {
        // New candle
        _candlesticks.add(candle);
        // Keep only last 500 candles to prevent memory issues
        if (_candlesticks.length > 500) {
          _candlesticks.removeAt(0);
        }
      }
    }
    notifyListeners();
  }

  void _handleRealtimeUpdate(Candlestick candle) {
    updateLatestCandlestick(candle);
  }

  void _handleError(dynamic error) {
    _error = error.toString();
    _isConnected = false;
    notifyListeners();
  }

  bool _isSameTimeframe(DateTime t1, DateTime t2) {
    // Check if timestamps are in the same timeframe based on interval
    final diff = t2.difference(t1).inMinutes;
    switch (_interval) {
      case '1m':
        return diff < 1;
      case '5m':
        return diff < 5;
      case '15m':
        return diff < 15;
      case '1h':
        return diff < 60;
      case '1d':
        return diff < 1440;
      default:
        return diff < 1;
    }
  }

  String _formatLabel(DateTime timestamp) {
    switch (_interval) {
      case '1m':
      case '5m':
      case '15m':
        return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
      case '1h':
        return '${timestamp.day}/${timestamp.month} ${timestamp.hour}:00';
      case '1d':
        return '${timestamp.day}/${timestamp.month}';
      default:
        return timestamp.toString();
    }
  }

  @override
  void dispose() {
    _realtimeSubscription?.cancel();
    _service?.dispose();
    super.dispose();
  }
}
