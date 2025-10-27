import 'package:equatable/equatable.dart';

/// Candlestick/OHLCV Data Model
/// Represents a single candlestick with Open, High, Low, Close, Volume data
class Candlestick extends Equatable {
  const Candlestick({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.timestamp,
    this.symbol,
  });

  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final DateTime timestamp;
  final String? symbol;

  /// Calculate the price change
  double get change => close - open;

  /// Calculate the price change percentage
  double get changePercent => open != 0 ? ((close - open) / open) * 100 : 0;

  /// Determine if the candle is bullish (green) or bearish (red)
  bool get isBullish => close >= open;

  /// Body size (difference between open and close)
  double get bodySize => (close - open).abs();

  /// Upper wick size
  double get upperWick => high - (close > open ? close : open);

  /// Lower wick size
  double get lowerWick => (close > open ? open : close) - low;

  /// Total range (high - low)
  double get range => high - low;

  factory Candlestick.fromJson(Map<String, dynamic> json) {
    return Candlestick(
      timestamp: DateTime.parse(json['timestamp'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      symbol: json['symbol'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
      'symbol': symbol,
    };
  }

  /// Create from Binance format [openTime, open, high, low, close, volume, closeTime, ...]
  factory Candlestick.fromBinance(List<dynamic> data, {String? symbol}) {
    return Candlestick(
      timestamp: DateTime.fromMillisecondsSinceEpoch(data[0] as int),
      open: double.parse(data[1].toString()),
      high: double.parse(data[2].toString()),
      low: double.parse(data[3].toString()),
      close: double.parse(data[4].toString()),
      volume: double.parse(data[5].toString()),
      symbol: symbol,
    );
  }

  /// Create from Upstox format
  factory Candlestick.fromUpstox(Map<String, dynamic> json) {
    return Candlestick(
      timestamp: DateTime.parse(json['timestamp'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      symbol: json['symbol'] as String?,
    );
  }

  /// Create from Zerodha Kite format
  factory Candlestick.fromKite(Map<String, dynamic> json) {
    return Candlestick(
      timestamp: DateTime.parse(json['time'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      symbol: json['instrument_token']?.toString(),
    );
  }

  /// Create from TradingView format
  factory Candlestick.fromTradingView(Map<String, dynamic> json) {
    return Candlestick(
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (json['time'] as int) * 1000,
      ),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      symbol: json['symbol'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    open,
    high,
    low,
    close,
    volume,
    timestamp,
    symbol,
  ];

  Candlestick copyWith({
    double? open,
    double? high,
    double? low,
    double? close,
    double? volume,
    DateTime? timestamp,
    String? symbol,
  }) {
    return Candlestick(
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      volume: volume ?? this.volume,
      timestamp: timestamp ?? this.timestamp,
      symbol: symbol ?? this.symbol,
    );
  }
}
