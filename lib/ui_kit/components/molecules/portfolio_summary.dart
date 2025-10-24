import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../core/constants/app_styles/trading_text_styles.dart';
import '../atoms/trading_card.dart';

/// Portfolio Summary Component
/// Displays portfolio overview with key metrics
class PortfolioSummary extends StatelessWidget {
  const PortfolioSummary({
    super.key,
    required this.totalValue,
    required this.totalChange,
    required this.totalChangePercent,
    this.availableBalance,
    this.investedAmount,
    this.dayChange,
    this.dayChangePercent,
    this.isLoading = false,
    this.onTap,
  });

  final double totalValue;
  final double totalChange;
  final double totalChangePercent;
  final double? availableBalance;
  final double? investedAmount;
  final double? dayChange;
  final double? dayChangePercent;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TradingCard(
      onTap: onTap,
      isClickable: onTap != null,
      child: isLoading ? _buildLoadingState() : _buildContent(),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 24,
          width: 120,
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
          ),
        ),
        const SizedBox(height: TradingSizes.sm),
        Container(
          height: 16,
          width: 80,
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
          ),
        ),
        const SizedBox(height: TradingSizes.md),
        Row(
          children: [
            Expanded(child: _buildLoadingMetric()),
            const SizedBox(width: TradingSizes.md),
            Expanded(child: _buildLoadingMetric()),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingMetric() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 12,
          width: 60,
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
          ),
        ),
        const SizedBox(height: TradingSizes.xs),
        Container(
          height: 10,
          width: 40,
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    final isPositive = totalChange >= 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainValue(),
        const SizedBox(height: TradingSizes.sm),
        _buildChangeIndicator(isPositive),
        if (availableBalance != null || investedAmount != null) ...[
          const SizedBox(height: TradingSizes.md),
          _buildAdditionalMetrics(),
        ],
        if (dayChange != null && dayChangePercent != null) ...[
          const SizedBox(height: TradingSizes.sm),
          _buildDayChange(),
        ],
      ],
    );
  }

  Widget _buildMainValue() {
    return Builder(
      builder: (context) => Row(
        children: [
          Text(
            'Portfolio Value',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            '\$${totalValue.toStringAsFixed(2)}',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeIndicator(bool isPositive) {
    return Builder(
      builder: (context) => Row(
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: TradingSizes.iconSm,
            color: isPositive ? TradingColors.profit : TradingColors.loss,
          ),
          const SizedBox(width: TradingSizes.xs),
          Text(
            '${isPositive ? '+' : ''}\$${totalChange.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: TradingSizes.sm),
          Text(
            '(${isPositive ? '+' : ''}${totalChangePercent.toStringAsFixed(2)}%)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalMetrics() {
    return Builder(
      builder: (context) => Row(
        children: [
          if (availableBalance != null) ...[
            Expanded(
              child: _buildMetric(
                'Available',
                '\$${availableBalance!.toStringAsFixed(2)}',
                Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(width: TradingSizes.md),
          ],
          if (investedAmount != null)
            Expanded(
              child: _buildMetric(
                'Invested',
                '\$${investedAmount!.toStringAsFixed(2)}',
                Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDayChange() {
    final isPositive = (dayChange ?? 0) >= 0;

    return Row(
      children: [
        Text('Today: ', style: TradingTextStyles.bodySmall()),
        Text(
          '${isPositive ? '+' : ''}\$${dayChange!.toStringAsFixed(2)}',
          style: TradingTextStyles.bodySmall(
            color: isPositive ? TradingColors.profit : TradingColors.loss,
          ),
        ),
        const SizedBox(width: TradingSizes.sm),
        Text(
          '(${isPositive ? '+' : ''}${dayChangePercent!.toStringAsFixed(2)}%)',
          style: TradingTextStyles.bodySmall(
            color: isPositive ? TradingColors.profit : TradingColors.loss,
          ),
        ),
      ],
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: TradingSizes.xs),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Portfolio Holdings List
class PortfolioHoldings extends StatelessWidget {
  const PortfolioHoldings({
    super.key,
    required this.holdings,
    this.title = 'Holdings',
    this.isLoading = false,
    this.onHoldingTap,
    this.onViewAll,
  });

  final List<PortfolioHolding> holdings;
  final String title;
  final bool isLoading;
  final Function(PortfolioHolding)? onHoldingTap;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return TradingCardWithHeader(
      title: title,
      action: onViewAll != null
          ? TextButton(onPressed: onViewAll, child: const Text('View All'))
          : null,
      child: isLoading ? _buildLoadingState() : _buildHoldingsList(),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: List.generate(3, (index) => _buildLoadingHolding()),
    );
  }

  Widget _buildLoadingHolding() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: TradingSizes.sm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: TradingColors.surfaceLight,
              borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
            ),
          ),
          const SizedBox(width: TradingSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 80,
                  decoration: BoxDecoration(
                    color: TradingColors.surfaceLight,
                    borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
                  ),
                ),
                const SizedBox(height: TradingSizes.xs),
                Container(
                  height: 12,
                  width: 60,
                  decoration: BoxDecoration(
                    color: TradingColors.surfaceLight,
                    borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 16,
            width: 60,
            decoration: BoxDecoration(
              color: TradingColors.surfaceLight,
              borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingsList() {
    if (holdings.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: holdings.map((holding) {
        return _buildHoldingItem(holding);
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: TradingSizes.xl),
          Icon(
            Icons.wallet_outlined,
            size: TradingSizes.iconXxl,
            color: TradingColors.textTertiary,
          ),
          const SizedBox(height: TradingSizes.md),
          Text(
            'No holdings yet',
            style: TradingTextStyles.bodyMedium(
              color: TradingColors.textTertiary,
            ),
          ),
          const SizedBox(height: TradingSizes.sm),
          Text(
            'Start trading to see your portfolio here',
            style: TradingTextStyles.bodySmall(
              color: TradingColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingItem(PortfolioHolding holding) {
    final isPositive = holding.change >= 0;

    return InkWell(
      onTap: () => onHoldingTap?.call(holding),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: TradingSizes.sm),
        child: Row(
          children: [
            // Asset Icon/Logo
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: TradingColors.surfaceLight,
                borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
              ),
              child: Icon(
                Icons.currency_bitcoin,
                color: TradingColors.primary,
                size: TradingSizes.iconMd,
              ),
            ),
            const SizedBox(width: TradingSizes.md),
            // Asset Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(holding.symbol, style: TradingTextStyles.bodyMedium()),
                  Text(
                    '${holding.quantity.toStringAsFixed(4)} ${holding.symbol}',
                    style: TradingTextStyles.bodySmall(
                      color: TradingColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            // Value and Change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${holding.value.toStringAsFixed(2)}',
                  style: TradingTextStyles.bodyMedium(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: TradingSizes.iconXs,
                      color: isPositive
                          ? TradingColors.profit
                          : TradingColors.loss,
                    ),
                    const SizedBox(width: TradingSizes.xs),
                    Text(
                      '${isPositive ? '+' : ''}\$${holding.change.toStringAsFixed(2)}',
                      style: TradingTextStyles.bodySmall(
                        color: isPositive
                            ? TradingColors.profit
                            : TradingColors.loss,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Portfolio Holding Model
class PortfolioHolding {
  const PortfolioHolding({
    required this.symbol,
    required this.quantity,
    required this.value,
    required this.change,
    required this.changePercent,
    this.name,
    this.price,
  });

  final String symbol;
  final String? name;
  final double quantity;
  final double value;
  final double change;
  final double changePercent;
  final double? price;
}
