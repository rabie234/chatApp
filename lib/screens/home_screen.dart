
import 'package:chat_app/main.dart';
import 'package:chat_app/model/appcolors.dart';
import 'package:chat_app/model/textStyle.dart';
import 'package:chat_app/services/apis.dart';
import 'package:flutter/material.dart';
import '../model/chat_user.dart';
import '../widgets/user_chat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
@override
void initState() {
  super.initState();
}

  TextEditingController search = TextEditingController();
   final FocusNode _focusNode = FocusNode();

  List<ChatUser> list = [];
  bool isSearch = false;

  toggleSearch() {
    setState(() {
      isSearch = !isSearch;
      search.text = '';
    });
    if(isSearch){
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          drawer: Drawer(
            child: Container(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: AppColors.colorDark,width: 2))),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: mq.height * .4,
                        decoration: BoxDecoration(
                            image: DecorationImage(opacity: 0.2, 
                                fit: BoxFit.cover, image: NetworkImage(APIs.me.image))),
                      ),Positioned(
                        top: mq.height*.1,
                        left: mq.width*.05,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: mq.height*.2,
                              height: mq.height*.2,
                               decoration: BoxDecoration(
                                border: Border.all(width: 2,color: AppColors.colorDark),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage( 
                                    fit: BoxFit.cover, image: NetworkImage(APIs.me.image))),
                            ),
                            
                            Container( width: mq.width*.7, child: Text(APIs.me.email,style: TextStyles.customStyle,))
                          ],
                        ))
                    ],
                  ),
                )
              ]),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () async {
            APIs.singOutUser();
              },
              child: const Icon(
                Icons.add_comment_outlined,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
          appBar: AppBar(
            leading: isSearch ? Icon(Icons.search) : null,
            title: isSearch
                ?  TextField(
                  cursorColor: AppColors.colorDarkAccent,
                  focusNode: _focusNode,
                  controller:search ,
                    decoration:const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                        hintText: "Search...",
                        hintStyle: TextStyles.customStyle,
                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                  )
                : const Text(
                    "We chat",
                    style: TextStyles.customStyle,
                  ),
            actions: [
              IconButton(
                  onPressed: () {
                    toggleSearch();
                  },
                  icon: isSearch ? Icon(Icons.close) : Icon(Icons.search)),
            ],
          ),
          body: Container(
            color: AppColors.accentColor,
            child: StreamBuilder(
              stream:APIs.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
              
                    
    
                  case ConnectionState.none:
                 return Center(child: CircularProgressIndicator(color: AppColors.secondaryColor,),);
                  case ConnectionState.active:
                
                  case ConnectionState.done:
                }
    
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  list = data!.map((e) => ChatUser.fromJson(e.data())).toList();
                }
                if (list.isNotEmpty) {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        return ChatUserCard(
                          user: list[index],
                        );
                      }));
                } else {
                  return (const Center(
                    child: Text(
                      "No connection found",
                      style: TextStyles.subheadingStyle,
                    ),
                  ));
                }
              },
            ),
          )),
    );
  }
}
