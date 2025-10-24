import 'package:flutter/material.dart';
import '../../theme/colors/healthcare_colors.dart';
import '../../theme/typography/healthcare_typography.dart';

/// Health Metric Card for healthcare and fitness apps
/// Displays health metrics with trends and indicators
class HealthMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String? subtitle;
  final IconData icon;
  final Color? color;
  final HealthMetricTrend? trend;
  final String? lastUpdated;
  final VoidCallback? onTap;
  final List<HealthMetricData>? historicalData;

  const HealthMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.subtitle,
    required this.icon,
    this.color,
    this.trend,
    this.lastUpdated,
    this.onTap,
    this.historicalData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: HealthcareColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: HealthcareColors.border),
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
                _buildHeader(),
                const SizedBox(height: 12),
                _buildValueSection(),
                if (trend != null) ...[
                  const SizedBox(height: 8),
                  _buildTrendSection(),
                ],
                if (lastUpdated != null) ...[
                  const SizedBox(height: 8),
                  _buildLastUpdatedSection(),
                ],
                if (historicalData != null && historicalData!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildMiniChart(),
                ],
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
            color: (color ?? HealthcareColors.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color ?? HealthcareColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: HealthcareTypography.metricTitle),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: HealthcareTypography.metricSubtitle),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(value, style: HealthcareTypography.metricValue),
        const SizedBox(width: 4),
        Text(unit, style: HealthcareTypography.metricUnit),
      ],
    );
  }

  Widget _buildTrendSection() {
    if (trend == null) return const SizedBox.shrink();

    Color trendColor;
    IconData trendIcon;
    String trendText;

    switch (trend!.direction) {
      case HealthTrendDirection.up:
        trendColor = HealthcareColors.success;
        trendIcon = Icons.arrow_upward;
        trendText = 'Increased';
        break;
      case HealthTrendDirection.down:
        trendColor = HealthcareColors.error;
        trendIcon = Icons.arrow_downward;
        trendText = 'Decreased';
        break;
      case HealthTrendDirection.stable:
        trendColor = HealthcareColors.warning;
        trendIcon = Icons.remove;
        trendText = 'Stable';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: trendColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(trendIcon, color: trendColor, size: 14),
          const SizedBox(width: 4),
          Text(
            '$trendText ${trend!.percentage.toStringAsFixed(1)}%',
            style: HealthcareTypography.trendText.copyWith(color: trendColor),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdatedSection() {
    return Text(
      'Last updated: $lastUpdated',
      style: HealthcareTypography.lastUpdatedText,
    );
  }

  Widget _buildMiniChart() {
    return Container(
      height: 40,
      child: CustomPaint(
        painter: MiniChartPainter(
          data: historicalData!,
          color: color ?? HealthcareColors.primary,
        ),
      ),
    );
  }
}

/// Health Metric Trend model
class HealthMetricTrend {
  final HealthTrendDirection direction;
  final double percentage;
  final String? description;

  const HealthMetricTrend({
    required this.direction,
    required this.percentage,
    this.description,
  });
}

/// Health Trend Direction enum
enum HealthTrendDirection { up, down, stable }

/// Health Metric Data model
class HealthMetricData {
  final double value;
  final DateTime timestamp;

  const HealthMetricData({required this.value, required this.timestamp});
}

/// Mini Chart Painter for health metrics
class MiniChartPainter extends CustomPainter {
  final List<HealthMetricData> data;
  final Color color;

  MiniChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final minValue = data.map((d) => d.value).reduce((a, b) => a < b ? a : b);
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    final valueRange = maxValue - minValue;

    if (valueRange == 0) return;

    final stepX = size.width / (data.length - 1);
    final stepY = size.height / valueRange;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i].value - minValue) * stepY);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Fitness Activity Card for tracking workouts and activities
class FitnessActivityCard extends StatelessWidget {
  final String activityName;
  final String duration;
  final String? calories;
  final String? distance;
  final IconData icon;
  final Color? color;
  final DateTime? completedAt;
  final VoidCallback? onTap;
  final VoidCallback? onStart;

  const FitnessActivityCard({
    super.key,
    required this.activityName,
    required this.duration,
    this.calories,
    this.distance,
    required this.icon,
    this.color,
    this.completedAt,
    this.onTap,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: HealthcareColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: HealthcareColors.border),
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
                _buildHeader(),
                const SizedBox(height: 12),
                _buildActivityInfo(),
                const SizedBox(height: 12),
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
            color: (color ?? HealthcareColors.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color ?? HealthcareColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activityName, style: HealthcareTypography.activityTitle),
              if (completedAt != null) ...[
                const SizedBox(height: 2),
                Text(
                  'Completed ${_formatDate(completedAt!)}',
                  style: HealthcareTypography.activitySubtitle,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityInfo() {
    return Row(
      children: [
        _buildInfoItem('Duration', duration),
        if (calories != null) ...[
          const SizedBox(width: 16),
          _buildInfoItem('Calories', calories!),
        ],
        if (distance != null) ...[
          const SizedBox(width: 16),
          _buildInfoItem('Distance', distance!),
        ],
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: HealthcareTypography.infoLabel),
        const SizedBox(height: 2),
        Text(value, style: HealthcareTypography.infoValue),
      ],
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onStart,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? HealthcareColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Start Activity',
          style: HealthcareTypography.buttonText.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}

/// Medication Reminder Card for health management
class MedicationReminderCard extends StatelessWidget {
  final String medicationName;
  final String dosage;
  final String frequency;
  final DateTime nextDose;
  final bool isTaken;
  final VoidCallback? onMarkTaken;
  final VoidCallback? onEdit;
  final VoidCallback? onSkip;

  const MedicationReminderCard({
    super.key,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.nextDose,
    this.isTaken = false,
    this.onMarkTaken,
    this.onEdit,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: HealthcareColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isTaken ? HealthcareColors.success : HealthcareColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildMedicationInfo(),
            const SizedBox(height: 12),
            _buildActionButtons(),
          ],
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
            color: HealthcareColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.medication,
            color: HealthcareColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(medicationName, style: HealthcareTypography.medicationTitle),
              Text(
                'Next dose: ${_formatTime(nextDose)}',
                style: HealthcareTypography.medicationSubtitle,
              ),
            ],
          ),
        ),
        if (isTaken)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: HealthcareColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Taken',
              style: HealthcareTypography.statusText.copyWith(
                color: HealthcareColors.success,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMedicationInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HealthcareColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildInfoRow('Dosage', dosage),
          const SizedBox(height: 8),
          _buildInfoRow('Frequency', frequency),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: HealthcareTypography.infoLabel),
        Text(value, style: HealthcareTypography.infoValue),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (!isTaken) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: onMarkTaken,
              style: ElevatedButton.styleFrom(
                backgroundColor: HealthcareColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Mark as Taken',
                style: HealthcareTypography.buttonText.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        OutlinedButton(
          onPressed: onEdit,
          style: OutlinedButton.styleFrom(
            foregroundColor: HealthcareColors.primary,
            side: BorderSide(color: HealthcareColors.primary),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Edit', style: HealthcareTypography.buttonText),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: onSkip,
          style: OutlinedButton.styleFrom(
            foregroundColor: HealthcareColors.error,
            side: BorderSide(color: HealthcareColors.error),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Skip', style: HealthcareTypography.buttonText),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }
}
