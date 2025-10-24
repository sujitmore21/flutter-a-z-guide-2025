import 'package:flutter/material.dart';
import '../../theme/colors/finance_colors.dart';
import '../../theme/typography/finance_typography.dart';

/// Loan Calculator Card for loan and insurance management apps
/// Displays loan information with EMI calculations
class LoanCalculatorCard extends StatelessWidget {
  final String loanType;
  final double principalAmount;
  final double interestRate;
  final int tenureMonths;
  final double emiAmount;
  final double totalAmount;
  final double totalInterest;
  final VoidCallback? onTap;
  final VoidCallback? onCalculate;

  const LoanCalculatorCard({
    super.key,
    required this.loanType,
    required this.principalAmount,
    required this.interestRate,
    required this.tenureMonths,
    required this.emiAmount,
    required this.totalAmount,
    required this.totalInterest,
    this.onTap,
    this.onCalculate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: FinanceColors.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: FinanceColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildLoanDetails(),
                const SizedBox(height: 16),
                _buildCalculationResults(),
                const SizedBox(height: 16),
                _buildActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: FinanceColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.calculate, color: FinanceColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loanType, style: FinanceTypography.cardTitle),
              Text('Loan Calculator', style: FinanceTypography.cardSubtitle),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoanDetails() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FinanceColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Principal Amount',
            '\$${_formatCurrency(principalAmount)}',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            'Interest Rate',
            '${interestRate.toStringAsFixed(2)}% p.a.',
          ),
          const SizedBox(height: 8),
          _buildDetailRow('Tenure', '${tenureMonths} months'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FinanceTypography.cardSubtitle.copyWith(fontSize: 12),
        ),
        Text(
          value,
          style: FinanceTypography.cardTitle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationResults() {
    return Column(
      children: [
        _buildResultRow(
          'Monthly EMI',
          '\$${_formatCurrency(emiAmount)}',
          FinanceColors.primary,
          true,
        ),
        const SizedBox(height: 8),
        _buildResultRow(
          'Total Amount',
          '\$${_formatCurrency(totalAmount)}',
          FinanceColors.textPrimary,
          false,
        ),
        const SizedBox(height: 8),
        _buildResultRow(
          'Total Interest',
          '\$${_formatCurrency(totalInterest)}',
          FinanceColors.warning,
          false,
        ),
      ],
    );
  }

  Widget _buildResultRow(
    String label,
    String value,
    Color color,
    bool isHighlighted,
  ) {
    return Container(
      padding: EdgeInsets.all(isHighlighted ? 12 : 8),
      decoration: BoxDecoration(
        color: isHighlighted ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted
            ? Border.all(color: color.withOpacity(0.3))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: FinanceTypography.cardSubtitle.copyWith(
              fontSize: isHighlighted ? 14 : 12,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: FinanceTypography.balanceAmount.copyWith(
              fontSize: isHighlighted ? 18 : 14,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onCalculate,
        style: ElevatedButton.styleFrom(
          backgroundColor: FinanceColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Recalculate',
          style: FinanceTypography.buttonText.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }
}

/// Insurance Policy Card for insurance management
class InsurancePolicyCard extends StatelessWidget {
  final String policyName;
  final String policyNumber;
  final String insuranceType;
  final double premiumAmount;
  final String premiumFrequency;
  final DateTime nextDueDate;
  final String status;
  final VoidCallback? onTap;
  final VoidCallback? onPayPremium;

  const InsurancePolicyCard({
    super.key,
    required this.policyName,
    required this.policyNumber,
    required this.insuranceType,
    required this.premiumAmount,
    required this.premiumFrequency,
    required this.nextDueDate,
    required this.status,
    this.onTap,
    this.onPayPremium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildPolicyIcon(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(policyName, style: FinanceTypography.cardTitle),
                          Text(
                            'Policy #$policyNumber',
                            style: FinanceTypography.cardSubtitle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPolicyDetails(),
                const SizedBox(height: 12),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyIcon() {
    IconData iconData;
    Color iconColor;

    switch (insuranceType.toLowerCase()) {
      case 'life':
        iconData = Icons.favorite;
        iconColor = FinanceColors.error;
        break;
      case 'health':
        iconData = Icons.health_and_safety;
        iconColor = FinanceColors.success;
        break;
      case 'auto':
        iconData = Icons.directions_car;
        iconColor = FinanceColors.primary;
        break;
      default:
        iconData = Icons.security;
        iconColor = FinanceColors.secondary;
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

  Widget _buildStatusBadge() {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'active':
        statusColor = FinanceColors.success;
        break;
      case 'expired':
        statusColor = FinanceColors.error;
        break;
      case 'pending':
        statusColor = FinanceColors.warning;
        break;
      default:
        statusColor = FinanceColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: FinanceTypography.cardSubtitle.copyWith(
          fontSize: 10,
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPolicyDetails() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FinanceColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Premium Amount',
            '\$${_formatCurrency(premiumAmount)}',
          ),
          const SizedBox(height: 8),
          _buildDetailRow('Frequency', premiumFrequency),
          const SizedBox(height: 8),
          _buildDetailRow('Next Due', _formatDate(nextDueDate)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FinanceTypography.cardSubtitle.copyWith(fontSize: 12),
        ),
        Text(
          value,
          style: FinanceTypography.cardTitle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPayPremium,
            style: OutlinedButton.styleFrom(
              foregroundColor: FinanceColors.primary,
              side: BorderSide(color: FinanceColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              'Pay Premium',
              style: FinanceTypography.buttonText.copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
