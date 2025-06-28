import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bmi_record.dart';

class StorageHelper {
  static const String key = 'bmi_history';

  static Future<void> saveRecord(BmiRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    history.add(record);
    final encoded = jsonEncode(history.map((r) => r.toJson()).toList());
    await prefs.setString(key, encoded);
  }

  static Future<List<BmiRecord>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];

    final decoded = jsonDecode(jsonString) as List;
    return decoded.map((e) => BmiRecord.fromJson(e)).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
