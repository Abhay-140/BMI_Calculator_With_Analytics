import 'package:flutter/material.dart';
import '../widgets/bmi_card.dart';
import '../utils/bmi_utils.dart';
import '../models/bmi_record.dart';
import '../utils/storage_helper.dart';

class ResultScreen extends StatefulWidget {
  final String name;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String date;

  const ResultScreen({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.date,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late double _bmi;
  late String _category;
  late Color _color;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _bmi = calculateBMI(widget.weight, widget.height);
    _category = getBMICategory(_bmi);
    _color = getBMIColor(_bmi);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    final record = BmiRecord(
      bmi: _bmi,
      category: _category,
      weight: widget.weight,
      height: widget.height,
      age: widget.age,
      gender: widget.gender,
      date: widget.date,
    );

    StorageHelper.saveRecord(record);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bmiString = _bmi.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: const Text("Your BMI Result",
            style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          )
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BmiCard(
                    bmi: bmiString,
                    category: _category,
                    color: _color,
                    name: widget.name,
                    age: widget.age,
                    gender: widget.gender,
                    date: widget.date,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      backgroundColor: _color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
