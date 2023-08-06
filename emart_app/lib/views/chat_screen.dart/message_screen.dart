import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen.dart/chat_screen.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messaging".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty) {
            return 
            "No No messages yet!".text.color(darkFontGrey).makeCentered();
            }else{
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context , int index){
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(()=> const ChatScreen(),
                              arguments: [
                                data[index]['friend_name'],
                                data[index]['told'],
                              ],
                              );
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(
                                Icons.person,
                                color: whiteColor,
                              ),
                            ),
                            title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
                        );
                      }),)
                  ],
                ),
              );
            }
        },
      ),
    );
  }
}