import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixy/controller/image_controller.dart';
import 'package:pixy/widget/custom_btn.dart';

import '../../widget/custom_loading.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _c = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Image Creator"),
        
        actions: [
          Obx(() => _c.status.value == Status.complete ? IconButton(
              padding: const EdgeInsets.only(right: 6.0),
              onPressed: _c.shareImage,
              icon: const Icon(Icons.share),
            ) : const SizedBox(),
          )
        ],
      ),

      //download button
      floatingActionButton: Obx( () => _c.status.value == Status.complete ? Padding(
        padding: const EdgeInsets.only(right: 6.0, bottom: 6),
        child: FloatingActionButton(
          onPressed: _c.downloadImage,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: const Icon(Icons.save_alt_rounded, size: 26,),
        ),
      ) : const SizedBox()),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04,
        ),
        children: [
          TextFormField(
            controller: _c.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText: "Imagine something wonderful & innovative\n Type here & I will create it for you 😄",
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: Obx(() => _aiImage()),
          ),
          
          CustomBtn(onTap: _c.createAIImage, text: 'Create'),
        ],
      ),
    );
  }

  Widget _aiImage() => ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: switch(_c.status.value) {
      Status.none => Lottie.asset(
        "assets/animations/ai_play.json",
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      Status.complete => CachedNetworkImage(
        imageUrl: _c.url,
        placeholder: (context, url) => const CustomLoading(),
        errorWidget: (context, url, error) => const SizedBox(),
      ),
      Status.loading => const CustomLoading()
    },
  );
}
