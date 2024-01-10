import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixy/apis/apis.dart';

import '../model/message.dart';

class ChatController extends GetxController{

  final textC = TextEditingController();

  final list = <Message>[Message(msg: "let's get this conversation rolling! How can I be of service?", msgType: MessageType.bot)].obs;

  Future<void> askQuestion() async {
    if(textC.text.trim().isNotEmpty) {

      //user
      list.add(Message(msg: textC.text, msgType: MessageType.user));
      list.add(Message(msg: 'Please wait...', msgType: MessageType.bot));

      final res = await APIs.getAnswer(textC.text);

      //chatbot
      list.removeLast();
      list.add(Message(msg: res, msgType: MessageType.bot));
      textC.clear();
    }
  }
}