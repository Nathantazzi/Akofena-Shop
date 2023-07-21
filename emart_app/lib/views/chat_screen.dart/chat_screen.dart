import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/chat_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen.dart/components/sender_bubble.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(()=>controller.isloading.value
            ?Center(
                    child: loadingIndicator(),
                ):
                  Expanded(child: StreamBuilder(
                stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if(snapshot.data!.docs.isEmpty){
                    return Center(
                      child: "Send a Message...".text.color(darkFontGrey).make(),
                    );
                    
                  }else{
                    return ListView(
                      children:
                        snapshot.data!.docs.mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];

                          return Align(
                            alignment: data['uid'] == currentUser!.uid ?
                             Alignment.centerRight : 
                            Alignment.centerLeft,
                            child: senderBubble(data));
                        }).toList(),
                    );
                     
                  }
                },
                ),
              ),
            ),

            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )),
                    hintText: "Type a message for a fournisseur..."
                  ),
                )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: const Icon(Icons.send, color: redColor)),
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}