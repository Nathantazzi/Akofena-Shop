import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = '';

  var featuredListe = [];

  var searchController = TextEditingController();

  getUsername()async {
    var n = await fierestore.collection(userCollection).where('id', isEqualTo: currentUser!.uid).get().then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }

}