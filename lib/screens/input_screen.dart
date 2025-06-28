import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import '../widgets/gender_selector.dart';
import '../widgets/custom_text_field.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  int age = 0;
  String gender = 'Male';
  double height = 0.0;
  double weight = 0.0;

  bool isMetric = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void toggleUnitSystem() {
    setState(() {
      isMetric = !isMetric;
    });
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      double finalHeight = height;
      double finalWeight = weight;

      if (!isMetric) {
        finalHeight = height * 2.54; // inches to cm
        finalWeight = weight * 0.453592; // lbs to kg
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            name: name,
            gender: gender,
            height: finalHeight,
            weight: finalWeight,
            age: age,
            date: DateFormat('dd MMM yyyy – hh:mm a').format(DateTime.now()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final unitText = isMetric ? 'cm / kg' : 'inches / lbs';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          margin: const EdgeInsets.all(4),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    label: 'Name',
                    onChanged: (val) => name = val,
                    validator: (val) => val!.isEmpty ? 'Enter name' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: ageController,
                    label: 'Age',
                    keyboardType: TextInputType.number,
                    onChanged: (val) => age = int.tryParse(val) ?? 0,
                    validator: (val) {
                      final v = int.tryParse(val!);
                      if (v == null || v <= 0) return 'Invalid age';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  GenderSelector(
                    selectedGender: gender,
                    onGenderChanged: (val) => setState(() => gender = val),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Units: $unitText', style: kLabelStyle),
                      Switch(
                        value: isMetric,
                        onChanged: (_) => toggleUnitSystem(),
                        activeColor: Colors.green,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: heightController,
                    label: 'Height (${isMetric ? "cm" : "inches"})',
                    keyboardType: TextInputType.number,
                    onChanged: (val) => height = double.tryParse(val) ?? 0.0,
                    validator: (val) {
                      final v = double.tryParse(val!);
                      if (v == null || v <= 0) return 'Invalid height';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: weightController,
                    label: 'Weight (${isMetric ? "kg" : "lbs"})',
                    keyboardType: TextInputType.number,
                    onChanged: (val) => weight = double.tryParse(val) ?? 0.0,
                    validator: (val) {
                      final v = double.tryParse(val!);
                      if (v == null || v <= 0) return 'Invalid weight';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Calculate BMI',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 45,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      },
                      icon: const Icon(Icons.history),
                      label: const Text(
                        "View History",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
