import 'package:flutter/material.dart';

double calculateBMI(double weightKg, double heightCm) {
  double heightM = heightCm / 100;
  return weightKg / (heightM * heightM);
}

String getBMICategory(double bmi) {
  if (bmi < 18.5) return "Underweight";
  if (bmi < 25) return "Normal";
  if (bmi < 30) return "Overweight";
  return "Obese";
}

Color getBMIColor(double bmi) {
  if (bmi < 18.5) return Colors.blueAccent;
  if (bmi < 25) return Colors.green;
  if (bmi < 30) return Colors.orange;
  return Colors.redAccent;
}
