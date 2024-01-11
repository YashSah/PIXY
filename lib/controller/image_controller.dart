import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixy/helper/global.dart';
import 'package:pixy/helper/my_dialogs.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();

  final status = Status.none.obs;

  String url = '';

  Future<void> createAIImage() async {
    if(textC.text.trim().isNotEmpty) {
      OpenAI.apiKey = apikey;
      status.value = Status.loading;

      //from dart_openai package
      OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: textC.text,
        n: 1,
        size: OpenAIImageSize.size512,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      url = image.data[0].url.toString();

      status.value = Status.complete;
    } else {
      MyDialog.info("Details matter! Help us tailor your image by providing details for your image.");
    }
  }
}