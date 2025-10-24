import 'package:flutter/material.dart';
import '../../theme/colors/finance_colors.dart';
import '../../theme/typography/finance_typography.dart';

/// Transaction List Item for banking and fintech apps
/// Displays individual transaction details with status indicators
class TransactionListItem extends StatelessWidget {
  final String description;
  final double amount;
  final bool isCredit;
  final DateTime timestamp;
  final TransactionStatus status;
  final String? category;
  final String? merchant;
  final VoidCallback? onTap;

  const TransactionListItem({
    super.key,
    required this.description,
    required this.amount,
    required this.isCredit,
    required this.timestamp,
    this.status = TransactionStatus.completed,
    this.category,
    this.merchant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                _buildTransactionIcon(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: FinanceTypography.cardTitle.copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (merchant != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          merchant!,
                          style: FinanceTypography.cardSubtitle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            _formatDate(timestamp),
                            style: FinanceTypography.cardSubtitle.copyWith(
                              fontSize: 11,
                            ),
                          ),
                          if (category != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: FinanceColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                category!,
                                style: FinanceTypography.cardSubtitle.copyWith(
                                  fontSize: 10,
                                  color: FinanceColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                _buildAmountAndStatus(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIcon() {
    IconData iconData;
    Color iconColor;

    if (isCredit) {
      iconData = Icons.arrow_downward;
      iconColor = FinanceColors.success;
    } else {
      iconData = Icons.arrow_upward;
      iconColor = FinanceColors.error;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  Widget _buildAmountAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${isCredit ? '+' : '-'}\$${_formatCurrency(amount)}',
          style: FinanceTypography.balanceAmount.copyWith(
            fontSize: 14,
            color: isCredit ? FinanceColors.success : FinanceColors.error,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        _buildStatusIndicator(),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    Color statusColor;
    String statusText;

    switch (status) {
      case TransactionStatus.pending:
        statusColor = FinanceColors.warning;
        statusText = 'Pending';
        break;
      case TransactionStatus.completed:
        statusColor = FinanceColors.success;
        statusText = 'Completed';
        break;
      case TransactionStatus.failed:
        statusColor = FinanceColors.error;
        statusText = 'Failed';
        break;
      case TransactionStatus.cancelled:
        statusColor = FinanceColors.textSecondary;
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        statusText,
        style: FinanceTypography.cardSubtitle.copyWith(
          fontSize: 10,
          color: statusColor,
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

/// Transaction status enum
enum TransactionStatus { pending, completed, failed, cancelled }

/// Transaction Summary Card for displaying transaction statistics
class TransactionSummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final double? change;
  final double? changePercent;
  final Color? color;
  final IconData? icon;

  const TransactionSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    this.change,
    this.changePercent,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: FinanceColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: FinanceColors.border),
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
              if (icon != null) ...[
                Icon(icon, color: color ?? FinanceColors.primary, size: 20),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(title, style: FinanceTypography.cardSubtitle),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_formatCurrency(amount)}',
            style: FinanceTypography.balanceAmount.copyWith(
              fontSize: 20,
              color: color ?? FinanceColors.textPrimary,
            ),
          ),
          if (change != null && changePercent != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  change! >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  color: change! >= 0
                      ? FinanceColors.success
                      : FinanceColors.error,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '${change! >= 0 ? '+' : ''}\$${_formatCurrency(change!.abs())} (${changePercent!.abs().toStringAsFixed(1)}%)',
                  style: FinanceTypography.cardSubtitle.copyWith(
                    fontSize: 12,
                    color: change! >= 0
                        ? FinanceColors.success
                        : FinanceColors.error,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }
}
