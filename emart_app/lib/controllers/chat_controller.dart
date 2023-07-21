import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
  
  var chats = fierestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isloading = false.obs;

  getChatId() async {

    isloading(true);

    await chats
    .where('users',isEqualTo: {friendId: null, currentId:null})
    .limit(1)
    .get()
    .then((QuerySnapshot snapshots){
      if (snapshots.docs.isNotEmpty) {
        chatDocId = snapshots.docs.single.id;
      } else {
        chats.add(
          {
            'created_on': null,
            'last_msg':'',
            'users':{friendId: null,currentId:null},
            'told':'',
            'frontId':'',
            'front_name':friendName,
            'sender_name':senderName
            
          }
        ).then((value) {
          chatDocId = value.id;
        });
      }
    });
    isloading(false);
  }

  sendMsg(msg)async{
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
            'created_on': FieldValue.serverTimestamp(),
            'last_msg':msg,
            'told':friendId,
            'frontId':currentId,
            
      });

        chats.doc(chatDocId).collection(messagesCollection).doc().set({
          'created_on': FieldValue.serverTimestamp(),
            'msg':msg,
            'uid':currentId,
        });

    }
  }

}