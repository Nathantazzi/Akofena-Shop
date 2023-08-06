import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/order_screen/order_detail.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty) {
            return 
            "No Orders yet!".text.color(darkFontGrey).makeCentered();
            }else{

              var data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length, 
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                trailing: IconButton(
                  onPressed: (){
                    //Get.to(()=>OrderDetails());
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: darkFontGrey,
                  ),
                ),
              );
          });
            }
        },
      ),
    );
  }
}