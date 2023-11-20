import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/auth/splach_screen.dart';
import 'package:chat_app/screens/auth/start_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'firebase_options.dart';
import 'model/appcolors.dart';

late Size mq ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iChat App',
      theme: ThemeData(
primaryColor: AppColors.primaryColor,
      accentColor: AppColors.accentColor,
      backgroundColor: AppColors.backgroundColor,
      textTheme: const TextTheme(bodyText1: TextStyle()),

        appBarTheme:const AppBarTheme(
      
        backgroundColor: AppColors.primaryColor
        )
      ),
      home: const SplachScreen(),
    );
  }
}



initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}