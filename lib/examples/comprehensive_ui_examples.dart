import 'package:flutter/material.dart';
import '../ui_kit/components/finance/account_balance_card.dart';
import '../ui_kit/components/finance/payment_method_card.dart';
import '../ui_kit/components/finance/transaction_list_item.dart';
import '../ui_kit/components/finance/loan_calculator_card.dart';
import '../ui_kit/components/ecommerce/product_card.dart';
import '../ui_kit/components/ecommerce/shopping_cart_item.dart';
import '../ui_kit/components/ecommerce/checkout_form.dart';
import '../ui_kit/components/healthcare/health_metric_card.dart';
import '../ui_kit/components/healthcare/telemedicine_card.dart';
import '../ui_kit/theme/colors/finance_colors.dart';
import '../ui_kit/theme/colors/healthcare_colors.dart';

/// Comprehensive UI Examples
/// Showcases all UI kit components across Finance, E-commerce, and Healthcare
class ComprehensiveUIExamples extends StatelessWidget {
  const ComprehensiveUIExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: '🏦 Finance', icon: Icon(Icons.account_balance)),
              Tab(text: '🛍️ E-Commerce', icon: Icon(Icons.shopping_cart)),
              Tab(text: '👩‍⚕️ Healthcare', icon: Icon(Icons.medical_services)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FinanceExamples(),
            EcommerceExamples(),
            HealthcareExamples(),
          ],
        ),
      ),
    );
  }
}

