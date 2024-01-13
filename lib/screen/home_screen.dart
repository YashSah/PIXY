import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pixy/apis/apis.dart';
import 'package:pixy/helper/pref.dart';
import 'package:pixy/model/home_type.dart';
import 'package:pixy/widget/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Get.isDarkMode.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
  }
  
  @override
  Widget build(BuildContext context) {

    // APIs.getAnswer("hii");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PIXY",
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
              onPressed: () {
                Get.changeThemeMode(_isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
                _isDarkMode.value = !_isDarkMode.value;
                Pref.isDarkMode = _isDarkMode.value;
              },
              icon: Obx(
                () => Icon(
                  _isDarkMode.value
                      ? Icons.brightness_2_rounded
                      : Icons.brightness_5_rounded,
                  size: 26,
                ),
              ),
          ),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04, vertical: MediaQuery.of(context).size.height * 0.015),
        children:
          HomeType.values.map((e) => HomeCard(homeType: e,)).toList(),
      )
    );
  }
}
