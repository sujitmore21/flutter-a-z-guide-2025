# Real-Time Trading Data Integration

This document explains how to integrate real-time trading data using WebSocket connections to Binance, Upstox, Zerodha Kite, and TradingView.

## Features

- ✅ Real-time candlestick (OHLCV) data via WebSocket
- ✅ Historical data fetching via REST API
- ✅ Support for multiple exchanges (Binance, Upstox, Kite, TradingView)
- ✅ Provider-based state management
- ✅ Automatic reconnection on disconnect
- ✅ Live chart updates

## Setup

### 1. Install Dependencies

The required package is already in `pubspec.yaml`:
```yaml
dependencies:
  web_socket_channel: ^3.0.1
  provider: ^6.1.1
  dio: ^5.4.0
```

### 2. Basic Usage

#### Using TradingDataProvider

```dart
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../shared/providers/trading_data_provider.dart';
import '../../shared/services/trading_websocket_service.dart';

class TradingScreen extends StatefulWidget {
  @override
  _TradingScreenState createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  late TradingDataProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = TradingDataProvider(
      dataSource: TradingDataSource.binance,
      symbol: 'BTCUSDT',
      interval: '1m',
    );
    _provider.connect();
  }

  @override
  void dispose() {
    _provider.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<TradingDataProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Display current price
              Text('Price: \$${provider.currentPrice?.toStringAsFixed(2)}'),
              
              // Display price change
              Text('Change: ${provider.priceChangePercent?.toStringAsFixed(2)}%'),
              
              // Chart with real-time data
              TradingChart(
                data: provider.chartData,
                chartType: TradingChartType.candlestick,
              ),
            ],
          );
        },
      ),
    );
  }
}
```

## Exchange-Specific Examples

### Binance Integration

```dart
// Binance WebSocket
final provider = TradingDataProvider(
  dataSource: TradingDataSource.binance,
  symbol: 'BTCUSDT',  // Format: BASEQUOTE (e.g., BTCUSDT, ETHUSDT)
  interval: '1m',     // 1m, 5m, 15m, 1h, 1d
);

// Binance REST API for historical data
final apiService = TradingApiService();
final candles = await apiService.fetchBinanceCandles(
  symbol: 'BTCUSDT',
  interval: '1m',
  limit: 500,
);
provider.addHistoricalCandles(candles);
await provider.connect();
```

### Upstox Integration

```dart
// Upstox WebSocket (requires authentication)
final provider = TradingDataProvider(
  dataSource: TradingDataSource.upstox,
  symbol: 'NSE_INDEX|Nifty 50',
  interval: '1m',
);

// Upstox REST API
final apiService = TradingApiService();
final candles = await apiService.fetchUpstoxCandles(
  symbol: 'NSE_INDEX|Nifty 50',
  interval: '1m',
  fromDate: '2024-01-01',
  toDate: '2024-01-31',
  accessToken: 'YOUR_ACCESS_TOKEN',
);
```

### Zerodha Kite Integration

```dart
// Kite WebSocket (requires authentication)
final provider = TradingDataProvider(
  dataSource: TradingDataSource.kite,
  symbol: '256265', // Instrument token
  interval: '1m',
);

// Kite REST API
final apiService = TradingApiService();
final candles = await apiService.fetchKiteCandles(
  instrumentToken: 256265,
  interval: '1minute',
  fromDate: '2024-01-01',
  toDate: '2024-01-31',
  accessToken: 'YOUR_ACCESS_TOKEN',
);
```

### TradingView Integration

```dart
final provider = TradingDataProvider(
  dataSource: TradingDataSource.tradingView,
  symbol: 'BINANCE:BTCUSDT',
  interval: '1',
);
```

## API Reference

### TradingDataProvider

#### Properties
- `candlesticks`: List of all candlesticks
- `chartData`: Chart-ready TradingDataPoint list
- `currentPrice`: Latest close price
- `priceChange`: Price change from previous candle
- `priceChangePercent`: Percentage change
- `isLoading`: Loading state
- `isConnected`: WebSocket connection status
- `error`: Error message if any

#### Methods
- `connect()`: Connect to WebSocket
- `disconnect()`: Disconnect from WebSocket
- `changeSymbol(String)`: Change trading symbol
- `changeInterval(String)`: Change timeframe
- `addHistoricalCandles(List<Candlestick>)`: Load historical data
- `updateLatestCandlestick(Candlestick)`: Update with new candle

### Candlestick Model

```dart
final candle = Candlestick(
  timestamp: DateTime.now(),
  open: 42000.0,
  high: 42500.0,
  low: 41800.0,
  close: 42300.0,
  volume: 1234.56,
  symbol: 'BTCUSDT',
);

// Properties
candle.isBullish        // true if close >= open
candle.change           // close - open
candle.changePercent    // percentage change
candle.bodySize         // |close - open|
candle.upperWick        // high - max(open, close)
candle.lowerWick        // min(open, close) - low
candle.range            // high - low
```

## State Management

The provider automatically notifies listeners when:
- New candlestick data arrives
- Connection status changes
- Symbol or interval changes
- Errors occur

```dart
Consumer<TradingDataProvider>(
  builder: (context, provider, child) {
    // Rebuilds automatically when provider updates
    return YourWidget(data: provider.chartData);
  },
)
```

## Error Handling

```dart
Consumer<TradingDataProvider>(
  builder: (context, provider, child) {
    if (provider.error != null) {
      return Text('Error: ${provider.error}');
    }
    
    if (provider.isLoading) {
      return CircularProgressIndicator();
    }
    
    return YourChart(data: provider.chartData);
  },
)
```

## WebSocket Auto-Reconnection

The service automatically reconnects if the connection drops:
- Waits 5 seconds before reconnecting
- Stops reconnecting if `disconnect()` is called
- Handles network errors gracefully

## Performance Tips

1. **Limit Data**: Keep only last 500 candles in memory
   ```dart
   // Automatically handled by provider
   ```

2. **Batch Updates**: Provider batches multiple updates efficiently

3. **Dispose Properly**: Always disconnect when done
   ```dart
   @override
   void dispose() {
     provider.disconnect();
     super.dispose();
   }
   ```

## Example: Complete Trading Dashboard

See `lib/features/dashboard/presentation/pages/dashboard_screen.dart` for a complete implementation with:
- Real-time chart updates
- Historical data loading
- Error handling
- Connection status

## Testing

For testing without live data:

```dart
// Use mock data
final provider = TradingDataProvider();
provider.addHistoricalCandles(_generateMockCandles());

// Or use sample data generator
final candles = _generateSampleCandles(100);
provider.addHistoricalCandles(candles);
```

## Notes

- Binance WebSocket URL format: `wss://stream.binance.com:9443/ws/{symbol}@kline_{interval}`
- Upstox/Kite require authentication tokens
- TradingView uses different message format
- Always handle network errors gracefully
- Consider rate limits for REST API calls

