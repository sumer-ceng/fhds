import 'package:flutter/material.dart';

class AppColors {
  // Primary Hospital Blues
  static const Color primaryDeep = Color(0xFF0A2A4A);
  static const Color primaryMid = Color(0xFF0A6FA8);
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color primaryAccent = Color(0xFF00BCD4);

  // Medical Greens
  static const Color medicalGreen = Color(0xFF00897B);
  static const Color medicalGreenLight = Color(0xFF4CAF50);

  // Emergency Red
  static const Color emergencyRed = Color(0xFFE53935);

  // Backgrounds
  static const Color bgDark = Color(0xFFF5F7FA);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgGlass = Color(0x1A0A6FA8);

  // Text
  static const Color textPrimary = Color(0xFF1A2B3C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textHint = Color(0xFFA0AEC0);

  // Borders
  static const Color borderGlow = Color(0xFF2196F3);
  static const Color borderSubtle = Color(0xFFE2E8F0);

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F7FA), Color(0xFFE2E8F0)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF0A6FA8), Color(0xFF00BCD4)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F7FA)],
  );
}

class AppTextStyles {
  static const TextStyle displayLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
    letterSpacing: 0.8,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1.2,
  );
}
