import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/model/textStyle.dart';
import 'package:chat_app/screens/auth/start_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../services/apis.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
     
    super.initState();
    
      APIs.getSelfInfo();
    Future.delayed(const Duration(seconds: 6),()  {
         mq = MediaQuery.of(context).size;
      if(APIs.auth.currentUser !=null) {
      
          APIs.getSelfInfo().then((value) =>  Get.off(const HomeScreen()));
   
      
    
      }else{
         Get.off(const StartScreen());
      }
     
    });
  }
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'images/app_icon.png',
              width: mq.height * 0.2,
            ),
            SizedBox(height: mq.height*.2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Text("Built by " ,style: TextStyles.paragraphStyle,),
                Text("Rabie kwayder ❤️❤️",style: TextStyle(letterSpacing: .9, fontSize: 15, color: AppColors.secondaryColor,fontWeight: FontWeight.bold),)

              ],
            )
          ])
        ),
      
      ]),
    ));
  }
}
