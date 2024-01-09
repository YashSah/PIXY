import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:pixy/helper/global.dart';

class APIs {
  //get answer from chatgpt
  static Future<void> getAnswer(String question) async{

    final res = await post(Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          HttpHeaders.contentTypeHeader : 'application/json',
          HttpHeaders.authorizationHeader : 'Bearer $apikey'
        } ,
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "max_tokens": 2000,
          "temperature": 0, //0 means focussed, 50 means bit focussed and creative, 100 means creative
          "messages": [
            {"role": "user", "content": question}
          ]
        }));

    final data = jsonDecode(res.body);

    log('res: ${data["choices"][0]["message"]["content"]}');

  }
}