import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var totalP = 0.obs;

  //text controller pour lachat

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();


  var paymentIndex = 0.obs;

  late dynamic productSnapshot;

  var products=[];

  var placingOrder = false.obs;

  calculateCart(data) {
    totalP.value =0;
    for (var i = 0; i < data.length; i++){
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index){
    paymentIndex.value = index;
  }

  placeMyOrder({required orderspaymentMethod,required totalAmount}) async {

    placingOrder(true);

    await getProductDetails();
     await fierestore.collection(ordersCollection).doc().set({
      'order_code': "132645658978",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderspaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delevered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    }); 
    placingOrder(false);
  }
  
    getProductDetails(){
      products.clear(); 
      for (var i = 0; i < productSnapshot.length; i++) {
        products.add({
          'color': productSnapshot[i]['color'],
          'img': productSnapshot[i]['img'],
           'tprice': productSnapshot[i]['tprice'],
          'qty': productSnapshot[i]['qty'],
          'title': productSnapshot[i]['title']
        });
      }
    }


  clearCart(){
    for (var i = 0; i < productSnapshot.length; i++) {
      fierestore.collection(cardCollection).doc(productSnapshot[i].id).delete();
    }
  }

}