class Message {
  String msg;
  final MessageType msgType;  //enum defined below where a msg can be from user or bot

  Message({required this.msg, required this.msgType});
}

enum MessageType { user, bot }