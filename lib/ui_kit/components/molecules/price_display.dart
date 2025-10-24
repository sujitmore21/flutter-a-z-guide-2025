import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../core/constants/app_styles/trading_text_styles.dart';

/// Price Display Component
/// A specialized component for displaying trading prices with profit/loss indicators
class PriceDisplay extends StatelessWidget {
  const PriceDisplay({
    super.key,
    required this.price,
    this.change,
    this.changePercent,
    this.size = PriceDisplaySize.medium,
    this.showChange = true,
    this.showPercent = true,
    this.currency = '\$',
    this.decimals = 2,
    this.isLoading = false,
  });

  final double price;
  final double? change;
  final double? changePercent;
  final PriceDisplaySize size;
  final bool showChange;
  final bool showPercent;
  final String currency;
  final int decimals;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPrice(),
        if (showChange && (change != null || changePercent != null)) ...[
          const SizedBox(height: TradingSizes.xs),
          _buildChange(),
        ],
      ],
    );
  }

  Widget _buildPrice() {
    return Text('${_formatCurrency(price)}', style: _getPriceTextStyle());
  }

  Widget _buildChange() {
    final isPositive = (change ?? 0) >= 0;
    final changeText = change != null ? _formatCurrency(change!) : '';
    final percentText = changePercent != null
        ? '${_formatPercent(changePercent!)}'
        : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPositive ? Icons.trending_up : Icons.trending_down,
          size: _getIconSize(),
          color: isPositive ? TradingColors.profit : TradingColors.loss,
        ),
        const SizedBox(width: TradingSizes.xs),
        Text(changeText, style: _getChangeTextStyle(isPositive)),
        if (showPercent && changePercent != null) ...[
          const SizedBox(width: TradingSizes.xs),
          Text('($percentText)', style: _getChangeTextStyle(isPositive)),
        ],
      ],
    );
  }

  Widget _buildLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: _getPriceHeight(),
          width: _getPriceWidth(),
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
          ),
        ),
        const SizedBox(height: TradingSizes.xs),
        Container(
          height: _getChangeHeight(),
          width: _getChangeWidth(),
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double value) {
    return '$currency${value.toStringAsFixed(decimals)}';
  }

  String _formatPercent(double value) {
    return '${value >= 0 ? '+' : ''}${value.toStringAsFixed(2)}%';
  }

  TextStyle _getPriceTextStyle() {
    switch (size) {
      case PriceDisplaySize.small:
        return TradingTextStyles.priceSmall();
      case PriceDisplaySize.medium:
        return TradingTextStyles.priceMedium();
      case PriceDisplaySize.large:
        return TradingTextStyles.priceLarge();
      case PriceDisplaySize.extraLarge:
        return TradingTextStyles.priceLarge();
    }
  }

  TextStyle _getChangeTextStyle(bool isPositive) {
    final baseStyle = switch (size) {
      PriceDisplaySize.small => TradingTextStyles.bodySmall(),
      PriceDisplaySize.medium => TradingTextStyles.bodyMedium(),
      PriceDisplaySize.large => TradingTextStyles.bodyLarge(),
      PriceDisplaySize.extraLarge => TradingTextStyles.titleSmall(),
    };

    return baseStyle.copyWith(
      color: isPositive ? TradingColors.profit : TradingColors.loss,
      fontWeight: FontWeight.w600,
    );
  }

  double _getIconSize() {
    switch (size) {
      case PriceDisplaySize.small:
        return TradingSizes.iconXs;
      case PriceDisplaySize.medium:
        return TradingSizes.iconSm;
      case PriceDisplaySize.large:
        return TradingSizes.iconMd;
      case PriceDisplaySize.extraLarge:
        return TradingSizes.iconLg;
    }
  }

  double _getPriceHeight() {
    switch (size) {
      case PriceDisplaySize.small:
        return 16.0;
      case PriceDisplaySize.medium:
        return 20.0;
      case PriceDisplaySize.large:
        return 24.0;
      case PriceDisplaySize.extraLarge:
        return 32.0;
    }
  }

  double _getPriceWidth() {
    switch (size) {
      case PriceDisplaySize.small:
        return 60.0;
      case PriceDisplaySize.medium:
        return 80.0;
      case PriceDisplaySize.large:
        return 100.0;
      case PriceDisplaySize.extraLarge:
        return 120.0;
    }
  }

  double _getChangeHeight() {
    switch (size) {
      case PriceDisplaySize.small:
        return 12.0;
      case PriceDisplaySize.medium:
        return 14.0;
      case PriceDisplaySize.large:
        return 16.0;
      case PriceDisplaySize.extraLarge:
        return 18.0;
    }
  }

  double _getChangeWidth() {
    switch (size) {
      case PriceDisplaySize.small:
        return 40.0;
      case PriceDisplaySize.medium:
        return 60.0;
      case PriceDisplaySize.large:
        return 80.0;
      case PriceDisplaySize.extraLarge:
        return 100.0;
    }
  }
}

/// Price Display Sizes
enum PriceDisplaySize { small, medium, large, extraLarge }

/// Compact Price Display
class CompactPriceDisplay extends StatelessWidget {
  const CompactPriceDisplay({
    super.key,
    required this.price,
    this.change,
    this.changePercent,
    this.currency = '\$',
    this.decimals = 2,
    this.isLoading = false,
  });

  final double price;
  final double? change;
  final double? changePercent;
  final String currency;
  final int decimals;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 16.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: TradingColors.surfaceLight,
              borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
            ),
          ),
          const SizedBox(width: TradingSizes.sm),
          Container(
            height: 12.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: TradingColors.surfaceLight,
              borderRadius: BorderRadius.circular(TradingSizes.radiusXs),
            ),
          ),
        ],
      );
    }

    final isPositive = (change ?? 0) >= 0;
    final changeText = change != null ? _formatCurrency(change!) : '';
    final percentText = changePercent != null
        ? '${_formatPercent(changePercent!)}'
        : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${_formatCurrency(price)}',
          style: TradingTextStyles.priceMedium(),
        ),
        if (change != null || changePercent != null) ...[
          const SizedBox(width: TradingSizes.sm),
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: TradingSizes.iconSm,
            color: isPositive ? TradingColors.profit : TradingColors.loss,
          ),
          const SizedBox(width: TradingSizes.xs),
          Text(
            changeText,
            style: TradingTextStyles.bodySmall().copyWith(
              color: isPositive ? TradingColors.profit : TradingColors.loss,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (changePercent != null) ...[
            const SizedBox(width: TradingSizes.xs),
            Text(
              '($percentText)',
              style: TradingTextStyles.bodySmall().copyWith(
                color: isPositive ? TradingColors.profit : TradingColors.loss,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ],
    );
  }

  String _formatCurrency(double value) {
    return '$currency${value.toStringAsFixed(decimals)}';
  }

  String _formatPercent(double value) {
    return '${value >= 0 ? '+' : ''}${value.toStringAsFixed(2)}%';
  }
}
