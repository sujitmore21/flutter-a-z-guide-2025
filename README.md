# Flutter Trading UI Kit

A scalable, production-ready UI kit and starter blueprint for trading applications built with Flutter. Designed for large scale apps (desktop, mobile, tablet) and to plug into MVVM / Clean / Feature-driven architectures.

## 🚀 Features

- **Comprehensive Design System**: Colors, typography, spacing, and components
- **Trading-Specific Components**: Charts, order books, portfolio displays, price indicators
- **Responsive Design**: Works seamlessly across mobile, tablet, and desktop
- **Dark/Light Themes**: Built-in theme support for trading applications
- **Modular Architecture**: Easy to integrate into existing projects
- **Production Ready**: Battle-tested components for real trading applications

## 📁 Project Structure

```
lib/
├── core/                           # Core utilities and constants
│   ├── constants/                  # App-wide constants
│   │   ├── app_colors/            # Color system
│   │   ├── app_sizes/             # Size system
│   │   └── app_styles/            # Typography system
│   ├── errors/                    # Error handling
│   ├── network/                   # Network layer
│   ├── utils/                     # Utility functions
│   └── extensions/                # Dart extensions
├── features/                      # Feature modules
│   ├── dashboard/                 # Dashboard feature
│   │   ├── data/                  # Data layer
│   │   ├── domain/                # Domain layer
│   │   └── presentation/          # Presentation layer
│   │       ├── bloc/              # State management
│   │       ├── pages/             # Screens
│   │       └── widgets/           # Feature-specific widgets
│   ├── auth/                      # Authentication
│   ├── portfolio/                 # Portfolio management
│   ├── market/                    # Market data
│   └── settings/                  # App settings
├── shared/                        # Shared components
│   ├── widgets/                   # Reusable widgets
│   ├── services/                  # Shared services
│   ├── models/                    # Data models
│   └── utils/                     # Shared utilities
└── ui_kit/                        # UI Kit components
    ├── components/                # UI Components
    │   ├── atoms/                 # Basic building blocks
    │   ├── molecules/             # Composite components
    │   └── organisms/             # Complex components
    ├── theme/                     # Theme configuration
    ├── animations/               # Animation components
    ├── charts/                    # Chart components
    ├── forms/                     # Form components
    ├── buttons/                   # Button components
    ├── cards/                     # Card components
    └── layouts/                   # Layout components
```

## 🎨 Design System

### Colors
- **Primary**: Blue-based color scheme for professional trading interfaces
- **Trading Colors**: Profit (green), Loss (red), Neutral (gray)
- **Background**: Dark theme optimized for trading applications
- **Surface**: Card and component backgrounds

### Typography
- **Font Family**: Inter (Google Fonts)
- **Hierarchy**: Display, Headline, Title, Body, Label styles
- **Trading Specific**: Price displays with proper formatting

### Spacing
- **Base Unit**: 8px grid system
- **Consistent**: XS (4px), SM (8px), MD (16px), LG (24px), XL (32px)

## 🧩 Components

### Atoms (Basic Building Blocks)
- **TradingButton**: Customizable buttons with multiple variants
- **TradingCard**: Flexible card components
- **PriceDisplay**: Specialized price display components

### Molecules (Composite Components)
- **OrderBook**: Buy/sell order display
- **PortfolioSummary**: Portfolio overview
- **TradingChart**: Interactive charts

### Organisms (Complex Components)
- **Dashboard**: Complete trading dashboard
- **TradingPanel**: Order placement interface
- **MarketOverview**: Market data display

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart 3.0 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_trading_ui_kit
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Integration

To use this UI kit in your existing project:

1. **Copy the UI Kit folder**
   ```bash
   cp -r lib/ui_kit/ your_project/lib/
   cp -r lib/core/ your_project/lib/
   ```

2. **Add dependencies to pubspec.yaml**
   ```yaml
   dependencies:
     flutter_svg: ^2.0.10+1
     font_awesome_flutter: ^10.6.0
     fl_chart: ^0.66.0
     google_fonts: ^6.1.0
     # ... other dependencies
   ```

3. **Import and use components**
   ```dart
   import 'package:your_project/ui_kit/components/atoms/trading_button.dart';
   import 'package:your_project/ui_kit/theme/trading_theme.dart';
   ```

## 📱 Usage Examples

### Basic Button
```dart
TradingButton(
  text: 'Buy Bitcoin',
  onPressed: () {},
  variant: TradingButtonVariant.success,
  size: TradingButtonSize.large,
  icon: Icons.add,
)
```

### Price Display
```dart
PriceDisplay(
  price: 43250.75,
  change: 1250.25,
  changePercent: 2.98,
  size: PriceDisplaySize.large,
)
```

### Trading Chart
```dart
TradingChart(
  data: chartData,
  chartType: TradingChartType.line,
  timeframe: TradingTimeframe.day1,
  height: 300,
)
```

### Portfolio Summary
```dart
PortfolioSummary(
  totalValue: 125430.50,
  totalChange: 2340.25,
  totalChangePercent: 1.9,
  availableBalance: 15000.00,
)
```

## 🎯 Architecture Patterns

### MVVM / Clean Architecture
- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources

### Feature-Driven Development
- Each feature is self-contained
- Shared components in ui_kit
- Easy to add new features

### State Management
- Provider for simple state
- Riverpod for complex state
- BLoC for advanced state management

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
// Extend TradingTheme and customize
class CustomTradingTheme extends TradingTheme {
  static ThemeData get customTheme {
    return darkTheme.copyWith(
      // Your customizations
    );
  }
}
```

## 📊 Trading Components

### Charts
- Line charts for price history
- Candlestick charts for OHLC data
- Area charts for volume
- Bar charts for comparisons

### Order Management
- Order book display
- Order placement forms
- Order history
- Trade execution

### Portfolio
- Portfolio summary
- Holdings list
- Performance metrics
- Asset allocation

## 🔧 Customization

### Colors
```dart
// Override colors in your theme
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
// Extend components for custom behavior
class CustomTradingButton extends TradingButton {
  // Your customizations
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

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## 📦 Dependencies

### Core Dependencies
- `flutter_svg`: SVG support
- `font_awesome_flutter`: Icon library
- `google_fonts`: Typography
- `fl_chart`: Chart components

### State Management
- `provider`: Simple state management
- `riverpod`: Advanced state management
- `flutter_riverpod`: Riverpod for Flutter

### Navigation
- `go_router`: Declarative routing

### Data & Storage
- `dio`: HTTP client
- `hive`: Local storage
- `shared_preferences`: Simple storage

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

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Trading community for feedback and suggestions
- Open source contributors

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Join our Discord community
- Check the documentation

---

**Built with ❤️ for the Flutter trading community**