import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixy/controller/chat_controller.dart';
import 'package:pixy/widget/message_card.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with AI Assistant"),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _c.textC,
              textAlign: TextAlign.center,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                hintText: "Ask me anything you want...",
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),),

            const SizedBox(width: 8,),

            CircleAvatar(
              radius: 24,
              child: IconButton(
                onPressed: _c.askQuestion,
                icon: const  Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      ),

      body: Obx(() => ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        children: _c.list.map((e) => MessageCard(message: e)).toList(),
        ),
      ),
    );
  }
}
