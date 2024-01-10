import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  final textC = TextEditingController();

  Future<void> askQuestion() async {
    if(textC.text.trim().isNotEmpty) {
      textC.text = '';
    }
  }
}