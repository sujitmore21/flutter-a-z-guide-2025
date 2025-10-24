import 'package:flutter/material.dart';
import '../../theme/colors/finance_colors.dart';
import '../../theme/typography/finance_typography.dart';

/// Payment Method Card for digital wallets and payment apps
/// Displays payment methods with quick actions
class PaymentMethodCard extends StatelessWidget {
  final PaymentMethodType type;
  final String name;
  final String? cardNumber;
  final String? expiryDate;
  final bool isDefault;
  final VoidCallback? onTap;
  final VoidCallback? onSetDefault;
  final VoidCallback? onDelete;

  const PaymentMethodCard({
    super.key,
    required this.type,
    required this.name,
    this.cardNumber,
    this.expiryDate,
    this.isDefault = false,
    this.onTap,
    this.onSetDefault,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: FinanceColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isDefault ? FinanceColors.primary : FinanceColors.border,
          width: isDefault ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildPaymentIcon(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name, style: FinanceTypography.cardTitle),
                          if (isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: FinanceColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Default',
                                style: FinanceTypography.cardSubtitle.copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (cardNumber != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          '**** **** **** ${cardNumber!.substring(cardNumber!.length - 4)}',
                          style: FinanceTypography.cardSubtitle,
                        ),
                      ],
                      if (expiryDate != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Expires ${expiryDate}',
                          style: FinanceTypography.cardSubtitle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentIcon() {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case PaymentMethodType.creditCard:
        iconData = Icons.credit_card;
        iconColor = FinanceColors.primary;
        break;
      case PaymentMethodType.debitCard:
        iconData = Icons.account_balance_wallet;
        iconColor = FinanceColors.secondary;
        break;
      case PaymentMethodType.bankAccount:
        iconData = Icons.account_balance;
        iconColor = FinanceColors.success;
        break;
      case PaymentMethodType.digitalWallet:
        iconData = Icons.account_balance_wallet;
        iconColor = FinanceColors.warning;
        break;
      case PaymentMethodType.upi:
        iconData = Icons.payment;
        iconColor = FinanceColors.info;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isDefault && onSetDefault != null)
          IconButton(
            onPressed: onSetDefault,
            icon: const Icon(Icons.star_border, size: 20),
            tooltip: 'Set as default',
          ),
        if (onDelete != null)
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, size: 20),
            tooltip: 'Delete',
          ),
      ],
    );
  }
}

/// Payment method types
enum PaymentMethodType {
  creditCard,
  debitCard,
  bankAccount,
  digitalWallet,
  upi,
}

/// Quick Payment Button for common payment actions
class QuickPaymentButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const QuickPaymentButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(icon, color: color, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: FinanceTypography.cardSubtitle.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
