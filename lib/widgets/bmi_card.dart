import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BmiCard extends StatelessWidget {
  final String bmi;
  final String category;
  final Color color;
  final String name;
  final int age;
  final String gender;
  final String date;

  const BmiCard({
    super.key,
    required this.bmi,
    required this.category,
    required this.color,
    required this.name,
    required this.age,
    required this.gender,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hello, $name!",
              style: kLabelStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              "Age: $age  |  Gender: $gender",
              style: kLabelStyle.copyWith(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              "Date: $date",
              style: kLabelStyle.copyWith(fontSize: 14, color: Colors.black45),
            ),
            const Divider(height: 30, thickness: 1.5),
            Text(
              "Your BMI is",
              style: kLabelStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              bmi,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
