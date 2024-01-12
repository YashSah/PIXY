import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pixy/controller/translate_controller.dart';

class LanguageSheet extends StatefulWidget {
  final TranslateController c;
  final RxString s;

  const LanguageSheet({super.key, required this.c, required this.s});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  final _search = ''.obs;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.04,
        right: MediaQuery.of(context).size.width * 0.04,
        top: MediaQuery.of(context).size.width * 0.02
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          TextFormField(
            // controller: _c.resultC,
            onChanged: (s) => _search.value = s.toLowerCase(),

            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.translate_rounded,
                color: Colors.blue,
              ),
              hintText: "Search for a specific language",
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              final List<String> list = _search.isEmpty ? widget.c.lang
                  : widget.c.lang.where((e) => e.toLowerCase().contains(_search.value)).toList();
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: 6,
                ),
                itemBuilder: (ctx,i) {
                  return InkWell(
                    onTap: () {
                      widget.s.value = list[i];
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(list[i]),
                    ),
                  );},);
              },
            ),
          ),
        ],
      ),
    );
  }
}
