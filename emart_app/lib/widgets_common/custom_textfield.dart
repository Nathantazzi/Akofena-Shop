import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget custTextField({String? title, String? hint, controller, isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
    TextFormField(
      obscureText: isPass,
      controller: controller,
      decoration:  InputDecoration(
        hintStyle: const TextStyle(
          fontFamily: semibold,
          color: textfieldGrey,
        ),
        hintText: hint,
        isDense: true,
        fillColor: lightGrey,
        filled: true,
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: redColor))
      ),
    ),
    5.heightBox
    ],
  );
}