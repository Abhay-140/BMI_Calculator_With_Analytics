import 'package:flutter/material.dart';
import '../models/bmi_record.dart';
import '../utils/storage_helper.dart';
import '../utils/bmi_utils.dart';
import '../widgets/bmi_chart.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<BmiRecord> records = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await StorageHelper.getHistory();
    setState(() {
      records = data.reversed.toList();
    });
  }

  double get averageBMI => records.isEmpty
      ? 0
      : records.map((e) => e.bmi).reduce((a, b) => a + b) / records.length;

  Map<String, int> get categoryCounts {
    Map<String, int> map = {
      'Underweight': 0,
      'Normal': 0,
      'Overweight': 0,
      'Obese': 0,
    };
    for (var r in records) {
      map[r.category] = (map[r.category] ?? 0) + 1;
    }
    return map;
  }

  void clearHistory() async {
    await StorageHelper.clearHistory();
    setState(() {
      records.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: clearHistory,
            tooltip: "Clear History",
          )
        ],
      ),
      body: records.isEmpty
          ? const Center(child: Text("No BMI records yet."))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Summary
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Average BMI: ${averageBMI.toStringAsFixed(1)}"),
                  const SizedBox(height: 8),
                  ...categoryCounts.entries.map((e) => Text("${e.key}: ${e.value}")),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Chart
          BmiChart(records: records),

          const SizedBox(height: 16),

          // List of records
          ...records.map((record) {
            return Card(
              color: getBMIColor(record.bmi).withOpacity(0.1),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: getBMIColor(record.bmi),
                  child: Text(record.bmi.toStringAsFixed(1)),
                ),
                title: Text("${record.gender}, ${record.age} yrs"),
                subtitle: Text("BMI: ${record.bmi.toStringAsFixed(1)} (${record.category})\n${record.date}"),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
