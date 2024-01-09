import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:pixy/model/home_type.dart';

class HomeCard extends StatelessWidget {
  final HomeType homeType;
  const HomeCard({super.key, required this.homeType});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    return Card(
      color: Colors.blue.withOpacity(0.2),
      elevation: 0,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: homeType.leftAlign ? Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            padding: homeType.padding,
            child: Lottie.asset(
              "assets/animations/${homeType.lottie}",
            ),
          ),

          const Spacer(),

          Text(
            homeType.title,
            style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
              letterSpacing: 1,
          )),

          const Spacer(flex: 2,),
        ],
      ) :
      Row(
        children: [

          const Spacer(flex: 2,),

          Text(
              homeType.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              )),

          const Spacer(),

          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            padding: homeType.padding,
            child: Lottie.asset(
              "assets/animations/${homeType.lottie}",
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 1.seconds, curve: Curves.easeIn);
  }
}
