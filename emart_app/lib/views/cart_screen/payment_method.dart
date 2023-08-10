import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets_common/our_button.dart';


class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx(() =>
    Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: loadingIndicator(), 
          ): ourButton(
            onPress: () async{
               await controller.placeMyOrder(
                  orderspaymentMethod: payment[controller.paymentIndex.value],
                  totalAmount: controller.totalP.value);
                  await controller.clearCart(); 

                  // ignore: use_build_context_synchronously
                  VxToast.show(context, msg: "Order placed successfully");

                  Get.offAll(const Home());
            },
            color: redColor,
            textcolor: whiteColor,
            title: "Place My Order",
          ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
    
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(() => 
          Column(
              children: List.generate(paymentList.length, (index){
                return GestureDetector(
                  onTap: (){
                   controller.changePaymentIndex(index); 
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: controller.paymentIndex.value == index ? whiteColor : Colors.transparent,
                        width: 3.5,
                      )),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentList[index],
                        width: 438, 
                        height: 235, 
                        colorBlendMode: controller. paymentIndex.value == index ? BlendMode.darken 
                        : BlendMode.color,
                        color: controller. paymentIndex.value == index ? Colors.black.withOpacity(0.4) 
                        : Colors.transparent,
                        fit: BoxFit.fill,),
                      controller.paymentIndex.value == index ? Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          value: true, 
                          onChanged: (value ){},
                          ),
                      ): Container(),
                      Positioned(
                        bottom: 50,
                        right: 10,
                        child: payment[index].text.transparent.fontFamily(bold).size(16).make(),
                      ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}