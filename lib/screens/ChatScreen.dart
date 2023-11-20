import 'dart:convert';
import 'dart:io';

import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/services/apis.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../main.dart';
import '../model/message.dart';
import '../model/textStyle.dart';
import '../widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _message = TextEditingController();
  bool emojiShowing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  List<Message> list = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (emojiShowing) {
            setState(() {
              emojiShowing = false;
            });
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.user.image))))),
                SizedBox(
                  width: mq.width * .04,
                ),
                SizedBox(
                  width: mq.width * .38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: TextStyles.customStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: mq.height * .01,
                      ),
                      const Text(
                        'Last Seen at 12:30 pm ',
                        style: TextStyle(
                            color: AppColors.colorGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: AppColors.accentColor,
            child: Column(children: [
              Expanded(
                  child: StreamBuilder(
                stream: APIs.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:

                    case ConnectionState.none:
                      return Container();
                    case ConnectionState.active:

                    case ConnectionState.done:
                  }

                  if (snapshot.hasData) {
                    final data = snapshot.data?.docs;
                    list =
                        data!.map((e) => Message.fromJson(e.data())).toList();
                  }
                  // final list = ['fsdfs','hfdagedfg'];
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: mq.height * .01),
                        physics: const BouncingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: ((context, index) {
                          // return ChatUserCard(
                          //   user: list[index],
                          // );
                          return (MessageCard(
                            msg: list[index],
                          ));
                        }));
                  } else {
                    return (Center(
                      child: Text(
                        "Say hay to ${widget.user.name} 👋",
                        style: TextStyles.subheadingStyle,
                      ),
                    ));
                  }
                },
              )),
              _chatInput(),
              if (emojiShowing)
                SizedBox(
                  height: mq.height * .35,
                  child: EmojiPicker(
                    onBackspacePressed: () {
                      setState(() {
                        emojiShowing = false;
                      });
                    },

                    textEditingController: _message,

                    // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]

                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      bgColor: AppColors.accentColor,
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        emojiShowing = !emojiShowing;
                      });
                    },
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: AppColors.accentColor,
                    )),
                Expanded(
                    child: TextField(
                  onTap: () {
                    if (emojiShowing) {
                      setState(() {
                        emojiShowing = false;
                      });
                    }
                  },
                  controller: _message,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Message ...'),
                )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: AppColors.accentColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt,
                      color: AppColors.accentColor,
                    )),
                SizedBox(
                    width: mq.width * .15,
                    child: MaterialButton(
                      padding: const EdgeInsets.all(10),
                      onPressed: () {
                        if (_message.text.isNotEmpty) {
                          APIs.sendMessage(widget.user, _message.text);
                          _message.text = '';
                        }
                      },
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.send,
                        color: AppColors.backgroundColor,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
