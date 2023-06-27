import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container
    (color: const Color.fromARGB(255, 59, 160, 255),   
    child: "Cart is Empty!".text.fontFamily(semibold).color(darkFontGrey).make()
    );
  }
}