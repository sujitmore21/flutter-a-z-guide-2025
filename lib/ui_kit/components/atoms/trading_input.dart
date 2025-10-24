import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../core/constants/app_styles/trading_text_styles.dart';

/// Trading Input Component
/// A specialized input component for trading applications
class TradingInput extends StatefulWidget {
  const TradingInput({
    super.key,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.decoration,
    this.size = TradingInputSize.medium,
    this.variant = TradingInputVariant.outlined,
    this.isLoading = false,
    this.errorText,
    this.helperText,
  });

  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final InputDecoration? decoration;
  final TradingInputSize size;
  final TradingInputVariant variant;
  final bool isLoading;
  final String? errorText;
  final String? helperText;

  @override
  State<TradingInput> createState() => _TradingInputState();
}

class _TradingInputState extends State<TradingInput> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Focus state handling if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: TradingTextStyles.labelMedium()),
          const SizedBox(height: TradingSizes.sm),
        ],
        _buildInput(),
        if (widget.helperText != null && widget.errorText == null) ...[
          const SizedBox(height: TradingSizes.xs),
          Text(widget.helperText!, style: TradingTextStyles.caption()),
        ],
        if (widget.errorText != null) ...[
          const SizedBox(height: TradingSizes.xs),
          Text(
            widget.errorText!,
            style: TradingTextStyles.caption(color: TradingColors.error),
          ),
        ],
      ],
    );
  }

  Widget _buildInput() {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      enabled: widget.enabled && !widget.isLoading,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      style: _getTextStyle(),
      decoration: _getInputDecoration(),
    );
  }

  TextStyle _getTextStyle() {
    switch (widget.size) {
      case TradingInputSize.small:
        return TradingTextStyles.bodySmall();
      case TradingInputSize.medium:
        return TradingTextStyles.bodyMedium();
      case TradingInputSize.large:
        return TradingTextStyles.bodyLarge();
    }
  }

  InputDecoration _getInputDecoration() {
    final baseDecoration = InputDecoration(
      hintText: widget.hint,
      prefixIcon: widget.prefix,
      suffixIcon: widget.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: TradingColors.primary,
                  ),
                ),
              ),
            )
          : widget.suffix,
      border: _getBorder(),
      enabledBorder: _getBorder(),
      focusedBorder: _getFocusedBorder(),
      errorBorder: _getErrorBorder(),
      focusedErrorBorder: _getErrorBorder(),
      disabledBorder: _getDisabledBorder(),
      contentPadding: _getContentPadding(),
      hintStyle: TradingTextStyles.bodyMedium(
        color: TradingColors.textTertiary,
      ),
    );

    return widget.decoration != null
        ? baseDecoration.copyWith(
            // Merge with custom decoration
          )
        : baseDecoration;
  }

  InputBorder _getBorder() {
    switch (widget.variant) {
      case TradingInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.border),
        );
      case TradingInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: BorderSide.none,
        );
      case TradingInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: const BorderSide(color: TradingColors.border),
        );
    }
  }

  InputBorder _getFocusedBorder() {
    switch (widget.variant) {
      case TradingInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.primary, width: 2),
        );
      case TradingInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.primary, width: 2),
        );
      case TradingInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: const BorderSide(color: TradingColors.primary, width: 2),
        );
    }
  }

  InputBorder _getErrorBorder() {
    switch (widget.variant) {
      case TradingInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.error),
        );
      case TradingInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.error),
        );
      case TradingInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: const BorderSide(color: TradingColors.error),
        );
    }
  }

  InputBorder _getDisabledBorder() {
    switch (widget.variant) {
      case TradingInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: const BorderSide(color: TradingColors.borderDark),
        );
      case TradingInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          borderSide: BorderSide.none,
        );
      case TradingInputVariant.underlined:
        return UnderlineInputBorder(
          borderSide: const BorderSide(color: TradingColors.borderDark),
        );
    }
  }

  EdgeInsets _getContentPadding() {
    switch (widget.size) {
      case TradingInputSize.small:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.sm,
          vertical: TradingSizes.xs,
        );
      case TradingInputSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.md,
          vertical: TradingSizes.sm,
        );
      case TradingInputSize.large:
        return const EdgeInsets.symmetric(
          horizontal: TradingSizes.md,
          vertical: TradingSizes.md,
        );
    }
  }
}

/// Trading Input Sizes
enum TradingInputSize { small, medium, large }

/// Trading Input Variants
enum TradingInputVariant { outlined, filled, underlined }

/// Trading Number Input
class TradingNumberInput extends StatelessWidget {
  const TradingNumberInput({
    super.key,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.decimals = 2,
    this.min,
    this.max,
    this.step,
    this.enabled = true,
    this.readOnly = false,
    this.size = TradingInputSize.medium,
    this.variant = TradingInputVariant.outlined,
    this.isLoading = false,
    this.errorText,
    this.helperText,
  });

  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int decimals;
  final double? min;
  final double? max;
  final double? step;
  final bool enabled;
  final bool readOnly;
  final TradingInputSize size;
  final TradingInputVariant variant;
  final bool isLoading;
  final String? errorText;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return TradingInput(
      label: label,
      hint: hint,
      prefix: prefix,
      suffix: suffix,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      enabled: enabled,
      readOnly: readOnly,
      size: size,
      variant: variant,
      isLoading: isLoading,
      errorText: errorText,
      helperText: helperText,
    );
  }
}
