import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixy/model/onboard.dart';
import 'package:pixy/screen/home_screen.dart';
import 'package:pixy/widget/custom_btn.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      Onboard(title: "Ask me anything", subtitle: "You can ask me anything and I am here to help you!", lottie: "ai_ask_me"),
      Onboard(title: "Imagination to Reality", subtitle: "Just Imagine anything and let me know I will create something wonderful for you!", lottie: "ai_play"),
    ];
    return Scaffold(
      body: PageView.builder(
        controller: c,
        itemCount: list.length,
        itemBuilder: (ctx, ind) {
          final isLast = ind == list.length - 1;

        return  Column(
          children: [
            Lottie.asset(
              "assets/animations/${list[ind].lottie}.json",
              height: MediaQuery.of(context).size.height * 0.6,
              width: isLast ? MediaQuery.of(context).size.width * 0.7 : null,
            ),
            Text(
              list[ind].title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.width * 0.015,),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                list[ind].subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  letterSpacing: 0.5,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            Wrap(
              spacing: 10,
              children: List.generate(list.length, (i) => Container(
                width: i == ind ? 15 : 10,
                height: 8,
                decoration: BoxDecoration(color: i == ind ? Colors.blue : Colors.grey, borderRadius: BorderRadius.all(Radius.circular(5))),
              )),
            ),

            const Spacer(),

          CustomBtn(onTap:  () {
            if(isLast) {
              Get.offAll(HomeScreen());
            } else {
              c.nextPage(
              duration: Duration(milliseconds: 600), curve: Curves.ease);
            }
            }, text: isLast ? "Finish" : "Next",),

            const Spacer(flex: 2,),
          ],
        );
      },),
    );
  }
}
