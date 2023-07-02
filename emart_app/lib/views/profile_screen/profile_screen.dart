import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/profile_screen/Components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profil.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
              }else{
                var data = snapshot.data!.docs[0];
                

               return SafeArea(
          child: Column(
            children: [

              //Edit profil buttom

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Align(alignment: Alignment.topRight,child: Icon(Icons.edit, color: whiteColor,)).onTap(() { 
                  
                  controller.nameController.text = data ['name'];
                  Get.to(()=>  EditProfilScreen(data: data));
                }),
              ),

              //users details section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [

                    data['imageUrl'] == ''?

                    Image.asset(
                      imgProfile2, 
                      width: 100,
                      fit: BoxFit.cover,)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                      :
                      
                      Image.network(
                      data['imageUrl'], 
                      width: 100,
                      fit: BoxFit.cover,)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make(),

                      10.heightBox,
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}".text.fontFamily(semibold).white.make(),
                          "${data['email']}".text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: whiteColor,
                          )
                        ),
                        onPressed: ()async {
                          await Get.put(AuthController()).signoutMethod(context);
                          Get.offAll(()=>  const LoginScreen());
                        }, 
                        child: logout.text.fontFamily(semibold).make())
                      ],
                ),
              ),

              20.heightBox,
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsCards(count: "00",title: data ['cart_count'], width: context.screenWidth / 3.5),
                detailsCards(count: "25",title: data ['wishlist_count'], width: context.screenWidth / 3.5),
                detailsCards(count: "30",title: data ['order_count'], width: context.screenWidth / 3.5),
              ],
             ),

             ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(
                  color: lightGrey,
                );
              },
              itemCount: profilebuttomList.length,itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: Image.asset(profilebuttomIcon[index],
                width: 22,
                
                ),
                  title: profilebuttomList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
              );
             },
            ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
            ],
          ));

              }
          },
          ),
      ),
    );
  }
}