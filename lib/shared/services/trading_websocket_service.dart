import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/candlestick.dart';

/// WebSocket Service for Real-Time Trading Data
/// Supports Binance, Upstox, Zerodha Kite, and TradingView
enum TradingDataSource { binance, upstox, kite, tradingView }

class TradingWebSocketService {
  TradingWebSocketService({
    this.dataSource = TradingDataSource.binance,
    this.symbol = 'BTCUSDT',
    this.interval = '1m',
  });

  final TradingDataSource dataSource;
  final String symbol;
  final String interval;

  WebSocketChannel? _channel;
  StreamController<List<Candlestick>>? _candlestickController;
  StreamController<Candlestick>? _realtimeController;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  bool _shouldReconnect = true;

  /// Stream of candlestick data batches
  Stream<List<Candlestick>> get candlestickStream =>
      _candlestickController?.stream ?? const Stream.empty();

  /// Stream of real-time single candlestick updates
  Stream<Candlestick> get realtimeStream =>
      _realtimeController?.stream ?? const Stream.empty();

  bool get isConnected => _isConnected;

  /// Connect to WebSocket
  Future<void> connect() async {
    if (_isConnected) return;

    try {
      final uri = _getWebSocketUri();
      _channel = WebSocketChannel.connect(uri);

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
        cancelOnError: false,
      );

      _isConnected = true;
      _shouldReconnect = true;
    } catch (e) {
      _handleError(e);
    }
  }

  /// Disconnect from WebSocket
  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _isConnected = false;
  }

  /// Subscribe to a symbol
  void subscribe(String newSymbol) {
    if (_channel != null && _isConnected) {
      _sendSubscription(newSymbol);
    }
  }

  /// Change interval
  void changeInterval(String newInterval) {
    if (_channel != null && _isConnected) {
      _sendIntervalChange(newInterval);
    }
  }

  Uri _getWebSocketUri() {
    switch (dataSource) {
      case TradingDataSource.binance:
        return Uri.parse(
          'wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}@kline_$interval',
        );
      case TradingDataSource.upstox:
        return Uri.parse('wss://api.upstox.com/v2/feed/market-data-feed');
      case TradingDataSource.kite:
        return Uri.parse('wss://kite.zerodha.com/websocket');
      case TradingDataSource.tradingView:
        return Uri.parse('wss://data.tradingview.com/socket.io/websocket');
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String);
      final candlestick = _parseMessage(data);

      if (candlestick != null) {
        _realtimeController?.add(candlestick);
      }
    } catch (e) {
      print('Error parsing message: $e');
    }
  }

  Candlestick? _parseMessage(Map<String, dynamic> data) {
    switch (dataSource) {
      case TradingDataSource.binance:
        return _parseBinanceMessage(data);
      case TradingDataSource.upstox:
        return _parseUpstoxMessage(data);
      case TradingDataSource.kite:
        return _parseKiteMessage(data);
      case TradingDataSource.tradingView:
        return _parseTradingViewMessage(data);
    }
  }

  Candlestick? _parseBinanceMessage(Map<String, dynamic> data) {
    try {
      if (data['k'] != null) {
        final k = data['k'] as Map<String, dynamic>;
        final isClosed = k['x'] as bool? ?? false;

        if (isClosed) {
          return Candlestick(
            timestamp: DateTime.fromMillisecondsSinceEpoch(k['t'] as int),
            open: double.parse(k['o'].toString()),
            high: double.parse(k['h'].toString()),
            low: double.parse(k['l'].toString()),
            close: double.parse(k['c'].toString()),
            volume: double.parse(k['v'].toString()),
            symbol: k['s'] as String?,
          );
        }
      }
    } catch (e) {
      print('Error parsing Binance message: $e');
    }
    return null;
  }

  Candlestick? _parseUpstoxMessage(Map<String, dynamic> data) {
    try {
      if (data['type'] == 'ohlc' && data['data'] != null) {
        final ohlc = data['data'] as Map<String, dynamic>;
        return Candlestick.fromUpstox(ohlc);
      }
    } catch (e) {
      print('Error parsing Upstox message: $e');
    }
    return null;
  }

  Candlestick? _parseKiteMessage(Map<String, dynamic> data) {
    try {
      if (data['type'] == 'tick' && data['data'] != null) {
        final tick = data['data'] as Map<String, dynamic>;
        return Candlestick.fromKite(tick);
      }
    } catch (e) {
      print('Error parsing Kite message: $e');
    }
    return null;
  }

  Candlestick? _parseTradingViewMessage(Map<String, dynamic> data) {
    try {
      if (data['m'] == 'qsd' && data['p'] != null) {
        final p = data['p'] as List;
        if (p.length >= 5) {
          return Candlestick.fromTradingView({
            'time': p[0],
            'open': p[1],
            'high': p[2],
            'low': p[3],
            'close': p[4],
            'volume': p.length > 5 ? p[5] : 0,
          });
        }
      }
    } catch (e) {
      print('Error parsing TradingView message: $e');
    }
    return null;
  }

  void _sendSubscription(String newSymbol) {
    switch (dataSource) {
      case TradingDataSource.binance:
        // Binance uses URL params, so reconnect with new symbol
        disconnect();
        // Reconnect logic would go here
        break;
      case TradingDataSource.upstox:
        _channel?.sink.add(
          jsonEncode({'action': 'subscribe', 'symbol': newSymbol}),
        );
        break;
      case TradingDataSource.kite:
        _channel?.sink.add(
          jsonEncode({
            'a': 'subscribe',
            'v': [newSymbol],
          }),
        );
        break;
      case TradingDataSource.tradingView:
        _channel?.sink.add(
          jsonEncode({
            'm': 'set_data_quality',
            'p': ['exchanges'],
          }),
        );
        break;
    }
  }

  void _sendIntervalChange(String newInterval) {
    // Implementation depends on data source
    // For Binance, you typically reconnect with new interval
    if (dataSource == TradingDataSource.binance) {
      disconnect();
      // Reconnect logic would go here
    }
  }

  void _handleError(dynamic error) {
    print('WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _handleDisconnect() {
    _isConnected = false;
    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_shouldReconnect && !_isConnected) {
        connect();
      }
    });
  }

  void dispose() {
    disconnect();
    _candlestickController?.close();
    _realtimeController?.close();
    _reconnectTimer?.cancel();
  }
}
