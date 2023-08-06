import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/items_ennum.dart';
import 'package:emart_app/views/home_screen/components/featured_buttom.dart';
import 'package:emart_app/views/home_screen/search_screen.dart';
import 'package:emart_app/widgets_common/home_buttoms.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
  var controller = Get.find<HomeController>();
    
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenHeight,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration:  InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(()=>  SearchScreen(title: controller.searchController.text,));
                  }
                  
                }),
                filled: true,
                fillColor: whiteColor,
                hintText: search,
                hintStyle: const TextStyle(color: textfieldGrey),
              ),
            ),
          ),
    
        10.heightBox,
    
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                  //swipers brands 
              VxSwiper.builder(
                aspectRatio: 16 / 9,
                autoPlay: true,
                height: 150,
                enlargeCenterPage: true,
                itemCount: slidersList.length, 
                itemBuilder: (context,index){
                  return Image.asset(
                    slidersList[index],
                    fit: BoxFit.fitWidth,
                    ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();    
              }),
          
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    2, 
                    (index) => homeButtons(
                    height: context.screenHeight * 0.12,
                    width: context.screenWidth / 2.7,
                    icon: index == 0 ? icTodaysDeal : icFlashDeal,
                    title: index == 0 ? todayDeal : flashsale,
                    )),
                ),
                //second swipers 
    
                5.heightBox,
          //swipers brands
                VxSwiper.builder(
                aspectRatio: 20 / 12,
                autoPlay: true,
                height: 150,
                enlargeCenterPage: true,
                itemCount: secondSlidersList.length, 
                itemBuilder: (context,index){
                  return Image.asset(
                    secondSlidersList[index],
                    fit: BoxFit.fitWidth,
                    ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();    
              }),
          
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3, 
                  (index) => homeButtons(
                    height: context.screenHeight * 0.12,
                    width: context.screenWidth / 3.5,
                  icon: index == 0 
                    ? icCategories 
                    : index == 1 
                    ? icBrands : icTopSeller,
                  title: index == 0 
                    ? categories 
                    : index == 1 
                    ? brand : topSellers,
                )),
              ),
          
              //features categories
              20.heightBox,
              Align(alignment: Alignment.centerLeft,child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
              20.heightBox,
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
               child: Row(
                    children: List.generate(
                      3, 
                      (index) => Column(
                      children: [
                        featuredButtom(icon: featuredImages1[index], title: featuredTitle1[index]),
                        10.heightBox,
                        featuredButtom(icon: featuredImages2[index], title: featuredTitle2[index]),
                      ],
                    )).toList(),
                  ),
                 ),
    
                 //features product
    
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white.fontFamily(bold).size(20).make(),
                        10.heightBox,

                        SingleChildScrollView(

                          scrollDirection: Axis.horizontal,
                          child: 
                          FutureBuilder(
                            future: FirestoreServices.getFeatureProducts(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else if(snapshot.data!.docs.isEmpty){
                                return "No Featured Products".text.white.makeCentered();
                              }else {

                                var featuredData = snapshot.data!.docs;

                                return Row(
                                children: List.generate(
                                  featuredData.length, 
                                  (index) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                      Image.network(
                                        featuredData[index]['p_imgs'][0], 
                                        width: 150,
                                        height: 150, 
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "!{featuredData[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                      10.heightBox,
                                      "!{featuredData[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                      10.heightBox,
                                     ],
                                ) .box
                                .white
                                .margin(const EdgeInsets
                                .symmetric(horizontal: 4))
                                .roundedSM.padding( const EdgeInsets
                                .all(8))
                                .make(),),
                              );
                              }
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
    
                    //third swipper
                   20.heightBox,
    
                   VxSwiper.builder(
                aspectRatio: 16 / 9,
                autoPlay: true,
                height: 130,
                enlargeCenterPage: true,
                itemCount: secondSlidersList.length, 
                itemBuilder: (context,index){
                  return Image.asset(
                    secondSlidersList[index],
                    fit: BoxFit.fitWidth,
                    ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();    
              }),
    
                //all products
                20.heightBox,
                
                StreamBuilder(
                  stream: FirestoreServices.allproducts(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                      
                    } else {
                      var allproductsData = snapshot.data!.docs;
                      return GridView.builder( 
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allproductsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 300), 
                    itemBuilder: (context, index) {
                  return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                  Image.network(
                                    allproductsData[index]['p_imgs'][0], 
                                    height: 200,
                                    width: 200, 
                                    fit: BoxFit.cover,
                                  ),
                                 const Spacer(),
                                  "${allproductsData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "${allproductsData[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                                  10.heightBox,
                                 ],
                            ) .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .padding( const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                                Get.to(()=> ItemsEnnums(
                                  title: "${allproductsData[index]['p_name']}",
                                  data: allproductsData[index],));
                              });
                });
                    }
                  }),

              ],
            ),
          ),
        ),
    
        ],
      )),
    );
  }
}





