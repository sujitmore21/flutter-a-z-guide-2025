# Flutter Trading UI Kit

A comprehensive, production-ready UI kit specifically designed for trading applications. This kit provides a complete set of components, themes, and utilities for building professional trading interfaces.

## 🎯 Overview

The Trading UI Kit is built with the following principles:
- **Trading-First Design**: Every component is designed specifically for trading applications
- **Scalable Architecture**: Easy to integrate into existing projects
- **Production Ready**: Battle-tested components for real-world applications
- **Responsive**: Works seamlessly across mobile, tablet, and desktop
- **Customizable**: Extensive theming and customization options

## 📁 Structure

```
ui_kit/
├── components/                 # UI Components
│   ├── atoms/                 # Basic building blocks
│   │   ├── trading_button.dart
│   │   ├── trading_card.dart
│   │   └── trading_input.dart
│   ├── molecules/             # Composite components
│   │   ├── price_display.dart
│   │   ├── portfolio_summary.dart
│   │   ├── order_book.dart
│   │   └── trading_form.dart
│   └── organisms/             # Complex components
│       └── trading_chart.dart
├── theme/                     # Theme configuration
│   └── trading_theme.dart
├── animations/                # Animation components
├── charts/                    # Chart components
├── forms/                     # Form components
├── buttons/                   # Button components
├── cards/                     # Card components
└── layouts/                    # Layout components
```

## 🧩 Components

### Atoms (Basic Building Blocks)

#### TradingButton
A comprehensive button component with multiple variants and sizes.

```dart
TradingButton(
  text: 'Buy Bitcoin',
  onPressed: () {},
  variant: TradingButtonVariant.success,
  size: TradingButtonSize.large,
  icon: Icons.add,
)
```

**Variants:**
- `primary`: Primary action button
- `secondary`: Secondary action button
- `text`: Text-only button
- `success`: Success/positive action
- `danger`: Danger/negative action

**Sizes:**
- `small`: Compact button
- `medium`: Standard button
- `large`: Large button
- `extraLarge`: Extra large button

#### TradingCard
Flexible card component with multiple variants.

```dart
TradingCard(
  child: Text('Card content'),
  variant: TradingCardVariant.elevated,
  onTap: () {},
  isClickable: true,
)
```

**Variants:**
- `defaultCard`: Standard card
- `elevated`: Elevated card with shadow
- `flat`: Flat card without elevation
- `outlined`: Outlined card

#### TradingInput
Specialized input component for trading applications.

```dart
TradingInput(
  label: 'Amount',
  hint: 'Enter amount',
  prefix: Text('\$'),
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)
```

**Variants:**
- `outlined`: Outlined border
- `filled`: Filled background
- `underlined`: Underlined border

### Molecules (Composite Components)

#### PriceDisplay
Specialized component for displaying trading prices.

```dart
PriceDisplay(
  price: 43250.75,
  change: 1250.25,
  changePercent: 2.98,
  size: PriceDisplaySize.large,
)
```

**Features:**
- Profit/loss color coding
- Multiple size options
- Currency formatting
- Change indicators

#### PortfolioSummary
Comprehensive portfolio overview component.

```dart
PortfolioSummary(
  totalValue: 125430.50,
  totalChange: 2340.25,
  totalChangePercent: 1.9,
  availableBalance: 15000.00,
  investedAmount: 110430.50,
)
```

#### OrderBook
Order book display for trading interfaces.

```dart
OrderBook(
  buyOrders: buyOrders,
  sellOrders: sellOrders,
  maxRows: 10,
  onOrderTap: (order) {},
)
```

#### TradingForm
Comprehensive form component with validation.

```dart
TradingForm(
  fields: [
    TradingFormField(
      key: 'amount',
      type: TradingFormFieldType.number,
      label: 'Amount',
      required: true,
    ),
  ],
  onSubmit: (data) {},
)
```

### Organisms (Complex Components)

#### TradingChart
Interactive chart component for price data.

```dart
TradingChart(
  data: chartData,
  chartType: TradingChartType.line,
  timeframe: TradingTimeframe.day1,
  height: 300,
)
```

**Chart Types:**
- `line`: Line chart
- `candlestick`: Candlestick chart
- `area`: Area chart
- `bar`: Bar chart

