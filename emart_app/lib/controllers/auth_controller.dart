import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  
  //pour le formulaire de conexion

  Future<UserCredential?> loginMethod({email,password,context}) async{
    UserCredential? userCredential;

    try{
       userCredential= await auth.signInWithEmailAndPassword(email: email, password: password);

    }on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

    //pour le formulaire d'inscription

    Future<UserCredential?> signupMethod({email,password,context}) async{
    UserCredential? userCredential;

    try{
       userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);

    }on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method

storeUserData({name,password,email}) async{
    DocumentReference store = fierestore.collection(userCollection).doc(currentUser!.uid);
    store.set({'name': name, 'password':password, 'email': email, 'imageUrl': ''});
  }

  //signout

  signoutMethod(context) async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }  

}