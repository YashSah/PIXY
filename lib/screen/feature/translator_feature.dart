import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pixy/controller/translate_controller.dart';
import 'package:pixy/widget/custom_btn.dart';
import 'package:pixy/widget/language_sheet.dart';

import '../../controller/image_controller.dart';
import '../../widget/custom_loading.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  final _c = TranslateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Language Translator"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //from language
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.from,)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(() => Text(_c.from.isEmpty ? "Auto" : _c.from.value)),
                ),
              ),

              //swap language button
              IconButton(
                onPressed: _c.swapLanguages,
                icon: Obx(
                      () => Icon(CupertinoIcons.repeat,
                        color: _c.to.isNotEmpty && _c.from.isNotEmpty ? Colors.blue : Colors.grey,
                      ),
                ),
              ),

              //to language
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.to,)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(() => Text(_c.to.isEmpty ? "To" : _c.to.value)),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width *0.04,
              vertical: MediaQuery.of(context).size.height * 0.035,
            ),
            child: TextFormField(
              controller: _c.textC,
              minLines: 5,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: "Translate anything you want.",
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          //result field
          Obx(() => _translateResult()),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
          
          CustomBtn(
            onTap: _c.translate,
            text: "Translate",
          ),
        ],
      ),
    );
  }

  Widget _translateResult() => Align(
    child: switch(_c.status.value) {
      Status.none => const SizedBox(),
      Status.complete => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width *0.04,
        ),
        child: TextFormField(
          controller: _c.resultC,
          maxLines: null,
          onTapOutside: (e) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      Status.loading => const CustomLoading()
    },
  );

}