**Timeframes:**
- `minute1`, `minute5`, `minute15`, `minute30`
- `hour1`, `hour4`
- `day1`, `week1`, `month1`

## 🎨 Theming

### Dark Theme (Default)
```dart
MaterialApp(
  theme: TradingTheme.darkTheme,
  home: MyApp(),
)
```

### Light Theme
```dart
MaterialApp(
  theme: TradingTheme.lightTheme,
  home: MyApp(),
)
```

### Custom Theme
```dart
class CustomTradingTheme extends TradingTheme {
  static ThemeData get customTheme {
    return darkTheme.copyWith(
      primaryColor: Colors.blue,
      // Your customizations
    );
  }
}
```

## 🎯 Usage Examples

### Basic Trading Screen
```dart
class TradingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trading')),
      body: Column(
        children: [
          // Portfolio Summary
          PortfolioSummary(
            totalValue: 125430.50,
            totalChange: 2340.25,
            totalChangePercent: 1.9,
          ),
          
          // Price Display
          PriceDisplay(
            price: 43250.75,
            change: 1250.25,
            changePercent: 2.98,
          ),
          
          // Trading Chart
          Expanded(
            child: TradingChart(
              data: chartData,
              chartType: TradingChartType.line,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Trading Form
```dart
TradingForm(
  title: 'Place Order',
  fields: [
    TradingFormField(
      key: 'symbol',
      type: TradingFormFieldType.text,
      label: 'Symbol',
      required: true,
    ),
    TradingFormField(
      key: 'amount',
      type: TradingFormFieldType.number,
      label: 'Amount',
      decimals: 2,
      required: true,
    ),
    TradingFormField(
      key: 'orderType',
      type: TradingFormFieldType.select,
      label: 'Order Type',
      options: [
        TradingFormOption(value: 'market', label: 'Market Order'),
        TradingFormOption(value: 'limit', label: 'Limit Order'),
      ],
    ),
  ],
  onSubmit: (data) {
    // Handle form submission
  },
)
```

## 🔧 Customization

### Colors
```dart
// Override colors
TradingColors.primary = Color(0xFF1E3A8A);
TradingColors.profit = Color(0xFF10B981);
TradingColors.loss = Color(0xFFEF4444);
```

### Typography
```dart
// Custom text styles
TradingTextStyles.priceLarge(
  fontSize: 28.0,
  fontWeight: FontWeight.w700,
)
```

### Components
```dart
// Extend components
class CustomTradingButton extends TradingButton {
  @override
  Widget build(BuildContext context) {
    // Your custom implementation
  }
}
```

## 📱 Responsive Design

### Breakpoints
- **Mobile**: < 600px
- **Tablet**: 600px - 900px
- **Desktop**: > 900px

### Usage
```dart
TradingSizes.getResponsiveSize(
  context,
  mobile: 16.0,
  tablet: 20.0,
  desktop: 24.0,
)
```

## 🚀 Performance

### Optimization Tips
- Use `const` constructors where possible
- Implement proper `dispose()` methods
- Use `ListView.builder` for large lists
- Optimize chart rendering for real-time data

### Memory Management
- Dispose controllers and streams
- Use weak references where appropriate
- Implement proper cleanup in widgets

## 🧪 Testing

### Unit Tests
```dart
testWidgets('TradingButton should display text', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: TradingButton(
        text: 'Test',
        onPressed: () {},
      ),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
});
```

### Widget Tests
```dart
testWidgets('PriceDisplay should show profit color', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: PriceDisplay(
        price: 100.0,
        change: 10.0,
        changePercent: 10.0,
      ),
    ),
  );
  
  expect(find.byType(Icon), findsOneWidget);
});
```

## 📦 Dependencies

### Required Dependencies
```yaml
dependencies:
  flutter_svg: ^2.0.10+1
  font_awesome_flutter: ^10.6.0
  fl_chart: ^0.66.0
  google_fonts: ^6.1.0
```

### Optional Dependencies
```yaml
dependencies:
  provider: ^6.1.1
  riverpod: ^2.4.9
  go_router: ^12.1.3
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Trading community for feedback and suggestions
- Open source contributors

---

**Built with ❤️ for the Flutter trading community**
