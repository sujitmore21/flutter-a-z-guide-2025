import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';

/// Trading Card Component
/// A customizable card component for trading applications
class TradingCard extends StatelessWidget {
  const TradingCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.isClickable = false,
    this.variant = TradingCardVariant.defaultCard,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool isClickable;
  final TradingCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final cardWidget = Card(
      elevation: elevation ?? _getDefaultElevation(),
      shadowColor: Colors.black26,
      color: backgroundColor ?? _getDefaultBackgroundColor(context),
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(TradingSizes.radiusMd),
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: borderWidth ?? 1.0)
            : BorderSide.none,
      ),
      margin: margin ?? const EdgeInsets.all(TradingSizes.sm),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(TradingSizes.md),
        child: child,
      ),
    );

    if (isClickable && onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius:
            borderRadius ?? BorderRadius.circular(TradingSizes.radiusMd),
        child: cardWidget,
      );
    }

    return cardWidget;
  }

  double _getDefaultElevation() {
    switch (variant) {
      case TradingCardVariant.defaultCard:
        return 2.0;
      case TradingCardVariant.elevated:
        return 4.0;
      case TradingCardVariant.flat:
        return 0.0;
      case TradingCardVariant.outlined:
        return 0.0;
    }
  }

  Color _getDefaultBackgroundColor(BuildContext context) {
    switch (variant) {
      case TradingCardVariant.defaultCard:
        return Theme.of(context).cardColor;
      case TradingCardVariant.elevated:
        return Theme.of(context).cardColor;
      case TradingCardVariant.flat:
        return Theme.of(context).cardColor;
      case TradingCardVariant.outlined:
        return Colors.transparent;
    }
  }
}

/// Trading Card Variants
enum TradingCardVariant { defaultCard, elevated, flat, outlined }

/// Trading Card with Header
class TradingCardWithHeader extends StatelessWidget {
  const TradingCardWithHeader({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.action,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.isClickable = false,
    this.variant = TradingCardVariant.defaultCard,
  });

  final String title;
  final Widget child;
  final String? subtitle;
  final Widget? action;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool isClickable;
  final TradingCardVariant variant;

  @override
  Widget build(BuildContext context) {
    return TradingCard(
      padding: EdgeInsets.zero,
      margin: margin,
      elevation: elevation,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      isClickable: isClickable,
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: padding ?? const EdgeInsets.all(TradingSizes.md),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TradingSizes.md),
      decoration: BoxDecoration(
        color: TradingColors.surfaceLight,
        borderRadius: BorderRadius.only(
          topLeft:
              borderRadius?.topLeft ?? Radius.circular(TradingSizes.radiusMd),
          topRight:
              borderRadius?.topRight ?? Radius.circular(TradingSizes.radiusMd),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: TradingSizes.xs),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// Trading Card with Icon
class TradingCardWithIcon extends StatelessWidget {
  const TradingCardWithIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.subtitle,
    this.iconColor,
    this.iconBackgroundColor,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.isClickable = false,
    this.variant = TradingCardVariant.defaultCard,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final String? subtitle;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool isClickable;
  final TradingCardVariant variant;

  @override
  Widget build(BuildContext context) {
    return TradingCard(
      padding: EdgeInsets.zero,
      margin: margin,
      elevation: elevation,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      isClickable: isClickable,
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: padding ?? const EdgeInsets.all(TradingSizes.md),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TradingSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.only(
          topLeft:
              borderRadius?.topLeft ?? Radius.circular(TradingSizes.radiusMd),
          topRight:
              borderRadius?.topRight ?? Radius.circular(TradingSizes.radiusMd),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(TradingSizes.sm),
            decoration: BoxDecoration(
              color:
                  iconBackgroundColor ?? Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
            ),
            child: Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
              size: TradingSizes.iconMd,
            ),
          ),
          const SizedBox(width: TradingSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: TradingSizes.xs),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
