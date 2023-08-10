import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget custTextField({String? title, String? hint, controller, isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /* title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox, */
    /* TextFormField(
      obscureText: isPass,
      controller: controller,
      decoration:  InputDecoration(
        hintStyle: const TextStyle(
          fontFamily: semibold,
          color: textfieldGrey,
        ),
        hintText: title,
        isDense: true,
        fillColor: lightGrey,
        filled: true,
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: whiteColor))
      ),
    ) */
    TextFormField(
  obscureText: isPass,
  controller: controller,
  decoration: InputDecoration(
    labelText: title,
    labelStyle: const TextStyle(
      fontFamily: 'semibold',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: redColor, // Couleur rouge pour le titre
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: 'Here....',
    isDense: true,
    filled: true,
    fillColor: Colors.grey[300],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color:redColor),
    ),
  ),
),
    50.heightBox
    ],
  );
}

