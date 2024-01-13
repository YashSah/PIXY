import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:pixy/helper/global.dart';

class AppWrite {
  static final _client = Client();
  static final _database = Databases(_client);

  static void init() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('65a2d23c78335b654dcd')
        .setSelfSigned(
        status: true);
    getApiKey();
  }

  static Future<String> getApiKey () async{
    try{
      final d = await _database.getDocument(
        databaseId: 'MyDatabase',
        collectionId: 'ApiKey',
        documentId: 'chatGptKey',
      );
      
      apikey = d.data['apiKey'];
      log(apikey);
      return apikey;

    } catch(e) {
      log('$e');
      return '';
    }
  }
}