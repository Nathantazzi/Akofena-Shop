import 'package:emart_app/views/category_screen/items_ennum.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';


class CategoryEnnum extends StatelessWidget {
  final String? title;
  const CategoryEnnum({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6, (index) => "Baby Clothing"
                    .text.fontFamily(semibold)
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
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8), 
                itemBuilder: (contex,index){
                    return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                  Image.asset(
                                    imgP5, 
                                    height: 150,
                                    width: 200, 
                                    fit: BoxFit.cover,
                                  ),
                                  "Laptop 4GB/500GB"
                                  .text.
                                  fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                                  10.heightBox,
                                  "150000xaf"
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
                                Get.to(()=> const ItemsEnnums(title: "Dummy items"));
                              })
                              ;
                }))

            ],
          ),
        ),
      )
    );
  }
}