/// Finance & Fintech Examples
class FinanceExamples extends StatelessWidget {
  const FinanceExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Banking & Digital Wallets', _buildBankingExamples()),
          const SizedBox(height: 24),
          _buildSection('Trading & Investment', _buildTradingExamples()),
          const SizedBox(height: 24),
          _buildSection('Loans & Insurance', _buildLoanExamples()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildBankingExamples() {
    return Column(
      children: [
        // Account Balance Cards
        AccountBalanceCard(
          accountName: 'John Doe',
          accountNumber: '1234567890',
          balance: 125430.50,
          currency: 'USD',
          accountType: 'Savings',
          recentTransactions: [
            TransactionSummary(
              description: 'Salary Deposit',
              amount: 5000.00,
              isCredit: true,
              timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AccountBalanceCard(
          accountName: 'John Doe',
          accountNumber: '0987654321',
          balance: 25000.00,
          currency: 'USD',
          accountType: 'Checking',
          cardColor: FinanceColors.secondary,
        ),
        const SizedBox(height: 16),

        // Payment Methods
        PaymentMethodCard(
          type: PaymentMethodType.creditCard,
          name: 'Chase Sapphire Preferred',
          cardNumber: '4532123456789012',
          expiryDate: '12/25',
          isDefault: true,
        ),
        const SizedBox(height: 8),
        PaymentMethodCard(
          type: PaymentMethodType.upi,
          name: 'UPI Payment',
          isDefault: false,
        ),
        const SizedBox(height: 16),

        // Recent Transactions
        const Text(
          'Recent Transactions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TransactionListItem(
          description: 'Grocery Store Purchase',
          amount: 85.50,
          isCredit: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          status: TransactionStatus.completed,
          merchant: 'Whole Foods',
          category: 'Food',
        ),
        TransactionListItem(
          description: 'Salary Deposit',
          amount: 5000.00,
          isCredit: true,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: TransactionStatus.completed,
          category: 'Income',
        ),
      ],
    );
  }

  Widget _buildTradingExamples() {
    return Column(
      children: [
        // Trading Summary Cards
        Row(
          children: [
            Expanded(
              child: TransactionSummaryCard(
                title: 'Portfolio Value',
                amount: 125430.50,
                change: 2340.25,
                changePercent: 1.9,
                color: FinanceColors.success,
                icon: Icons.trending_up,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TransactionSummaryCard(
                title: 'Today\'s P&L',
                amount: 1250.75,
                change: -45.25,
                changePercent: -3.5,
                color: FinanceColors.error,
                icon: Icons.trending_down,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Quick Payment Buttons
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            QuickPaymentButton(
              label: 'Transfer',
              icon: Icons.send,
              color: FinanceColors.primary,
            ),
            const SizedBox(width: 16),
            QuickPaymentButton(
              label: 'Pay Bills',
              icon: Icons.receipt,
              color: FinanceColors.secondary,
            ),
            const SizedBox(width: 16),
            QuickPaymentButton(
              label: 'Invest',
              icon: Icons.trending_up,
              color: FinanceColors.success,
            ),
            const SizedBox(width: 16),
            QuickPaymentButton(
              label: 'Save',
              icon: Icons.savings,
              color: FinanceColors.warning,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoanExamples() {
    return Column(
      children: [
        LoanCalculatorCard(
          loanType: 'Home Loan',
          principalAmount: 500000.00,
          interestRate: 6.5,
          tenureMonths: 360,
          emiAmount: 3160.00,
          totalAmount: 1137600.00,
          totalInterest: 637600.00,
        ),
        const SizedBox(height: 16),
        InsurancePolicyCard(
          policyName: 'Life Insurance Premium',
          policyNumber: 'LI-2024-001',
          insuranceType: 'Life',
          premiumAmount: 150.00,
          premiumFrequency: 'Monthly',
          nextDueDate: DateTime.now().add(const Duration(days: 15)),
          status: 'Active',
        ),
      ],
    );
  }
}

/// E-Commerce & Retail Examples
class EcommerceExamples extends StatelessWidget {
  const EcommerceExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Product Catalog', _buildProductExamples()),
          const SizedBox(height: 24),
          _buildSection('Shopping Cart', _buildCartExamples()),
          const SizedBox(height: 24),
          _buildSection('Checkout Process', _buildCheckoutExamples()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildProductExamples() {
    return Column(
      children: [
        // Product Grid
        SizedBox(
          height: 400,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              ProductCard(
                name: 'iPhone 15 Pro',
                description: 'Latest iPhone with advanced camera system',
                price: 999.00,
                originalPrice: 1099.00,
                rating: 4.8,
                reviewCount: 1250,
                category: 'Electronics',
                isOnSale: true,
                isNew: false,
                isFavorite: false,
              ),
              ProductCard(
                name: 'Nike Air Max',
                description: 'Comfortable running shoes',
                price: 120.00,
                rating: 4.5,
                reviewCount: 890,
                category: 'Fashion',
                isNew: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Product List
        const Text(
          'Featured Products',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ProductListItem(
                name: 'MacBook Pro',
                price: 1999.00,
                originalPrice: 2199.00,
                rating: 4.9,
                isOnSale: true,
              ),
              const SizedBox(width: 12),
              ProductListItem(
                name: 'Samsung Galaxy S24',
                price: 799.00,
                rating: 4.7,
              ),
              const SizedBox(width: 12),
              ProductListItem(
                name: 'Sony WH-1000XM5',
                price: 399.00,
                rating: 4.6,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartExamples() {
    return Column(
      children: [
        ShoppingCartItem(
          name: 'iPhone 15 Pro',
          description: 'Latest iPhone with advanced camera system',
          price: 999.00,
          quantity: 1,
          size: '256GB',
          color: 'Space Black',
          isAvailable: true,
        ),
        const SizedBox(height: 8),
        ShoppingCartItem(
          name: 'Nike Air Max',
          description: 'Comfortable running shoes',
          price: 120.00,
          quantity: 2,
          size: 'US 10',
          color: 'White',
          isAvailable: true,
        ),
        const SizedBox(height: 16),

        // Cart Summary
        ShoppingCartSummary(
          subtotal: 1239.00,
          shipping: 15.99,
          tax: 99.12,
          discount: 50.00,
          total: 1304.11,
          couponCode: 'SAVE50',
        ),
      ],
    );
  }

  Widget _buildCheckoutExamples() {
    return const SingleChildScrollView(child: CheckoutForm());
  }
}

/// Healthcare & Fitness Examples
class HealthcareExamples extends StatelessWidget {
  const HealthcareExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Health Metrics', _buildHealthMetricsExamples()),
          const SizedBox(height: 24),
          _buildSection('Telemedicine', _buildTelemedicineExamples()),
          const SizedBox(height: 24),
          _buildSection('Fitness & Wellness', _buildFitnessExamples()),
          const SizedBox(height: 24),
          _buildSection('Health Records', _buildHealthRecordsExamples()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildHealthMetricsExamples() {
    return Column(
      children: [
        HealthMetricCard(
          title: 'Heart Rate',
          value: '72',
          unit: 'BPM',
          subtitle: 'Resting',
          icon: Icons.favorite,
          color: HealthcareColors.heartRate,
          trend: HealthMetricTrend(
            direction: HealthTrendDirection.stable,
            percentage: 2.1,
          ),
          lastUpdated: '2 minutes ago',
          historicalData: _generateHeartRateData(),
        ),
        const SizedBox(height: 12),
        HealthMetricCard(
          title: 'Blood Pressure',
          value: '120/80',
          unit: 'mmHg',
          subtitle: 'Normal',
          icon: Icons.monitor_heart,
          color: HealthcareColors.bloodPressure,
          trend: HealthMetricTrend(
            direction: HealthTrendDirection.down,
            percentage: 5.2,
          ),
          lastUpdated: '1 hour ago',
        ),
        const SizedBox(height: 12),
        HealthMetricCard(
          title: 'Steps Today',
          value: '8,432',
          unit: 'steps',
          subtitle: 'Goal: 10,000',
          icon: Icons.directions_walk,
          color: HealthcareColors.success,
          trend: HealthMetricTrend(
            direction: HealthTrendDirection.up,
            percentage: 12.5,
          ),
          lastUpdated: 'Just now',
        ),
      ],
    );
  }

  Widget _buildTelemedicineExamples() {
    return Column(
      children: [
        TelemedicineCard(
          doctorName: 'Dr. Sarah Johnson',
          specialty: 'Cardiologist',
          hospital: 'Mayo Clinic',
          rating: 4.9,
          reviewCount: 245,
          availability: 'Available Now',
          consultationFee: 150.00,
        ),
        const SizedBox(height: 12),
        VideoConsultationCard(
          doctorName: 'Dr. Michael Chen',
          specialty: 'Dermatologist',
          appointmentTime: DateTime.now().add(const Duration(hours: 2)),
          status: 'Scheduled',
        ),
      ],
    );
  }

  Widget _buildFitnessExamples() {
    return Column(
      children: [
        FitnessActivityCard(
          activityName: 'Morning Run',
          duration: '45 min',
          calories: '450 cal',
          distance: '5.2 km',
          icon: Icons.directions_run,
          color: HealthcareColors.fitnessCardio,
          completedAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        const SizedBox(height: 12),
        FitnessActivityCard(
          activityName: 'Yoga Session',
          duration: '30 min',
          calories: '150 cal',
          icon: Icons.self_improvement,
          color: HealthcareColors.fitnessFlexibility,
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        const SizedBox(height: 12),
        MedicationReminderCard(
          medicationName: 'Metformin',
          dosage: '500mg',
          frequency: 'Twice daily',
          nextDose: DateTime.now().add(const Duration(hours: 6)),
          isTaken: false,
        ),
      ],
    );
  }

  Widget _buildHealthRecordsExamples() {
    return Column(
      children: [
        HealthRecordCard(
          recordType: 'Prescription',
          title: 'Diabetes Medication',
          description: 'Metformin 500mg twice daily',
          date: DateTime.now().subtract(const Duration(days: 7)),
          doctor: 'Dr. Sarah Johnson',
          hospital: 'Mayo Clinic',
          attachments: ['prescription.pdf', 'lab_results.pdf'],
        ),
        const SizedBox(height: 12),
        HealthRecordCard(
          recordType: 'Lab Report',
          title: 'Blood Test Results',
          description: 'Complete blood count and metabolic panel',
          date: DateTime.now().subtract(const Duration(days: 14)),
          doctor: 'Dr. Michael Chen',
          hospital: 'City Medical Center',
          attachments: ['blood_test.pdf'],
        ),
      ],
    );
  }

  List<HealthMetricData> _generateHeartRateData() {
    final data = <HealthMetricData>[];
    double heartRate = 70.0;

    for (int i = 0; i < 20; i++) {
      heartRate += (i % 3 == 0 ? 1 : -1) * (2 + (i * 0.5));
      data.add(
        HealthMetricData(
          value: heartRate,
          timestamp: DateTime.now().subtract(Duration(minutes: 19 - i)),
        ),
      );
    }

    return data;
  }
}
