import 'dart:developer';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixy/helper/global.dart';
import 'package:pixy/helper/my_dialogs.dart';
import 'package:share_plus/share_plus.dart';

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

  void downloadImage() async {
    try {
      MyDialog.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url))).bodyBytes;
      final directory = await getTemporaryDirectory();
      final file = await File("${directory.path}/ai_image.png").writeAsBytes(bytes);

      log("filePath: ${file.path}");
      await GallerySaver.saveImage(file.path, albumName: "PIXY").then((success) {
        Get.back(); //this will hide the loading dialog when the image is saved to gallery
        MyDialog.success("Image Downloaded to Gallery!");
      });
    } catch(e) {
      Get.back();
      MyDialog.error("Something Went Wrong (Try again in sometime)!");
      log("downloadImageE: $e");
    }
  }

  void shareImage() async {
    try {
      MyDialog.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url))).bodyBytes;
      final directory = await getTemporaryDirectory();
      final file = await File("${directory.path}/ai_image.png").writeAsBytes(bytes);

      log("filePath: ${file.path}");

      Get.back();
      await Share.shareXFiles([XFile(file.path)],
          text: 'Check out this Amazing Image created by AI Assitant App by Yash Sah');
    } catch (e) {
      Get.back();
      MyDialog.error("Something Went Wrong (Try again in sometime)!");
      log("downloadImageE: $e");
    }
  }

}