import 'dart:io';
import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../../controller/dialogs.dart';
import '../../main.dart';
import '../../model/textStyle.dart';
import '../../services/apis.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
_handleGoogleBtnClick(){
   Dialogs.showProgressBar(context);
APIs.signInWithGoogle(context).then((user) async {
  Get.back();
if(user !=null){
  if(await APIs.userExist()){
    
  await APIs.getSelfInfo();
      Get.off(const HomeScreen());
  }else{
   await APIs.createUser();
    await APIs.getSelfInfo();
   Get.off(const HomeScreen());
  }
   
}
});
}




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
      color: AppColors.accentColor,
      padding: EdgeInsets.symmetric(horizontal: mq.width * .1),
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: mq.height * 0.04),
          child: Column(children: [
            Image.asset(
              'images/app_icon.png',
              width: mq.height * 0.2,
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: mq.height * .1),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                _handleGoogleBtnClick();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: mq.height * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                border: BorderDirectional(
                                    end: BorderSide(
                                        color: AppColors.accentColor,
                                        width: 1))),
                            child: Icon(
                              Icons.interests_rounded,
                              size: mq.height * 0.03,
                              color: AppColors.backgroundColor,
                            )),
                        const Text(
                          "Sing Up With Google",
                          style: TextStyles.buttonText,
                        ),
                      ])),
            ),
            SizedBox(
              height: mq.height * 0.020,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Already have account ",
                  style: TextStyles.paragraphStyle,
                ),
                InkWell(
                  child: Text(
                    "Sing In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                )
              ],
            )
          ]),
        )
      ]),
    ));
  }
}
