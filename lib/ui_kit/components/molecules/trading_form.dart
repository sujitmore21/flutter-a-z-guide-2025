import 'package:flutter/material.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';
import '../../../core/constants/app_styles/trading_text_styles.dart';
import '../atoms/trading_button.dart';
import '../atoms/trading_input.dart';

/// Trading Form Component
/// A comprehensive form component for trading applications
class TradingForm extends StatefulWidget {
  const TradingForm({
    super.key,
    required this.fields,
    this.title,
    this.subtitle,
    this.submitButtonText = 'Submit',
    this.cancelButtonText = 'Cancel',
    this.onSubmit,
    this.onCancel,
    this.isLoading = false,
    this.isValid = true,
    this.errorMessage,
    this.successMessage,
  });

  final List<TradingFormField> fields;
  final String? title;
  final String? subtitle;
  final String submitButtonText;
  final String cancelButtonText;
  final Function(Map<String, dynamic>)? onSubmit;
  final VoidCallback? onCancel;
  final bool isLoading;
  final bool isValid;
  final String? errorMessage;
  final String? successMessage;

  @override
  State<TradingForm> createState() => _TradingFormState();
}

class _TradingFormState extends State<TradingForm> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _errors = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _initializeControllers() {
    for (final field in widget.fields) {
      _controllers[field.key] = TextEditingController(text: field.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.subtitle != null) ...[
            _buildHeader(),
            const SizedBox(height: TradingSizes.lg),
          ],
          _buildFields(),
          const SizedBox(height: TradingSizes.lg),
          _buildMessages(),
          const SizedBox(height: TradingSizes.md),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: TradingTextStyles.headlineSmall()),
        if (widget.subtitle != null) ...[
          const SizedBox(height: TradingSizes.sm),
          Text(
            widget.subtitle!,
            style: TradingTextStyles.bodyMedium(
              color: TradingColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      children: widget.fields.map((field) {
        return Padding(
          padding: const EdgeInsets.only(bottom: TradingSizes.md),
          child: _buildField(field),
        );
      }).toList(),
    );
  }

  Widget _buildField(TradingFormField field) {
    switch (field.type) {
      case TradingFormFieldType.text:
        return TradingInput(
          label: field.label,
          hint: field.hint,
          prefix: field.prefix,
          suffix: field.suffix,
          controller: _controllers[field.key],
          validator: (value) => _validateField(field, value),
          onChanged: (value) => _onFieldChanged(field.key, value),
          keyboardType: field.keyboardType,
          obscureText: field.obscureText,
          enabled: field.enabled,
          readOnly: field.readOnly,
          maxLines: field.maxLines,
          maxLength: field.maxLength,
          size: field.size,
          variant: field.variant,
          isLoading: field.isLoading,
          errorText: _errors[field.key],
          helperText: field.helperText,
        );
      case TradingFormFieldType.number:
        return TradingNumberInput(
          label: field.label,
          hint: field.hint,
          prefix: field.prefix,
          suffix: field.suffix,
          controller: _controllers[field.key],
          validator: (value) => _validateField(field, value),
          onChanged: (value) => _onFieldChanged(field.key, value),
          decimals: field.decimals ?? 2,
          min: field.min,
          max: field.max,
          step: field.step,
          enabled: field.enabled,
          readOnly: field.readOnly,
          size: field.size,
          variant: field.variant,
          isLoading: field.isLoading,
          errorText: _errors[field.key],
          helperText: field.helperText,
        );
      case TradingFormFieldType.select:
        return _buildSelectField(field);
      case TradingFormFieldType.checkbox:
        return _buildCheckboxField(field);
      case TradingFormFieldType.switchField:
        return _buildSwitchField(field);
    }
  }

  Widget _buildSelectField(TradingFormField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.label != null) ...[
          Text(field.label!, style: TradingTextStyles.labelMedium()),
          const SizedBox(height: TradingSizes.sm),
        ],
        Container(
          height: _getInputHeight(field.size),
          padding: const EdgeInsets.symmetric(horizontal: TradingSizes.md),
          decoration: BoxDecoration(
            color: TradingColors.surfaceLight,
            borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
            border: Border.all(color: TradingColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _controllers[field.key]?.text,
              isExpanded: true,
              items: field.options?.map((option) {
                return DropdownMenuItem<String>(
                  value: option.value,
                  child: Text(option.label),
                );
              }).toList(),
              onChanged: field.enabled
                  ? (value) {
                      if (value != null) {
                        _controllers[field.key]?.text = value;
                        _onFieldChanged(field.key, value);
                      }
                    }
                  : null,
            ),
          ),
        ),
        if (_errors[field.key] != null) ...[
          const SizedBox(height: TradingSizes.xs),
          Text(
            _errors[field.key]!,
            style: TradingTextStyles.caption(color: TradingColors.error),
          ),
        ],
      ],
    );
  }

  Widget _buildCheckboxField(TradingFormField field) {
    return Row(
      children: [
        Checkbox(
          value: _controllers[field.key]?.text == 'true',
          onChanged: field.enabled
              ? (value) {
                  _controllers[field.key]?.text = value.toString();
                  _onFieldChanged(field.key, value.toString());
                }
              : null,
        ),
        const SizedBox(width: TradingSizes.sm),
        Expanded(
          child: Text(field.label ?? '', style: TradingTextStyles.bodyMedium()),
        ),
      ],
    );
  }

  Widget _buildSwitchField(TradingFormField field) {
    return Row(
      children: [
        Switch(
          value: _controllers[field.key]?.text == 'true',
          onChanged: field.enabled
              ? (value) {
                  _controllers[field.key]?.text = value.toString();
                  _onFieldChanged(field.key, value.toString());
                }
              : null,
        ),
        const SizedBox(width: TradingSizes.sm),
        Expanded(
          child: Text(field.label ?? '', style: TradingTextStyles.bodyMedium()),
        ),
      ],
    );
  }

  Widget _buildMessages() {
    if (widget.errorMessage != null) {
      return Container(
        padding: const EdgeInsets.all(TradingSizes.md),
        decoration: BoxDecoration(
          color: TradingColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          border: Border.all(color: TradingColors.error.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: TradingColors.error,
              size: TradingSizes.iconSm,
            ),
            const SizedBox(width: TradingSizes.sm),
            Expanded(
              child: Text(
                widget.errorMessage!,
                style: TradingTextStyles.bodySmall(color: TradingColors.error),
              ),
            ),
          ],
        ),
      );
    }

    if (widget.successMessage != null) {
      return Container(
        padding: const EdgeInsets.all(TradingSizes.md),
        decoration: BoxDecoration(
          color: TradingColors.success.withOpacity(0.1),
          borderRadius: BorderRadius.circular(TradingSizes.radiusSm),
          border: Border.all(color: TradingColors.success.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: TradingColors.success,
              size: TradingSizes.iconSm,
            ),
            const SizedBox(width: TradingSizes.sm),
            Expanded(
              child: Text(
                widget.successMessage!,
                style: TradingTextStyles.bodySmall(
                  color: TradingColors.success,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildButtons() {
    return Row(
      children: [
        if (widget.onCancel != null) ...[
          Expanded(
            child: TradingButton(
              text: widget.cancelButtonText,
              onPressed: widget.onCancel,
              variant: TradingButtonVariant.secondary,
              isFullWidth: true,
            ),
          ),
          const SizedBox(width: TradingSizes.md),
        ],
        Expanded(
          child: TradingButton(
            text: widget.submitButtonText,
            onPressed: widget.isValid ? _handleSubmit : null,
            variant: TradingButtonVariant.primary,
            isFullWidth: true,
            isLoading: widget.isLoading,
          ),
        ),
      ],
    );
  }

  double _getInputHeight(TradingInputSize size) {
    switch (size) {
      case TradingInputSize.small:
        return TradingSizes.inputHeightSm;
      case TradingInputSize.medium:
        return TradingSizes.inputHeightMd;
      case TradingInputSize.large:
        return TradingSizes.inputHeightLg;
    }
  }

  String? _validateField(TradingFormField field, String? value) {
    if (field.required && (value == null || value.isEmpty)) {
      return '${field.label} is required';
    }

    if (field.validator != null) {
      return field.validator!(value);
    }

    return null;
  }

  void _onFieldChanged(String key, String value) {
    setState(() {
      _errors.remove(key);
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = <String, dynamic>{};
      for (final field in widget.fields) {
        formData[field.key] = _controllers[field.key]?.text;
      }
      widget.onSubmit?.call(formData);
    }
  }
}

/// Trading Form Field
class TradingFormField {
  const TradingFormField({
    required this.key,
    required this.type,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines,
    this.maxLength,
    this.size = TradingInputSize.medium,
    this.variant = TradingInputVariant.outlined,
    this.isLoading = false,
    this.helperText,
    this.required = false,
    this.options,
    this.decimals,
    this.min,
    this.max,
    this.step,
  });

  final String key;
  final TradingFormFieldType type;
  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TradingInputSize size;
  final TradingInputVariant variant;
  final bool isLoading;
  final String? helperText;
  final bool required;
  final List<TradingFormOption>? options;
  final int? decimals;
  final double? min;
  final double? max;
  final double? step;
}

/// Trading Form Field Types
enum TradingFormFieldType { text, number, select, checkbox, switchField }

/// Trading Form Option
class TradingFormOption {
  const TradingFormOption({required this.value, required this.label});

  final String value;
  final String label;
}
