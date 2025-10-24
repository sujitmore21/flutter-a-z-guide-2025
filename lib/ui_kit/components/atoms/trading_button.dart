import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../core/constants/app_styles/trading_text_styles.dart';

/// Trading Button Component
/// A customizable button component for trading applications
class TradingButton extends StatelessWidget {
  const TradingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = TradingButtonVariant.primary,
    this.size = TradingButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconPosition = TradingButtonIconPosition.left,
    this.disabled = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final TradingButtonVariant variant;
  final TradingButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final TradingButtonIconPosition iconPosition;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || onPressed == null || isLoading;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getHeight(),
      child: _buildButton(isDisabled),
    );
  }

  Widget _buildButton(bool isDisabled) {
    switch (variant) {
      case TradingButtonVariant.primary:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: _getPrimaryStyle(),
          child: _buildButtonContent(),
        );
      case TradingButtonVariant.secondary:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: _getSecondaryStyle(),
          child: _buildButtonContent(),
        );
      case TradingButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: _getTextButtonStyle(),
          child: _buildButtonContent(),
        );
      case TradingButtonVariant.success:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: _getSuccessStyle(),
          child: _buildButtonContent(),
        );
      case TradingButtonVariant.danger:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: _getDangerStyle(),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == TradingButtonVariant.primary ||
                    variant == TradingButtonVariant.success ||
                    variant == TradingButtonVariant.danger
                ? TradingColors.textPrimary
                : TradingColors.primary,
          ),
        ),
      );
    }

    final textWidget = Text(text, style: _getTextStyle());

    if (icon == null) {
      return textWidget;
    }

    if (iconPosition == TradingButtonIconPosition.left) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: TradingSizes.sm),
          Flexible(child: textWidget),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: textWidget),
          const SizedBox(width: TradingSizes.sm),
          Icon(icon, size: _getIconSize()),
        ],
      );
    }
  }

  double _getHeight() {
    switch (size) {
      case TradingButtonSize.small:
        return TradingSizes.buttonHeightSm;
      case TradingButtonSize.medium:
        return TradingSizes.buttonHeightMd;
      case TradingButtonSize.large:
        return TradingSizes.buttonHeightLg;
      case TradingButtonSize.extraLarge:
        return TradingSizes.buttonHeightXl;
    }
  }

  double _getIconSize() {
    switch (size) {
      case TradingButtonSize.small:
        return TradingSizes.iconSm;
      case TradingButtonSize.medium:
        return TradingSizes.iconMd;
      case TradingButtonSize.large:
        return TradingSizes.iconLg;
      case TradingButtonSize.extraLarge:
        return TradingSizes.iconXl;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case TradingButtonSize.small:
        return TradingTextStyles.labelMedium();
      case TradingButtonSize.medium:
        return TradingTextStyles.labelLarge();
      case TradingButtonSize.large:
        return TradingTextStyles.titleSmall();
      case TradingButtonSize.extraLarge:
        return TradingTextStyles.titleMedium();
    }
  }

  ButtonStyle _getPrimaryStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: TradingColors.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
      ),
      padding: _getPadding(),
    );
  }

  ButtonStyle _getSecondaryStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: TradingColors.primary,
      side: const BorderSide(color: TradingColors.border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
      ),
      padding: _getPadding(),
    );
  }

  ButtonStyle _getTextButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: TradingColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
      ),
      padding: _getPadding(),
    );
  }

  ButtonStyle _getSuccessStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: TradingColors.success,
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
      ),
      padding: _getPadding(),
    );
  }

  ButtonStyle _getDangerStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: TradingColors.error,
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
      ),
      padding: _getPadding(),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case TradingButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.md,
          vertical: TradingSizes.sm,
        );
      case TradingButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.lg,
          vertical: TradingSizes.md,
        );
      case TradingButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.xl,
          vertical: TradingSizes.lg,
        );
      case TradingButtonSize.extraLarge:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.xxl,
          vertical: TradingSizes.xl,
        );
    }
  }
}

/// Trading Button Variants
enum TradingButtonVariant { primary, secondary, text, success, danger }

/// Trading Button Sizes
enum TradingButtonSize { small, medium, large, extraLarge }

/// Trading Button Icon Position
enum TradingButtonIconPosition { left, right }
