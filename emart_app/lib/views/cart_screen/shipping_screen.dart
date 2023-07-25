import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar( 
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if (controller.addressController.text.length > 10) {
              Get.to(()=> const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");  
            }
          },
          color: redColor,
          textcolor: whiteColor,
          title: "Continue",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            custTextField(hint: "Address", isPass: false, title: "Address",controller: controller.addressController),
            custTextField(hint: "City", isPass: false, title: "City",controller: controller.cityController),
            custTextField(hint: "State", isPass: false, title: "State",controller: controller.stateController),
            custTextField(hint: "Postal Code", isPass: false, title: "Postal Code",controller: controller.postalcodeController),
            custTextField(hint: "Phone", isPass: false, title: "Phone",controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}