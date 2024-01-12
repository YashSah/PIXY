import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixy/helper/my_dialogs.dart';

class TranslateController extends GetxController{

  final textC = TextEditingController();
  final resultC = TextEditingController();

  final from = ''.obs, to = ''.obs;

  Future<void> askQuestion() async {
    if(textC.text.trim().isNotEmpty) {

      // final res = await APIs.getAnswer(textC.text);

      textC.clear();
    } else {
      MyDialog.info("Looks like you forgot to type something. Please enter a message.");
    }
  }

}