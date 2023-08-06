import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';


class FirestoreServices {
//get users data
  static getUser(uid) {
    return fierestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }
  
 
  static getProducts(category) {
  return fierestore
      .collection(productsCollection)
      .where('p_category', isEqualTo: category)
      .snapshots();
}

static getCart(uid) {
    return fierestore.collection(cardCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDocument(docId) {
    return fierestore.collection(cardCollection).doc(docId).delete();
  }

  static getChatMessages(docId){
    return fierestore
    .collection(chatsCollection)
    .doc(docId)
    .collection(messagesCollection)
    .orderBy('created_on', descending: false)
    .snapshots();
  }

   static getAllOrders() {
    return fierestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
  }

  static getWishlist(){
    return fierestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMessages(){
    return fierestore
    .collection(chatsCollection)
    .where('fromId', isEqualTo: currentUser!.uid)
    .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      fierestore.collection(cardCollection).where('added_by', isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      fierestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      fierestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allproducts(){
    return fierestore.collection(productsCollection).snapshots();
  }

  static getFeatureProducts(){
    return fierestore.collection(productsCollection).where('is_featured',isEqualTo: true).get();
  }

    static seachProducts(title){
    return fierestore.collection(productsCollection).get();
  }


}