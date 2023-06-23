import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCards({width, String? count, String? title}){
  return 
   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          "00".text.fontFamily(bold).color(darkFontGrey).size(16).make(),
          5.heightBox,
          "In your cart".text.color(darkFontGrey).make()
      ],
    ).box.white.rounded.width(width).height(85).padding(const EdgeInsets.all(4)).make();
}