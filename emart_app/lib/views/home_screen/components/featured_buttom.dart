import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category_screen/category_ennum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredButtom({String? title, icon}){
  return Row(
children: [
  Image.asset(icon, width: 60, fit: BoxFit.fill,),
  10.widthBox,
  title!.text.fontFamily(semibold).color(darkFontGrey).make(),
],
  ).box
  .width(200)
  .margin(const EdgeInsets
  .symmetric(horizontal: 4))
  .white.padding(const EdgeInsets
  .all(5))
  .roundedSM
  .outerShadowSm
  .make()
  .onTap(() {
    Get.to(()=> CategoryEnnum(title: title,));
  })
  ;
}