import 'package:flutter/material.dart';

/// Healthcare & Fitness Color Palette
/// Comprehensive color system for health and fitness applications
class HealthcareColors {
  // Primary Colors
  static const Color primary = Color(0xFF059669); // Green
  static const Color primaryLight = Color(0xFF10B981);
  static const Color primaryDark = Color(0xFF047857);

  // Secondary Colors
  static const Color secondary = Color(0xFF3B82F6); // Blue
  static const Color secondaryLight = Color(0xFF60A5FA);
  static const Color secondaryDark = Color(0xFF2563EB);

  // Accent Colors
  static const Color accent = Color(0xFF8B5CF6); // Purple
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color accentDark = Color(0xFF7C3AED);

  // Success Colors (Green)
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  // Error Colors (Red)
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  // Warning Colors (Orange)
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  // Info Colors (Cyan)
  static const Color info = Color(0xFF06B6D4);
  static const Color infoLight = Color(0xFF22D3EE);
  static const Color infoDark = Color(0xFF0891B2);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderDark = Color(0xFFCBD5E1);

  // Health Specific Colors
  static const Color healthGood = Color(0xFF10B981);
  static const Color healthFair = Color(0xFFF59E0B);
  static const Color healthPoor = Color(0xFFEF4444);
  static const Color healthCritical = Color(0xFFDC2626);

  // Fitness Specific Colors
  static const Color fitnessCardio = Color(0xFFEF4444);
  static const Color fitnessStrength = Color(0xFF8B5CF6);
  static const Color fitnessFlexibility = Color(0xFF06B6D4);
  static const Color fitnessBalance = Color(0xFF10B981);

  // Medical Specialties Colors
  static const Color cardiology = Color(0xFFEF4444);
  static const Color neurology = Color(0xFF8B5CF6);
  static const Color dermatology = Color(0xFFF59E0B);
  static const Color pediatrics = Color(0xFF06B6D4);
  static const Color orthopedics = Color(0xFF10B981);
  static const Color psychiatry = Color(0xFFEC4899);

  // Vital Signs Colors
  static const Color heartRate = Color(0xFFEF4444);
  static const Color bloodPressure = Color(0xFF8B5CF6);
  static const Color temperature = Color(0xFFF59E0B);
  static const Color oxygenSaturation = Color(0xFF06B6D4);
  static const Color weight = Color(0xFF10B981);
  static const Color height = Color(0xFF64748B);

  // Medication Colors
  static const Color medicationActive = Color(0xFF10B981);
  static const Color medicationInactive = Color(0xFF94A3B8);
  static const Color medicationExpired = Color(0xFFEF4444);
  static const Color medicationWarning = Color(0xFFF59E0B);

  // Appointment Status Colors
  static const Color appointmentScheduled = Color(0xFF3B82F6);
  static const Color appointmentConfirmed = Color(0xFF10B981);
  static const Color appointmentCancelled = Color(0xFFEF4444);
  static const Color appointmentCompleted = Color(0xFF64748B);

  // Telemedicine Colors
  static const Color videoCall = Color(0xFF3B82F6);
  static const Color audioCall = Color(0xFF10B981);
  static const Color chat = Color(0xFF8B5CF6);
  static const Color consultation = Color(0xFFF59E0B);

  // Health Records Colors
  static const Color prescription = Color(0xFF10B981);
  static const Color labReport = Color(0xFF06B6D4);
  static const Color xray = Color(0xFF8B5CF6);
  static const Color consultationRecord = Color(0xFFF59E0B);
  static const Color dischargeSummary = Color(0xFFEF4444);

  // Fitness Activity Colors
  static const Color running = Color(0xFFEF4444);
  static const Color cycling = Color(0xFF3B82F6);
  static const Color swimming = Color(0xFF06B6D4);
  static const Color walking = Color(0xFF10B981);
  static const Color yoga = Color(0xFF8B5CF6);
  static const Color weightlifting = Color(0xFF64748B);

  // Nutrition Colors
  static const Color calories = Color(0xFFF59E0B);
  static const Color protein = Color(0xFFEF4444);
  static const Color carbs = Color(0xFF8B5CF6);
  static const Color fat = Color(0xFF06B6D4);
  static const Color fiber = Color(0xFF10B981);
  static const Color vitamins = Color(0xFFEC4899);

  // Mental Health Colors
  static const Color moodHappy = Color(0xFF10B981);
  static const Color moodNeutral = Color(0xFFF59E0B);
  static const Color moodSad = Color(0xFF3B82F6);
  static const Color moodAnxious = Color(0xFFEF4444);
  static const Color moodStressed = Color(0xFF8B5CF6);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF059669), Color(0xFF10B981)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
  );

  static const LinearGradient errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEF4444), Color(0xFFF87171)],
  );

  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
  );

  static const LinearGradient healthGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
  );

  static const LinearGradient fitnessGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
  );

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVariant = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);

  // Utility Methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color lighten(Color color, double amount) {
    return Color.lerp(color, Colors.white, amount) ?? color;
  }

  static Color darken(Color color, double amount) {
    return Color.lerp(color, Colors.black, amount) ?? color;
  }

  // Get color by health status
  static Color getHealthStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
      case 'good':
        return healthGood;
      case 'fair':
        return healthFair;
      case 'poor':
        return healthPoor;
      case 'critical':
        return healthCritical;
      default:
        return textSecondary;
    }
  }

  // Get color by appointment status
  static Color getAppointmentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return appointmentScheduled;
      case 'confirmed':
        return appointmentConfirmed;
      case 'cancelled':
        return appointmentCancelled;
      case 'completed':
        return appointmentCompleted;
      default:
        return textSecondary;
    }
  }

  // Get color by medical specialty
  static Color getSpecialtyColor(String specialty) {
    switch (specialty.toLowerCase()) {
      case 'cardiology':
        return cardiology;
      case 'neurology':
        return neurology;
      case 'dermatology':
        return dermatology;
      case 'pediatrics':
        return pediatrics;
      case 'orthopedics':
        return orthopedics;
      case 'psychiatry':
        return psychiatry;
      default:
        return primary;
    }
  }

  // Get color by fitness activity
  static Color getFitnessActivityColor(String activity) {
    switch (activity.toLowerCase()) {
      case 'running':
        return running;
      case 'cycling':
        return cycling;
      case 'swimming':
        return swimming;
      case 'walking':
        return walking;
      case 'yoga':
        return yoga;
      case 'weightlifting':
        return weightlifting;
      default:
        return primary;
    }
  }

  // Get color by vital sign
  static Color getVitalSignColor(String vitalSign) {
    switch (vitalSign.toLowerCase()) {
      case 'heart rate':
        return heartRate;
      case 'blood pressure':
        return bloodPressure;
      case 'temperature':
        return temperature;
      case 'oxygen saturation':
        return oxygenSaturation;
      case 'weight':
        return weight;
      case 'height':
        return height;
      default:
        return primary;
    }
  }
}
