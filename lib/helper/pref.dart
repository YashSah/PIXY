import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Pref{
  static late Box _box;

  static Future<void> initialize() async{
    //for initializing hive to use app directory
    final dir = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = dir.path;
    _box = Hive.box(name: 'myData');
  }
  
  static bool get showOnboarding =>
      _box.get('showOnboarding', defaultValue: true);
  static set showOnboarding(bool v) => _box.put('showOnboarding', v);



  //for storing theme data
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  static ThemeMode get defaultTheme {
    final data = _box.get('isDarkMode');
    log('data: $data');
    if(data == null) return ThemeMode.system;
    if(data == true) {
      return ThemeMode.dark;
    }
    else {
      return ThemeMode.light;
    }
  }

}

