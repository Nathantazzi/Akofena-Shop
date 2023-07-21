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
    return fierestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDocument(docId) {
    return fierestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId){
    return fierestore
    .collection(chatsCollection)
    .doc(docId)
    .collection(messagesCollection)
    .orderBy('created_on', descending: false)
    .snapshots();
  }
}