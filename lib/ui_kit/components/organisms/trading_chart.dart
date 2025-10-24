import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors/trading_colors.dart';
import '../../../core/constants/app_sizes/trading_sizes.dart';

/// Trading Chart Component
/// A comprehensive chart component for trading applications
class TradingChart extends StatefulWidget {
  const TradingChart({
    super.key,
    required this.data,
    this.title,
    this.subtitle,
    this.chartType = TradingChartType.line,
    this.timeframe = TradingTimeframe.day1,
    this.showGrid = true,
    this.showBorders = true,
    this.showTitles = true,
    this.isLoading = false,
    this.onTimeframeChanged,
    this.onChartTypeChanged,
    this.height = 300.0,
  });

  final List<TradingDataPoint> data;
  final String? title;
  final String? subtitle;
  final TradingChartType chartType;
  final TradingTimeframe timeframe;
  final bool showGrid;
  final bool showBorders;
  final bool showTitles;
  final bool isLoading;
  final Function(TradingTimeframe)? onTimeframeChanged;
  final Function(TradingChartType)? onChartTypeChanged;
  final double height;

  @override
  State<TradingChart> createState() => _TradingChartState();
}

class _TradingChartState extends State<TradingChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(TradingSizes.md),
      decoration: BoxDecoration(
        color: TradingColors.surface,
        borderRadius: BorderRadius.circular(TradingSizes.radiusMd),
        border: widget.showBorders
            ? Border.all(color: TradingColors.border)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.subtitle != null) ...[
            _buildHeader(),
            const SizedBox(height: TradingSizes.md),
          ],
          if (widget.isLoading)
            _buildLoadingState()
          else
            Expanded(child: _buildChart()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                Text(
                  widget.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              if (widget.subtitle != null) ...[
                const SizedBox(height: TradingSizes.xs),
                Text(
                  widget.subtitle!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
        _buildControls(),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTimeframeSelector(),
        const SizedBox(width: TradingSizes.sm),
        _buildChartTypeSelector(),
      ],
    );
  }

  Widget _buildTimeframeSelector() {
    return DropdownButton<TradingTimeframe>(
      value: widget.timeframe,
      onChanged: (value) => widget.onTimeframeChanged?.call(value!),
      items: TradingTimeframe.values.map((timeframe) {
        return DropdownMenuItem(
          value: timeframe,
          child: Text(timeframe.displayName),
        );
      }).toList(),
      underline: Container(),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _buildChartTypeSelector() {
    return DropdownButton<TradingChartType>(
      value: widget.chartType,
      onChanged: (value) => widget.onChartTypeChanged?.call(value!),
      items: TradingChartType.values.map((type) {
        return DropdownMenuItem(value: type, child: Text(type.displayName));
      }).toList(),
      underline: Container(),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: TradingColors.primary),
          const SizedBox(height: TradingSizes.md),
          Text(
            'Loading chart data...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    switch (widget.chartType) {
      case TradingChartType.line:
        return _buildLineChart();
      case TradingChartType.candlestick:
        return _buildCandlestickChart();
      case TradingChartType.area:
        return _buildAreaChart();
      case TradingChartType.bar:
        return _buildBarChart();
    }
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: widget.showGrid,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: TradingColors.border, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: TradingColors.border, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: widget.showTitles,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  _formatXAxisLabel(value),
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  _formatYAxisLabel(value),
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: widget.showBorders,
          border: Border.all(color: TradingColors.border),
        ),
        minX: 0,
        maxX: widget.data.length.toDouble() - 1,
        minY: _getMinY(),
        maxY: _getMaxY(),
        lineBarsData: [
          LineChartBarData(
            spots: _getLineSpots(),
            isCurved: true,
            color: TradingColors.primary,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }

  Widget _buildCandlestickChart() {
    // Simplified candlestick implementation
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: widget.showGrid),
        titlesData: FlTitlesData(show: widget.showTitles),
        borderData: FlBorderData(show: widget.showBorders),
        lineBarsData: [
          LineChartBarData(
            spots: _getLineSpots(),
            isCurved: false,
            color: TradingColors.primary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: widget.showGrid),
        titlesData: FlTitlesData(show: widget.showTitles),
        borderData: FlBorderData(show: widget.showBorders),
        lineBarsData: [
          LineChartBarData(
            spots: _getLineSpots(),
            isCurved: true,
            color: TradingColors.primary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: TradingColors.primary.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: widget.showGrid),
        titlesData: FlTitlesData(show: widget.showTitles),
        borderData: FlBorderData(show: widget.showBorders),
        barGroups: _getBarGroups(),
        maxY: _getMaxY(),
      ),
    );
  }

  List<FlSpot> _getLineSpots() {
    return widget.data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value);
    }).toList();
  }

  List<BarChartGroupData> _getBarGroups() {
    return widget.data.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.value,
            color: TradingColors.primary,
            width: 4,
          ),
        ],
      );
    }).toList();
  }

  double _getMinY() {
    if (widget.data.isEmpty) return 0;
    return widget.data.map((e) => e.value).reduce((a, b) => a < b ? a : b) *
        0.95;
  }

  double _getMaxY() {
    if (widget.data.isEmpty) return 100;
    return widget.data.map((e) => e.value).reduce((a, b) => a > b ? a : b) *
        1.05;
  }

  String _formatXAxisLabel(double value) {
    if (widget.data.isEmpty) return '';
    final index = value.toInt();
    if (index >= 0 && index < widget.data.length) {
      return widget.data[index].label;
    }
    return '';
  }

  String _formatYAxisLabel(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }
}

/// Trading Data Point
class TradingDataPoint {
  const TradingDataPoint({
    required this.value,
    required this.label,
    this.timestamp,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });

  final double value;
  final String label;
  final DateTime? timestamp;
  final double? open;
  final double? high;
  final double? low;
  final double? close;
  final double? volume;
}

/// Trading Chart Types
enum TradingChartType {
  line,
  candlestick,
  area,
  bar;

  String get displayName {
    switch (this) {
      case TradingChartType.line:
        return 'Line';
      case TradingChartType.candlestick:
        return 'Candlestick';
      case TradingChartType.area:
        return 'Area';
      case TradingChartType.bar:
        return 'Bar';
    }
  }
}

/// Trading Timeframes
enum TradingTimeframe {
  minute1,
  minute5,
  minute15,
  minute30,
  hour1,
  hour4,
  day1,
  week1,
  month1;

  String get displayName {
    switch (this) {
      case TradingTimeframe.minute1:
        return '1m';
      case TradingTimeframe.minute5:
        return '5m';
      case TradingTimeframe.minute15:
        return '15m';
      case TradingTimeframe.minute30:
        return '30m';
      case TradingTimeframe.hour1:
        return '1h';
      case TradingTimeframe.hour4:
        return '4h';
      case TradingTimeframe.day1:
        return '1d';
      case TradingTimeframe.week1:
        return '1w';
      case TradingTimeframe.month1:
        return '1M';
    }
  }
}
