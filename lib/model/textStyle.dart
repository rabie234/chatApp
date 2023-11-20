import 'package:chat_app/model/appcolors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  // Heading style
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
 static const TextStyle headingImportant = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle buttonText  = TextStyle(
    fontSize: 20,fontWeight: FontWeight.bold,
    color: AppColors.colorGrey
  );
  // Subheading style
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Paragraph style
  static const TextStyle paragraphStyle = TextStyle(
    fontSize: 14,
  );
 static const TextStyle paragraphMute = TextStyle(
    fontSize: 14,
    color: AppColors.colorDarkAccent
  );

   static const TextStyle textsmall = TextStyle(
    fontSize: 12,
    color: AppColors.colorDarkAccent,
    fontWeight: FontWeight.w300
  );

  // Custom text style (you can add more as needed)
  static const TextStyle customStyle = TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.italic,
  );
}