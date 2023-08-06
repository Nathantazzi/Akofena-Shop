import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/model/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

      var quantity = 0.obs;
      var colorIndex = 0.obs;
      var totalPrice = 0.obs;

      var subcat = [];

       var isFav = false.obs;



  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();


  if (s.isNotEmpty) {
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  } else {
    // Gérer le cas où la liste est vide ici
    print("Aucune sous-catégorie trouvée pour le titre : $title");
  }
  }

    changeColorIndex(index){
      colorIndex = index;
    }

    increaseQuantity(totalQuantity){
      if(quantity.value<totalQuantity){
      quantity.value++;
      }
    }

    decreaseQuantity(){
      if (quantity.value > 0) {
      quantity.value--;
      }
    }

    calculateTotalPrice(price){
      totalPrice.value = price * quantity.value;
    }

    addToCart({title, img, sellername, color, qty, tprice, context,vendorID}) async {

/*        print({{ 'title': title,
        'img': img,
        'sellername': sellername,
        'color': color,
        'qty': qty,
        'vendor_id':vendorID,
        'tprice':tprice,
        'added_by': currentUser!.uid}});  */


      await fierestore.collection(cardCollection).doc().set({
        'title': title,
        'img': img,
        'sellername': sellername,
        'color': color,
        'qty': qty,
        //'vendor_id':vendorID,
        'tprice':tprice,
        'added_by': currentUser!.uid
      }).catchError((error){
        print(error);
        VxToast.show(context, msg: error.toString());
      });
    }

    resetValues(){
      totalPrice.value = 0;
      quantity.value = 0;
      colorIndex.value = 0;
    }

    addTowishlist(docId,context) async{
      await fierestore.collection(productsCollection).doc(docId).set({
        'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
      },SetOptions(merge: true)
      );
      isFav(true);
      VxToast.show(context, msg: "Added to wishlist");
    }

    removeFromwishlist(docId,context) async{
      await fierestore.collection(productsCollection).doc(docId).set({
        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
      },SetOptions(merge: true)
      );
      isFav(false);
      VxToast.show(context, msg: "Remove from wishlist");
    }

    checkifFav(data) async {
      if (data['p_wishlist'].contains(currentUser!.uid)) {
        isFav(true);
      } else {
        isFav(false);
      }
    }

}