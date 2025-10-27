import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../core/constants/app_styles/trading_text_styles.dart';

/// Order Book Component
/// Displays buy and sell orders in a trading interface
class OrderBook extends StatelessWidget {
  const OrderBook({
    super.key,
    required this.buyOrders,
    required this.sellOrders,
    this.title = 'Order Book',
    this.maxRows = 10,
    this.showHeaders = true,
    this.isLoading = false,
    this.onOrderTap,
  });

  final List<OrderBookEntry> buyOrders;
  final List<OrderBookEntry> sellOrders;
  final String title;
  final int maxRows;
  final bool showHeaders;
  final bool isLoading;
  final Function(OrderBookEntry)? onOrderTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(TradingSizes.radiusMd),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHeaders) _buildHeader(context),
          if (isLoading)
            _buildLoadingState()
          else
            Expanded(child: _buildOrderBook()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TradingSizes.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          const Spacer(),
          Flexible(child: _buildSpread()),
        ],
      ),
    );
  }

  Widget _buildSpread() {
    if (buyOrders.isEmpty || sellOrders.isEmpty) {
      return const SizedBox.shrink();
    }

    final bestBid = buyOrders.first.price;
    final bestAsk = sellOrders.first.price;
    final spread = bestAsk - bestBid;
    final spreadPercent = (spread / bestBid) * 100;

    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Spread: \$${spread.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${spreadPercent.toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      padding: EdgeInsets.all(TradingSizes.md),
      child: Center(
        child: CircularProgressIndicator(color: TradingColors.primary),
      ),
    );
  }

  Widget _buildOrderBook() {
    return Row(
      children: [
        // Buy Orders (Left Side)
        Expanded(
          child: _buildOrderSide(
            orders: buyOrders.take(maxRows).toList(),
            isBuySide: true,
          ),
        ),
        // Divider
        Container(width: 1, color: TradingColors.border),
        // Sell Orders (Right Side)
        Expanded(
          child: _buildOrderSide(
            orders: sellOrders.take(maxRows).toList(),
            isBuySide: false,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSide({
    required List<OrderBookEntry> orders,
    required bool isBuySide,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TradingSizes.sm,
            vertical: TradingSizes.xs,
          ),
          decoration: BoxDecoration(
            color: isBuySide
                ? TradingColors.profit.withOpacity(0.1)
                : TradingColors.loss.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  isBuySide ? 'Bid' : 'Ask',
                  style: TradingTextStyles.labelSmall(
                    color: isBuySide
                        ? TradingColors.profit
                        : TradingColors.loss,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  'Price',
                  style: TradingTextStyles.caption(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  'Size',
                  style: TradingTextStyles.caption(),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        // Orders
        Expanded(
          child: orders.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(TradingSizes.md),
                    child: Text(
                      'No orders',
                      style: TradingTextStyles.bodySmall(),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: orders.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _buildOrderRow(order, isBuySide);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildOrderRow(OrderBookEntry order, bool isBuySide) {
    final totalValue = order.price * order.size;
    final depth = _calculateDepth(order, isBuySide);

    return InkWell(
      onTap: () => onOrderTap?.call(order),
      child: Builder(
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TradingSizes.sm,
            vertical: TradingSizes.xs,
          ),
          decoration: BoxDecoration(
            color: isBuySide
                ? TradingColors.profit.withOpacity(depth * 0.1)
                : TradingColors.loss.withOpacity(depth * 0.1),
          ),
          child: Row(
            children: [
              // Price
              Expanded(
                child: Text(
                  '\$${order.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isBuySide ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Size
              Expanded(
                child: Text(
                  order.size.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Total
              Expanded(
                child: Text(
                  '\$${totalValue.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateDepth(OrderBookEntry order, bool isBuySide) {
    final orders = isBuySide ? buyOrders : sellOrders;
    final index = orders.indexOf(order);
    return (index + 1) / orders.length;
  }
}

/// Order Book Entry
class OrderBookEntry {
  const OrderBookEntry({
    required this.price,
    required this.size,
    this.timestamp,
    this.orderId,
  });

  final double price;
  final double size;
  final DateTime? timestamp;
  final String? orderId;
}

/// Compact Order Book
class CompactOrderBook extends StatelessWidget {
  const CompactOrderBook({
    super.key,
    required this.buyOrders,
    required this.sellOrders,
    this.maxRows = 5,
    this.isLoading = false,
    this.onOrderTap,
  });

  final List<OrderBookEntry> buyOrders;
  final List<OrderBookEntry> sellOrders;
  final int maxRows;
  final bool isLoading;
  final Function(OrderBookEntry)? onOrderTap;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    return Container(
      padding: const EdgeInsets.all(TradingSizes.sm),
      decoration: BoxDecoration(
        color: TradingColors.surface,
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
        border: Border.all(color: TradingColors.border),
      ),
      child: Column(
        children: [
          _buildSpread(),
          const SizedBox(height: TradingSizes.sm),
          _buildOrders(),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(TradingSizes.md),
      decoration: BoxDecoration(
        color: TradingColors.surface,
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
        border: Border.all(color: TradingColors.border),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: TradingColors.primary),
      ),
    );
  }

  Widget _buildSpread() {
    if (buyOrders.isEmpty || sellOrders.isEmpty) {
      return const SizedBox.shrink();
    }

    final bestBid = buyOrders.first.price;
    final bestAsk = sellOrders.first.price;
    final spread = bestAsk - bestBid;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bid: \$${bestBid.toStringAsFixed(2)}',
          style: TradingTextStyles.bodySmall(color: TradingColors.profit),
        ),
        Text(
          'Spread: \$${spread.toStringAsFixed(2)}',
          style: TradingTextStyles.caption(),
        ),
        Text(
          'Ask: \$${bestAsk.toStringAsFixed(2)}',
          style: TradingTextStyles.bodySmall(color: TradingColors.loss),
        ),
      ],
    );
  }

  Widget _buildOrders() {
    return Row(
      children: [
        // Buy Orders
        Expanded(
          child: Column(
            children: buyOrders.take(maxRows).map((order) {
              return _buildCompactOrderRow(order, true);
            }).toList(),
          ),
        ),
        // Divider
        Container(width: 1, height: 100, color: TradingColors.border),
        // Sell Orders
        Expanded(
          child: Column(
            children: sellOrders.take(maxRows).map((order) {
              return _buildCompactOrderRow(order, false);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactOrderRow(OrderBookEntry order, bool isBuySide) {
    return InkWell(
      onTap: () => onOrderTap?.call(order),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TradingSizes.sm,
          vertical: TradingSizes.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${order.price.toStringAsFixed(2)}',
              style: TradingTextStyles.bodySmall(
                color: isBuySide ? TradingColors.profit : TradingColors.loss,
              ),
            ),
            Text(
              order.size.toStringAsFixed(2),
              style: TradingTextStyles.caption(),
            ),
          ],
        ),
      ),
    );
  }
}
