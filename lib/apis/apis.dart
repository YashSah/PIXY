import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:pixy/helper/global.dart';

class APIs {
  //get answer from chatgpt
  static Future<String> getAnswer(String question) async{

    try{
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

      log('res: $data');
      return data["choices"][0]["message"]["content"];
    } catch (e) {
        log('getAnswerE: $e');
        return "Something went wrong (Try again in sometime)";
    }
  }

  static Future<List<String>> searchAiImages(String prompt) async {
    try{
      final res = await get(Uri.parse('https://lexica.art/api/v1/search?q=$prompt'));

      final data = jsonDecode(res.body);

      return List.from(data['images']).map((e) => e['src'].toString()).toList();
    } catch(e) {
      log('searchAiImageE: $e');
      return [];
    }
  }
}