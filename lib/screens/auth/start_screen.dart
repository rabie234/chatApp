import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../model/textStyle.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: AppColors.accentColor,
      padding: EdgeInsets.symmetric(horizontal: mq.width * .1),
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: mq.height*0.04),
          child: Column(children: [
            Image.asset(
              'images/app_icon.png',
              width: mq.height * 0.2,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('images/back.png'),
            const Text(
              "Welcome To Our Chat",
              style: TextStyles.headingImportant,
            ),
            SizedBox(
              height: mq.height*0.02,
            ),
            const Text(
              "Communicate with your friends and other people you dont know",
              textAlign: TextAlign.center,
              style: TextStyles.paragraphMute,
            )
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: mq.height*.1),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Get.off(const LogInScreen());
              },
              child: Container(
                  height: mq.height*0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                        Text(
                          "Get Started",
                          style: TextStyles.buttonText,
                        ),
                        Icon(Icons.arrow_right,color: AppColors.backgroundColor,)
                      ])),
            ), SizedBox(height: mq.height*0.020,),
            Row(mainAxisAlignment: MainAxisAlignment.center,children:const [Text("Already have account ",style: TextStyles.paragraphStyle,),InkWell(child: Text("Sing In",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primaryColor),),)],)
          ]),
        )
      ]),
    ));
  }
}
