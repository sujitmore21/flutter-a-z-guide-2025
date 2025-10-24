import 'package:flutter/material.dart';
import '../../../../ui_kit/components/atoms/trading_card.dart';
import '../../../../ui_kit/components/atoms/trading_button.dart';
import '../../../../ui_kit/components/molecules/price_display.dart';
import '../../../../ui_kit/components/molecules/portfolio_summary.dart';
import '../../../../ui_kit/components/molecules/order_book.dart';
import '../../../../ui_kit/components/organisms/trading_chart.dart';
import '../../../../core/constants/app_sizes/trading_sizes.dart';

/// Dashboard Screen
/// Main trading dashboard with portfolio overview and market data
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TradingSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPortfolioSection(),
          const SizedBox(height: TradingSizes.lg),
          _buildMarketSection(),
          const SizedBox(height: TradingSizes.lg),
          _buildTradingSection(),
        ],
      ),
    );
  }

  Widget _buildPortfolioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Portfolio',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TradingSizes.md),
        const PortfolioSummary(
          totalValue: 125430.50,
          totalChange: 2340.25,
          totalChangePercent: 1.9,
          availableBalance: 15000.00,
          investedAmount: 110430.50,
          dayChange: 450.75,
          dayChangePercent: 0.36,
        ),
        const SizedBox(height: TradingSizes.md),
        _buildQuickActions(),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: TradingButton(
            text: 'Buy',
            onPressed: () {},
            variant: TradingButtonVariant.success,
            isFullWidth: true,
            icon: Icons.add,
          ),
        ),
        const SizedBox(width: TradingSizes.md),
        Expanded(
          child: TradingButton(
            text: 'Sell',
            onPressed: () {},
            variant: TradingButtonVariant.danger,
            isFullWidth: true,
            icon: Icons.remove,
          ),
        ),
        const SizedBox(width: TradingSizes.md),
        Expanded(
          child: TradingButton(
            text: 'Transfer',
            onPressed: () {},
            variant: TradingButtonVariant.secondary,
            isFullWidth: true,
            icon: Icons.swap_horiz,
          ),
        ),
      ],
    );
  }

  Widget _buildMarketSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Market Overview',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TradingSizes.md),
        _buildMarketCards(),
      ],
    );
  }

  Widget _buildMarketCards() {
    final marketData = [
      {
        'symbol': 'BTC',
        'name': 'Bitcoin',
        'price': 43250.75,
        'change': 1250.25,
        'changePercent': 2.98,
      },
      {
        'symbol': 'ETH',
        'name': 'Ethereum',
        'price': 2850.50,
        'change': -45.25,
        'changePercent': -1.56,
      },
      {
        'symbol': 'SOL',
        'name': 'Solana',
        'price': 95.25,
        'change': 8.75,
        'changePercent': 10.12,
      },
    ];

    return Column(
      children: marketData.map((data) {
        return Padding(
          padding: const EdgeInsets.only(bottom: TradingSizes.sm),
          child: TradingCard(
            onTap: () {},
            isClickable: true,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getCryptoIconColor(
                      data['symbol'] as String,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
                  ),
                  child: Icon(
                    _getCryptoIcon(data['symbol'] as String),
                    color: _getCryptoIconColor(data['symbol'] as String),
                    size: 20,
                  ),
                ),
                const SizedBox(width: TradingSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['symbol'] as String,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['name'] as String,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                CompactPriceDisplay(
                  price: data['price'] as double,
                  change: data['change'] as double,
                  changePercent: data['changePercent'] as double,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTradingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trading',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TradingSizes.md),
        Row(
          children: [
            Expanded(flex: 2, child: _buildChartCard()),
            const SizedBox(width: TradingSizes.md),
            Expanded(child: _buildOrderBookCard()),
          ],
        ),
      ],
    );
  }

  Widget _buildChartCard() {
    return TradingCardWithHeader(
      title: 'BTC/USD',
      subtitle: 'Bitcoin to US Dollar',
      child: SizedBox(
        height: 300,
        child: TradingChart(
          data: _generateSampleData(),
          chartType: TradingChartType.line,
          timeframe: TradingTimeframe.day1,
        ),
      ),
    );
  }

  Widget _buildOrderBookCard() {
    return TradingCardWithHeader(
      title: 'Order Book',
      child: SizedBox(
        height: 300,
        child: OrderBook(
          buyOrders: _generateBuyOrders(),
          sellOrders: _generateSellOrders(),
          maxRows: 8,
        ),
      ),
    );
  }

  List<TradingDataPoint> _generateSampleData() {
    final data = <TradingDataPoint>[];
    double price = 42000.0;

    for (int i = 0; i < 30; i++) {
      price += (i % 3 == 0 ? 1 : -1) * (100 + (i * 10));
      data.add(
        TradingDataPoint(
          value: price,
          label: '${i + 1}',
          timestamp: DateTime.now().subtract(Duration(days: 29 - i)),
        ),
      );
    }

    return data;
  }

  List<OrderBookEntry> _generateBuyOrders() {
    final orders = <OrderBookEntry>[];
    double price = 43200.0;

    for (int i = 0; i < 10; i++) {
      orders.add(
        OrderBookEntry(price: price - (i * 10), size: 0.5 + (i * 0.1)),
      );
    }

    return orders;
  }

  List<OrderBookEntry> _generateSellOrders() {
    final orders = <OrderBookEntry>[];
    double price = 43250.0;

    for (int i = 0; i < 10; i++) {
      orders.add(
        OrderBookEntry(price: price + (i * 10), size: 0.3 + (i * 0.05)),
      );
    }

    return orders;
  }

  IconData _getCryptoIcon(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
        return Icons.currency_bitcoin;
      case 'ETH':
        return Icons.currency_exchange;
      case 'SOL':
        return Icons.auto_awesome;
      default:
        return Icons.currency_bitcoin;
    }
  }

  Color _getCryptoIconColor(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
        return Colors.orange;
      case 'ETH':
        return Colors.blue;
      case 'SOL':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
