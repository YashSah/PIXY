import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/message.dart';

class ChatController extends GetxController{

  final textC = TextEditingController();

  final list = <Message>[].obs;

  void askQuestion() {
    if(textC.text.trim().isNotEmpty) {

      //user
      list.add(Message(msg: textC.text, msgType: MessageType.user));

      //chatbot
      list.add(Message(msg: 'I received your message', msgType: MessageType.bot));
      textC.clear();
    }
  }
}