import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress, color, textcolor, String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: redColor,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress, 
    child: title!.text.color(textcolor).fontFamily(bold).make());
}