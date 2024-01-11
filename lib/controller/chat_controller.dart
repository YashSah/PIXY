import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixy/apis/apis.dart';
import 'package:pixy/helper/my_dialogs.dart';

import '../model/message.dart';

class ChatController extends GetxController{

  final textC = TextEditingController();

  final scrollC = ScrollController();

  final list = <Message>[Message(msg: "let's get this conversation rolling! How can I be of service?", msgType: MessageType.bot)].obs;

  Future<void> askQuestion() async {
    if(textC.text.trim().isNotEmpty) {

      //user
      list.add(Message(msg: textC.text, msgType: MessageType.user));
      list.add(Message(msg: '', msgType: MessageType.bot));
      _scrollDown();

      final res = await APIs.getAnswer(textC.text);

      //chatbot
      list.removeLast();
      list.add(Message(msg: res, msgType: MessageType.bot));
      _scrollDown();

      textC.clear();
    } else {
      MyDialog.info("Looks like you forgot to type something. Please enter a message.");
    }
  }

  //for moving to the end message
  void _scrollDown() {
    scrollC.animateTo(scrollC.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}