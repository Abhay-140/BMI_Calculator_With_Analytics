import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final void Function(String) onGenderChanged;
  final List<String> options;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
    this.options = const ['Male', 'Female'],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((gender) {
        final isSelected = selectedGender == gender;
        return Expanded(
          child: GestureDetector(
            onTap: () => onGenderChanged(gender),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade400,
                ),
              ),
              child: Center(
                child: Text(
                  gender,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
