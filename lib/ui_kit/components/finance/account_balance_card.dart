import 'package:flutter/material.dart';
import '../../theme/colors/finance_colors.dart';
import '../../theme/typography/finance_typography.dart';

/// Account Balance Card for banking and fintech apps
/// Displays account information with balance and transaction history
class AccountBalanceCard extends StatelessWidget {
  final String accountName;
  final String accountNumber;
  final double balance;
  final String currency;
  final String accountType;
  final Color? cardColor;
  final VoidCallback? onTap;
  final List<TransactionSummary>? recentTransactions;

  const AccountBalanceCard({
    super.key,
    required this.accountName,
    required this.accountNumber,
    required this.balance,
    this.currency = 'USD',
    this.accountType = 'Savings',
    this.cardColor,
    this.onTap,
    this.recentTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: cardColor != null
                ? [cardColor!, cardColor!.withOpacity(0.8)]
                : [
                    FinanceColors.primary,
                    FinanceColors.primary.withOpacity(0.8),
                  ],
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    accountType,
                    style: FinanceTypography.cardSubtitle.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Icon(
                    Icons.credit_card,
                    color: Colors.white.withOpacity(0.8),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                accountName,
                style: FinanceTypography.cardTitle.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '**** **** **** ${accountNumber.substring(accountNumber.length - 4)}',
                style: FinanceTypography.cardSubtitle.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: FinanceTypography.cardSubtitle.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$currency ${_formatCurrency(balance)}',
                        style: FinanceTypography.balanceAmount.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  if (recentTransactions != null &&
                      recentTransactions!.isNotEmpty)
                    _buildTransactionIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIndicator() {
    final lastTransaction = recentTransactions!.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            lastTransaction.isCredit
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            lastTransaction.isCredit ? 'Credit' : 'Debit',
            style: FinanceTypography.cardSubtitle.copyWith(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }
}

/// Transaction summary model
class TransactionSummary {
  final String description;
  final double amount;
  final bool isCredit;
  final DateTime timestamp;

  const TransactionSummary({
    required this.description,
    required this.amount,
    required this.isCredit,
    required this.timestamp,
  });
}
