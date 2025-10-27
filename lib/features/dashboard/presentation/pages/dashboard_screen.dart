import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../ui_kit/components/atoms/trading_card.dart';
import '../../../../ui_kit/components/atoms/trading_button.dart';
import '../../../../ui_kit/components/molecules/price_display.dart';
import '../../../../ui_kit/components/molecules/portfolio_summary.dart';
import '../../../../ui_kit/components/molecules/order_book.dart';
import '../../../../ui_kit/components/organisms/trading_chart.dart';
import '../../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../../shared/providers/trading_data_provider.dart';
import '../../../../shared/services/trading_api_service.dart';
import '../../../../shared/services/trading_websocket_service.dart';

/// Dashboard Screen
/// Main trading dashboard with portfolio overview and market data
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late TradingDataProvider _tradingProvider;
  final TradingApiService _apiService = TradingApiService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTradingData();
  }

  Future<void> _initializeTradingData() async {
    // Initialize provider
    _tradingProvider = TradingDataProvider(
      dataSource: TradingDataSource.binance,
      symbol: 'BTCUSDT',
      interval: '1m',
    );

    // Load historical data first
    try {
      final candles = await _apiService.fetchBinanceCandles(
        symbol: 'BTCUSDT',
        interval: '1m',
        limit: 100,
      );
      _tradingProvider.addHistoricalCandles(candles);
    } catch (e) {
      print('Error loading historical data: $e');
    }

    // Connect to WebSocket for real-time updates
    await _tradingProvider.connect();

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _tradingProvider.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return ChangeNotifierProvider.value(
      value: _tradingProvider,
      child: Scaffold(body: _buildBody()),
    );
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
          const SizedBox(height: TradingSizes.lg),
          _buildEcommerceSection(),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < TradingSizes.mobileBreakpoint;
    final spacing = isSmallScreen ? TradingSizes.sm : TradingSizes.md;

    return Row(
      children: [
        Expanded(
          child: TradingButton(
            text: 'Buy',
            onPressed: () {},
            variant: TradingButtonVariant.success,
            isFullWidth: true,
            icon: Icons.add,
            size: isSmallScreen
                ? TradingButtonSize.small
                : TradingButtonSize.medium,
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: TradingButton(
            text: 'Sell',
            onPressed: () {},
            variant: TradingButtonVariant.danger,
            isFullWidth: true,
            icon: Icons.remove,
            size: isSmallScreen
                ? TradingButtonSize.small
                : TradingButtonSize.medium,
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: TradingButton(
            text: 'Transfer',
            onPressed: () {},
            variant: TradingButtonVariant.secondary,
            isFullWidth: true,
            icon: Icons.swap_horiz,
            size: isSmallScreen
                ? TradingButtonSize.small
                : TradingButtonSize.medium,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < TradingSizes.mobileBreakpoint;
    final chartHeight = TradingSizes.getResponsiveSize(
      context,
      mobile: 250.0,
      tablet: 320.0,
      desktop: 400.0,
    );

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
        isMobile
            ? Column(
                children: [
                  _buildChartCard(chartHeight),
                  const SizedBox(height: TradingSizes.md),
                  _buildOrderBookCard(chartHeight),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildChartCard(chartHeight)),
                  const SizedBox(width: TradingSizes.md),
                  Expanded(child: _buildOrderBookCard(chartHeight)),
                ],
              ),
      ],
    );
  }

  Widget _buildChartCard(double height) {
    return Consumer<TradingDataProvider>(
      builder: (context, provider, child) {
        return TradingChart(
          data: provider.chartData.isNotEmpty
              ? provider.chartData
              : _generateSampleData(),
          chartType: TradingChartType.candlestick,
          timeframe: TradingTimeframe.minute1,
          title: 'BTC/USDT',
          subtitle: provider.currentPrice != null
              ? '\$${provider.currentPrice!.toStringAsFixed(2)}'
              : 'Bitcoin to USDT',
          height: height,
          isLoading: provider.isLoading,
        );
      },
    );
  }

  Widget _buildOrderBookCard(double height) {
    return SizedBox(
      height: height,
      child: OrderBook(
        buyOrders: _generateBuyOrders(),
        sellOrders: _generateSellOrders(),
        maxRows: 8,
        showHeaders: true,
      ),
    );
  }

  Widget _buildEcommerceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'E-commerce',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TradingSizes.md),
        _buildProductGrid(),
        const SizedBox(height: TradingSizes.md),
        _buildShoppingCartPreview(),
      ],
    );
  }

  Widget _buildProductGrid() {
    final products = [
      {
        'name': 'Wireless Headphones',
        'price': 199.99,
        'originalPrice': 249.99,
        'rating': 4.5,
        'reviewCount': 128,
        'category': 'Electronics',
        'isOnSale': true,
        'isNew': false,
      },
      {
        'name': 'Smart Watch',
        'price': 299.99,
        'originalPrice': null,
        'rating': 4.8,
        'reviewCount': 89,
        'category': 'Wearables',
        'isOnSale': false,
        'isNew': true,
      },
      {
        'name': 'Bluetooth Speaker',
        'price': 79.99,
        'originalPrice': null,
        'rating': 4.2,
        'reviewCount': 256,
        'category': 'Audio',
        'isOnSale': false,
        'isNew': false,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: TradingSizes.sm,
        mainAxisSpacing: TradingSizes.sm,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildCompactProductCard(
          name: product['name'] as String,
          price: product['price'] as double,
          originalPrice: product['originalPrice'] as double?,
          rating: product['rating'] as double?,
          reviewCount: product['reviewCount'] as int?,
          category: product['category'] as String?,
          isOnSale: product['isOnSale'] as bool,
          isNew: product['isNew'] as bool,
        );
      },
    );
  }

  Widget _buildCompactProductCard({
    required String name,
    required double price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    String? category,
    bool isOnSale = false,
    bool isNew = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TradingSizes.radiusMd),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(TradingSizes.radiusMd),
                    ),
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                  child: const Icon(Icons.image, size: 40, color: Colors.grey),
                ),
                // Badges
                Positioned(
                  top: TradingSizes.xs,
                  left: TradingSizes.xs,
                  child: isOnSale
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: TradingSizes.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'SALE',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                          ),
                        )
                      : isNew
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: TradingSizes.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NEW',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                // Action buttons
                Positioned(
                  top: TradingSizes.xs,
                  right: TradingSizes.xs,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border, size: 16),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility, size: 16),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Content section
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(TradingSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  if (category != null)
                    Text(
                      category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                  const SizedBox(height: 2),
                  // Product name
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Rating
                  if (rating != null)
                    Row(
                      children: [
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          '${rating.toStringAsFixed(1)} (${reviewCount ?? 0})',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 10,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                              ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${originalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.5),
                                fontSize: 10,
                              ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Add to cart button
                  SizedBox(
                    width: double.infinity,
                    height: 24,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingCartPreview() {
    return Container(
      padding: const EdgeInsets.all(TradingSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TradingSizes.radiusMd),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: TradingSizes.sm),
              Text(
                'Shopping Cart',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '3 items',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: TradingSizes.sm),
          _buildCartItem('Wireless Headphones', 199.99, 1),
          _buildCartItem('Smart Watch', 299.99, 1),
          _buildCartItem('Bluetooth Speaker', 79.99, 1),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$579.97',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(String name, double price, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TradingSizes.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(name, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            'Qty: $quantity',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: TradingSizes.sm),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
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
