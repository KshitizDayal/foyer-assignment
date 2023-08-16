import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ResultProvider extends ChangeNotifier {
  static ResultProvider instance = ResultProvider();
  ResultProvider();

  List<dynamic> storedProfile = [];

  late Box resultBox;

  Future<void> initHiveBox() async {
    await Hive.initFlutter();
    resultBox = await Hive.openBox('resultBox');
    await resultDataPull();
  }

  Future<void> resultDataPut() async {
    await resultBox.put("storedProfile", storedProfile);
  }

  Future<void> resultDataPull() async {
    storedProfile = await resultBox.get("storedProfile", defaultValue: []);
    notifyListeners();
  }

  Future<void> clearData() async {
    storedProfile.clear();
    await resultDataPut();
    notifyListeners();
  }

  Future<void> flushResultBox() async {
    clearData();
    await resultBox.clear();
  }
}
