import 'package:flutter/material.dart';
import '../../theme/colors/ecommerce_colors.dart';
import '../../theme/typography/ecommerce_typography.dart';

/// Checkout Form for e-commerce apps
/// Comprehensive form for order completion
class CheckoutForm extends StatefulWidget {
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final Map<String, dynamic>? initialData;

  const CheckoutForm({
    super.key,
    this.onSubmit,
    this.onCancel,
    this.initialData,
  });

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedCountry = 'United States';
  String _selectedState = 'California';
  String _selectedPaymentMethod = 'credit_card';
  String _selectedShippingMethod = 'standard';

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _nameController.text = widget.initialData!['name'] ?? '';
      _emailController.text = widget.initialData!['email'] ?? '';
      _phoneController.text = widget.initialData!['phone'] ?? '';
      _addressController.text = widget.initialData!['address'] ?? '';
      _cityController.text = widget.initialData!['city'] ?? '';
      _zipController.text = widget.initialData!['zip'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShippingSection(),
          const SizedBox(height: 24),
          _buildPaymentSection(),
          const SizedBox(height: 24),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildShippingSection() {
    return _buildSection(
      title: 'Shipping Information',
      icon: Icons.local_shipping,
      children: [
        _buildInputRow([
          _buildTextField(
            controller: _nameController,
            label: 'Full Name',
            required: true,
            flex: 1,
          ),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            required: true,
            keyboardType: TextInputType.emailAddress,
            flex: 1,
          ),
        ]),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          required: true,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _addressController,
          label: 'Street Address',
          required: true,
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        _buildInputRow([
          _buildTextField(
            controller: _cityController,
            label: 'City',
            required: true,
            flex: 1,
          ),
          _buildDropdown(
            value: _selectedState,
            label: 'State',
            items: ['California', 'New York', 'Texas', 'Florida'],
            onChanged: (value) => setState(() => _selectedState = value!),
            flex: 1,
          ),
        ]),
        const SizedBox(height: 16),
        _buildInputRow([
          _buildTextField(
            controller: _zipController,
            label: 'ZIP Code',
            required: true,
            flex: 1,
          ),
          _buildDropdown(
            value: _selectedCountry,
            label: 'Country',
            items: ['United States', 'Canada', 'United Kingdom', 'Australia'],
            onChanged: (value) => setState(() => _selectedCountry = value!),
            flex: 1,
          ),
        ]),
        const SizedBox(height: 16),
        _buildShippingMethodSelector(),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return _buildSection(
      title: 'Payment Information',
      icon: Icons.payment,
      children: [
        _buildPaymentMethodSelector(),
        const SizedBox(height: 16),
        if (_selectedPaymentMethod == 'credit_card') ...[
          _buildTextField(
            controller: _cardNumberController,
            label: 'Card Number',
            required: true,
            keyboardType: TextInputType.number,
            hint: '1234 5678 9012 3456',
          ),
          const SizedBox(height: 16),
          _buildInputRow([
            _buildTextField(
              controller: _expiryController,
              label: 'Expiry Date',
              required: true,
              hint: 'MM/YY',
              flex: 1,
            ),
            _buildTextField(
              controller: _cvvController,
              label: 'CVV',
              required: true,
              keyboardType: TextInputType.number,
              flex: 1,
            ),
          ]),
        ] else if (_selectedPaymentMethod == 'paypal') ...[
          _buildPayPalInfo(),
        ] else if (_selectedPaymentMethod == 'apple_pay') ...[
          _buildApplePayInfo(),
        ],
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: EcommerceColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: EcommerceColors.border),
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
          Row(
            children: [
              Icon(icon, color: EcommerceColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(title, style: EcommerceTypography.sectionTitle),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputRow(List<Widget> children) {
    return Row(children: children);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool required = false,
    TextInputType? keyboardType,
    String? hint,
    int maxLines = 1,
    int flex = 2,
  }) {
    return Flexible(
      flex: flex,
      fit: FlexFit.loose,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label + (required ? ' *' : ''),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: EcommerceColors.primary),
          ),
        ),
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    int flex = 2,
  }) {
    return Flexible(
      flex: flex,
      fit: FlexFit.loose,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: EcommerceColors.primary),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildShippingMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping Method', style: EcommerceTypography.inputLabel),
        const SizedBox(height: 8),
        _buildShippingOption(
          value: 'standard',
          title: 'Standard Shipping',
          description: '5-7 business days',
          price: 5.99,
        ),
        _buildShippingOption(
          value: 'express',
          title: 'Express Shipping',
          description: '2-3 business days',
          price: 12.99,
        ),
        _buildShippingOption(
          value: 'overnight',
          title: 'Overnight Shipping',
          description: 'Next business day',
          price: 24.99,
        ),
      ],
    );
  }

  Widget _buildShippingOption({
    required String value,
    required String title,
    required String description,
    required double price,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedShippingMethod,
        onChanged: (value) => setState(() => _selectedShippingMethod = value!),
        title: Text(title, style: EcommerceTypography.optionTitle),
        subtitle: Text(
          description,
          style: EcommerceTypography.optionDescription,
        ),
        secondary: Text(
          '\$${price.toStringAsFixed(2)}',
          style: EcommerceTypography.optionPrice,
        ),
        activeColor: EcommerceColors.primary,
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: EcommerceTypography.inputLabel),
        const SizedBox(height: 8),
        _buildPaymentOption(
          value: 'credit_card',
          title: 'Credit Card',
          icon: Icons.credit_card,
        ),
        _buildPaymentOption(
          value: 'paypal',
          title: 'PayPal',
          icon: Icons.account_balance_wallet,
        ),
        _buildPaymentOption(
          value: 'apple_pay',
          title: 'Apple Pay',
          icon: Icons.phone_iphone,
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
        title: Text(title, style: EcommerceTypography.optionTitle),
        secondary: Icon(icon, color: EcommerceColors.primary),
        activeColor: EcommerceColors.primary,
      ),
    );
  }

  Widget _buildPayPalInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EcommerceColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: EcommerceColors.info.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: EcommerceColors.info, size: 20),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              'You will be redirected to PayPal to complete your payment.',
              style: EcommerceTypography.infoText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplePayInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EcommerceColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: EcommerceColors.success.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.phone_iphone, color: EcommerceColors.success, size: 20),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              'Use Touch ID or Face ID to complete your payment.',
              style: EcommerceTypography.infoText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: OutlinedButton(
            onPressed: widget.onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: EcommerceColors.primary,
              side: BorderSide(color: EcommerceColors.border),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Cancel', style: EcommerceTypography.buttonText),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: EcommerceColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Complete Order',
              style: EcommerceTypography.buttonText.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call();
    }
  }
}
