import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Whishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty) {
            return 
            "No Whishlist yet!".text.color(darkFontGrey).makeCentered();
            }else{
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                       itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: Image.network('${data[index]['p_imgs'][0]}',
                          width: 120,
                          fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                          subtitle: "${data[index]['p_price']}" 
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async{
                              await fierestore
                                    .collection(productsCollection)
                                    .doc(data[index].id)
                                    .set({
                                      'p_wishlist': FieldValue
                                      .arrayRemove([currentUser!.uid])
                                    },SetOptions(merge: true));
                            }),
                        );
                       },
                    ),
                  ),
                ],
              );
            }
        },
      ),
    );
  }
}

