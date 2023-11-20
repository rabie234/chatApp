import 'package:chat_app/main.dart';
import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/model/textStyle.dart';
import 'package:chat_app/services/apis.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';
import '../services/my_date_util.dart';


class MessageCard extends StatefulWidget {
  final Message msg ;
  const MessageCard({super.key, required this.msg});
  

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return widget.msg.fromId == APIs.user!.uid?_outgoingMsg():_commingMsg();
  }

  Widget _commingMsg(){
    if(widget.msg.read.isEmpty){
      APIs.updateMessageStatusRead(widget.msg);
    }
return Row(
  children: [
        Flexible(
          child: Container(
            
              padding: EdgeInsets.all(mq.width*.04),
              margin: EdgeInsets.symmetric(vertical: mq.height*.01,horizontal: mq.width*.04),
              
            decoration: BoxDecoration(color: AppColors.colorGrey,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
            border: Border.all(color: AppColors.colorDark,width: 1)
            ),
            
              child: Text(widget.msg.msg,style: TextStyle(color: AppColors.colorDark),),
            
            ),
        ),
    Text(MyDateUtil.getFormateTime(context: context, time: widget.msg.sent) ,style: TextStyles.textsmall,),SizedBox(width: mq.width*.04,)
  ],
  
);
}


Widget _outgoingMsg(){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.end,
  children: [
    SizedBox(width: mq.width*.04,),
    Text(MyDateUtil.getFormateTime(context: context, time: widget.msg.sent),style: TextStyles.textsmall,),
        Flexible(
          child: Stack(
            children: [
              Container(
                  
                    padding: EdgeInsets.all(mq.width*.04),
                    margin: EdgeInsets.symmetric(vertical: mq.height*.01,horizontal: mq.width*.04),
                    
                  decoration: BoxDecoration(color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
                  border: Border.all(color: AppColors.colorDark,width: 1)
                  ),
                  
                    child: Text(widget.msg.msg,style: TextStyle(color: AppColors.colorDark),),
                  
                  ),
            ],
          ),
        ),
   Icon(Icons.done_all_outlined,color:widget.msg.read.isNotEmpty?AppColors.secondaryColor: AppColors.backgroundColor,size: 17,)
,SizedBox(width: 8,)
  ],
  );
}
}


