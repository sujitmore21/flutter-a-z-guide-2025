import 'package:flutter/material.dart';
import '../ui_kit/components/atoms/trading_button.dart';
import '../ui_kit/components/atoms/trading_card.dart';
import '../ui_kit/components/atoms/trading_input.dart';
import '../ui_kit/components/molecules/price_display.dart';
import '../ui_kit/components/molecules/portfolio_summary.dart';
import '../ui_kit/components/molecules/order_book.dart';
import '../ui_kit/components/molecules/trading_form.dart';
import '../ui_kit/components/organisms/trading_chart.dart';
import '../core/constants/app_colors/trading_colors.dart';
import '../core/constants/app_sizes/trading_sizes.dart';

/// Trading UI Examples
/// Comprehensive examples of how to use the Trading UI Kit
class TradingUIExamples extends StatelessWidget {
  const TradingUIExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TradingColors.background,
      appBar: AppBar(
        title: const Text('Trading UI Kit Examples'),
        backgroundColor: TradingColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TradingSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Buttons', _buildButtonExamples()),
            _buildSection('Cards', _buildCardExamples()),
            _buildSection('Inputs', _buildInputExamples()),
            _buildSection('Price Displays', _buildPriceDisplayExamples()),
            _buildSection('Forms', _buildFormExamples()),
            _buildSection('Charts', _buildChartExamples()),
            _buildSection('Portfolio', _buildPortfolioExamples()),
            _buildSection('Order Book', _buildOrderBookExamples()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TradingSizes.md),
          content,
          const SizedBox(height: TradingSizes.xl),
        ],
      ),
    );
  }

  Widget _buildButtonExamples() {
    return Column(
      children: [
        // Primary Buttons
        Row(
          children: [
            TradingButton(
              text: 'Primary',
              onPressed: () {},
              variant: TradingButtonVariant.primary,
            ),
            const SizedBox(width: TradingSizes.md),
            TradingButton(
              text: 'Success',
              onPressed: () {},
              variant: TradingButtonVariant.success,
            ),
            const SizedBox(width: TradingSizes.md),
            TradingButton(
              text: 'Danger',
              onPressed: () {},
              variant: TradingButtonVariant.danger,
            ),
          ],
        ),
        const SizedBox(height: TradingSizes.md),
        // Secondary Buttons
        Row(
          children: [
            TradingButton(
              text: 'Secondary',
              onPressed: () {},
              variant: TradingButtonVariant.secondary,
            ),
            const SizedBox(width: TradingSizes.md),
            TradingButton(
              text: 'Text',
              onPressed: () {},
              variant: TradingButtonVariant.text,
            ),
          ],
        ),
        const SizedBox(height: TradingSizes.md),
        // Button Sizes
        Row(
          children: [
            TradingButton(
              text: 'Small',
              onPressed: () {},
              size: TradingButtonSize.small,
            ),
            const SizedBox(width: TradingSizes.md),
            TradingButton(
              text: 'Medium',
              onPressed: () {},
              size: TradingButtonSize.medium,
            ),
            const SizedBox(width: TradingSizes.md),
            TradingButton(
              text: 'Large',
              onPressed: () {},
              size: TradingButtonSize.large,
            ),
          ],
        ),
        const SizedBox(height: TradingSizes.md),
        // Button with Icon
        TradingButton(
          text: 'Buy Bitcoin',
          onPressed: () {},
          variant: TradingButtonVariant.success,
          icon: Icons.add,
          iconPosition: TradingButtonIconPosition.left,
        ),
      ],
    );
  }

  Widget _buildCardExamples() {
    return Column(
      children: [
        // Basic Card
        Builder(
          builder: (context) => TradingCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Card',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: TradingSizes.sm),
                Text(
                  'This is a basic trading card with some content.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TradingSizes.md),
        // Card with Header
        TradingCardWithHeader(
          title: 'Portfolio Overview',
          subtitle: 'Your current portfolio status',
          child: const Text('Portfolio content goes here'),
        ),
        const SizedBox(height: TradingSizes.md),
        // Card with Icon
        TradingCardWithIcon(
          icon: Icons.trending_up,
          title: 'Market Performance',
          subtitle: 'Real-time market data',
          child: const Text('Market data content goes here'),
        ),
      ],
    );
  }

  Widget _buildInputExamples() {
    return Column(
      children: [
        // Text Input
        TradingInput(
          label: 'Email Address',
          hint: 'Enter your email',
          prefix: const Icon(Icons.email),
        ),
        const SizedBox(height: TradingSizes.md),
        // Number Input
        TradingNumberInput(
          label: 'Amount',
          hint: 'Enter amount',
          prefix: const Text('\$'),
          decimals: 2,
        ),
        const SizedBox(height: TradingSizes.md),
        // Input Variants
        Row(
          children: [
            Expanded(
              child: TradingInput(
                label: 'Outlined',
                hint: 'Outlined input',
                variant: TradingInputVariant.outlined,
              ),
            ),
            const SizedBox(width: TradingSizes.md),
            Expanded(
              child: TradingInput(
                label: 'Filled',
                hint: 'Filled input',
                variant: TradingInputVariant.filled,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceDisplayExamples() {
    return Column(
      children: [
        // Large Price Display
        PriceDisplay(
          price: 43250.75,
          change: 1250.25,
          changePercent: 2.98,
          size: PriceDisplaySize.large,
        ),
        const SizedBox(height: TradingSizes.md),
        // Medium Price Display
        PriceDisplay(
          price: 2850.50,
          change: -45.25,
          changePercent: -1.56,
          size: PriceDisplaySize.medium,
        ),
        const SizedBox(height: TradingSizes.md),
        // Compact Price Display
        CompactPriceDisplay(price: 95.25, change: 8.75, changePercent: 10.12),
      ],
    );
  }

  Widget _buildFormExamples() {
    return TradingForm(
      title: 'Trading Order',
      subtitle: 'Place a new trading order',
      fields: [
        TradingFormField(
          key: 'symbol',
          type: TradingFormFieldType.text,
          label: 'Symbol',
          hint: 'Enter trading symbol',
          required: true,
        ),
        TradingFormField(
          key: 'amount',
          type: TradingFormFieldType.number,
          label: 'Amount',
          hint: 'Enter amount',
          decimals: 2,
          required: true,
        ),
        TradingFormField(
          key: 'orderType',
          type: TradingFormFieldType.select,
          label: 'Order Type',
          options: const [
            TradingFormOption(value: 'market', label: 'Market Order'),
            TradingFormOption(value: 'limit', label: 'Limit Order'),
            TradingFormOption(value: 'stop', label: 'Stop Order'),
          ],
        ),
        TradingFormField(
          key: 'agree',
          type: TradingFormFieldType.checkbox,
          label: 'I agree to the terms and conditions',
          required: true,
        ),
      ],
      onSubmit: (data) {
        print('Form submitted: $data');
      },
      onCancel: () {
        print('Form cancelled');
      },
    );
  }

  Widget _buildChartExamples() {
    return SizedBox(
      height: 300,
      child: TradingChart(
        data: _generateSampleData(),
        title: 'BTC/USD',
        subtitle: 'Bitcoin Price Chart',
        chartType: TradingChartType.line,
        timeframe: TradingTimeframe.day1,
      ),
    );
  }

  Widget _buildPortfolioExamples() {
    return Column(
      children: [
        const PortfolioSummary(
          totalValue: 125430.50,
          totalChange: 2340.25,
          totalChangePercent: 1.9,
          availableBalance: 15000.00,
          investedAmount: 110430.50,
          dayChange: 450.75,
          dayChangePercent: 0.36,
        ),
        const SizedBox(height: TradingSizes.md),
        PortfolioHoldings(
          holdings: [
            const PortfolioHolding(
              symbol: 'BTC',
              name: 'Bitcoin',
              quantity: 0.5,
              value: 21625.38,
              change: 1250.25,
              changePercent: 6.13,
            ),
            const PortfolioHolding(
              symbol: 'ETH',
              name: 'Ethereum',
              quantity: 2.0,
              value: 5701.00,
              change: -45.25,
              changePercent: -0.79,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderBookExamples() {
    return SizedBox(
      height: 300,
      child: OrderBook(
        buyOrders: _generateBuyOrders(),
        sellOrders: _generateSellOrders(),
        maxRows: 5,
      ),
    );
  }

  List<TradingDataPoint> _generateSampleData() {
    final data = <TradingDataPoint>[];
    double price = 42000.0;

    for (int i = 0; i < 30; i++) {
      price += (i % 3 == 0 ? 1 : -1) * (100 + (i * 10));
      data.add(
        TradingDataPoint(
          value: price,
          label: '${i + 1}',
          timestamp: DateTime.now().subtract(Duration(days: 29 - i)),
        ),
      );
    }

    return data;
  }

  List<OrderBookEntry> _generateBuyOrders() {
    final orders = <OrderBookEntry>[];
    double price = 43200.0;

    for (int i = 0; i < 10; i++) {
      orders.add(
        OrderBookEntry(price: price - (i * 10), size: 0.5 + (i * 0.1)),
      );
    }

    return orders;
  }

  List<OrderBookEntry> _generateSellOrders() {
    final orders = <OrderBookEntry>[];
    double price = 43250.0;

    for (int i = 0; i < 10; i++) {
      orders.add(
        OrderBookEntry(price: price + (i * 10), size: 0.3 + (i * 0.05)),
      );
    }

    return orders;
  }
}
