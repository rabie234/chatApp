import 'dart:io';

import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/dialogs.dart';
import '../main.dart';
import '../screens/auth/login_screen.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User? get user {
    if (auth.currentUser != null) {
      return auth.currentUser;
    } else {
      // Handle the case where the user is not signed in
      return null; // Or return a default user or take any other appropriate action.
    }
  }

  static late ChatUser me;

  static Future<bool> userExist() async {
    return (await firestore.collection('users').doc(user!.uid).get()).exists;
  }

  static Future<void> getSelfInfo() async {
    await initializeFirebase();
    if (user != null) {
      await firestore
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((user) async {
        if (user.exists) {
          me = ChatUser.fromJson(user.data()!);
          return me;
        } else {
          await createUser().then((user) {
            getSelfInfo();
            return me;
          });
        }
      });
    }
  }

  static Future<void> signInwithGoogle() async {}

  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print(e);
        Dialogs.showSnackbars(context, 'Somthing went wrong ,Please try again');
      }
    }
    return null;
    // Once signed in, return the UserCredential
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatuser = ChatUser(
        image: user!.photoURL.toString(),
        name: user!.displayName.toString(),
        createdAt: time,
        id: user!.uid,
        isOnline: false,
        lastActivated: time,
        pushToken: '',
        about: 'hello their',
        email: user!.email.toString());

    return await firestore
        .collection('users')
        .doc(user!.uid)
        .set(chatuser.toJson());
  }

  static singOutUser() async {
    Get.off(const LogInScreen());
    auth.signOut();
    await GoogleSignIn().signOut();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user!.uid)
        .snapshots();
  }

  // *****************chat api*************************

  static String getConversationId(String id) =>
      user!.uid.hashCode <= id.hashCode
          ? '${user!.uid}_$id'
          : '${id}_${user!.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage(ChatUser chatuser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final message = Message(
        msg: msg,
        read: '',
        toId: chatuser.id,
        type: 'text',
        fromId: user!.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationId(chatuser.id)}/messages/');
    await ref.doc().set(message.toJson());
  }

  static Future<void> updateMessageStatusRead(Message msg) async {
    if (kDebugMode) {
      print('chats/${getConversationId(msg.fromId)}/messages/');
    }
     firestore
        .collection('chats/${getConversationId(msg.fromId)}/messages/')


        .doc(msg.fromId)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}
