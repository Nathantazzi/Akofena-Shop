import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/images.dart';

class EditProfilScreen extends StatelessWidget {
  final dynamic data;
  const EditProfilScreen({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    
      var controller = Get.find<ProfileController>();


    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' &&  controller.profileImgPath.isEmpty
              ? Image.asset(imgProfile2, width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
              : data['imageUrl'] != '' && controller.profileImgPath.isEmpty?
              Image.network(data['imageUrl'],
              width: 100,
              fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make():
              Image.file(File(controller.profileImgPath.value),
              width: 100,
             fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.heightBox,
                      ourButton(
                        color: whiteColor,
                        onPress: (){
                          controller.changeImage(context);
                      },
                      textcolor: redColor,
                      title: "Change"),
                      const Divider(),
                      20.heightBox,
                      custTextField(
                        controller: controller.nameController,
                        hint: nameHint,title: name,isPass: false),
                        10.heightBox,
                      custTextField(
                        controller: controller.oldpassController,
                        hint: passwordHint,title: oldpass,isPass: true),
                        10.heightBox,
                        custTextField(
                        controller: controller.newpassController,
                        hint: passwordHint,title: newdpass,isPass: true),
                      20.heightBox,
                     controller.isloading.value ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                     ): SizedBox(
                        width: context.screenWidth - 80,
                        child: ourButton(color: redColor,onPress: ()async{
                          controller.isloading(true);

                        if(controller.profileImgPath.value.isNotEmpty){
                         await controller.uploadProfileImage();
                          
                        }else{
                          controller.profilLink = data ['imageUrl'];
                        }

                        if(data['password'] == controller.oldpassController.text){

                          controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text,
                          );


                          await controller.updateProfile(
                          imgUrl: controller.profilLink,
                          name: controller.nameController.text,
                          password: controller.newpassController.text,
                         );
                         VxToast.show(context, msg: "Updated");

                        }else{
                          VxToast.show(context, msg: "Wrong old password");
                          controller.isloading(false);                        
                          }
                        },textcolor: whiteColor,title: "Save")),
        
            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50,left: 14,right: 14))
          .rounded
          .make(),
        ),
      ));
  }
}