import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/items_ennum.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';
import '../../widgets_common/loading_indicator.dart';


class CategoryEnnum extends StatelessWidget {
  final String? title;
  const CategoryEnnum({super.key, required this.title});

  @override
  Widget build(BuildContext context) {


    var controller = Get.find<ProductController>();


    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if (snapshot.data!.docs.isEmpty){
            return Center(
              
              child: "No products Foud!".text.color(darkFontGrey).make(),
              
            );
          }else {

            var data = snapshot.data!.docs;

            return Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.subcat.length, 
                    (index) => "${controller.subcat[index]}"
                    .text
                    .size(12)
                    .color(darkFontGrey)
                    .makeCentered()
                    .box
                    .rounded
                    .white
                    .size(150, 60)
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .make()),
                ),
              ),
              30.heightBox,

              //Items Containers

              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8), 
                itemBuilder: (contex,index){
                    return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                  Image.network(
                                    data[index]['p_imgs'][0], 
                                    height: 150,
                                    width: 200, 
                                    fit: BoxFit.cover,
                                  ),
                                  "${data[index]['p_name']}"
                                  .text.
                                  fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                                 ],
                            ) .box.white.margin(
                              const EdgeInsets
                              .symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding( const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                                controller.checkifFav(data[index]);
                                Get.to(()=> ItemsEnnums(title: "${data[index]['p_name']}",data: data[index],
                                ),
                                );
                              })
                              ;
                }))

            ],
          ),
        );
      }
    },
   ),
 ));
  }
}