import 'package:chat_app/main.dart';
import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/ChatScreen.dart';


class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user,});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.accentColor,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Get.to(ChatScreen(user: widget.user,));
        },
      child:  ListTile(
        
        leading:  CircleAvatar(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.user.image))))),
        title: Text(widget.user.name),subtitle: ( Text(widget.user.about)),
        trailing: Container(width: 15,height: 15,decoration: BoxDecoration(color: AppColors.secondaryColor,borderRadius: BorderRadius.circular(50),border: Border.all(width: 2,color: AppColors.primaryColor)),),
      ),
      ),
    );
  }
}

