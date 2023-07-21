import 'package:emart_app/consts/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}