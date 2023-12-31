import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isChek = false;
  var controller = Get.put(AuthController());

  //test controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogowidget(),
            10.heightBox,
             "Sign Up to $appname" .text.fontFamily(bold).white.size(22).make(),
             15.heightBox ,

             Obx(()=> Column(
                children: [
                  custTextField(hint: nameHint,title: name, controller: nameController,isPass: false),
                  custTextField(hint: emailHint,title: email, controller: emailController,isPass: false),
                  custTextField(hint: passwordHint,title: password, controller: passwordController,isPass: true),
                  custTextField(hint: passwordHint,title: retypePassword, controller: passwordRetypeController,isPass: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: forgetPass.text.make())),
                    Row(
                      children: [Checkbox(
                        checkColor: redColor,
                        value: isChek, 
                        onChanged: (newValue) {
                          setState(() {
                            isChek = newValue;
                          }); 
                        }
                      ,),
                      10.widthBox,
                      Expanded(
                        child: RichText(text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to ", 
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                            TextSpan(
                              text: termAndcond, 
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            )),
                            TextSpan(
                              text: "&", 
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                            TextSpan(
                              text: privatepolicy, 
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            ))
                          ],
                        )),
                      ),
                      ],
                    ),
                    5.heightBox,
                    //ourButton().box.width(context.screenWidth -50 ).make(),
                   controller.isloading.value?
                   const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):
                    ourButton(
                      color: isChek == true? redColor : lightGrey,
                      title: signup,
                      textcolor: whiteColor,
                      onPress: ()async{
                        if(isChek !=false){
                          controller.isloading(true);
                          try{
                            await controller.signupMethod(
                              context: context, email: emailController.text, password: passwordController.text).then((value){
                                return controller.storeUserData(email: emailController.text,password: passwordController.text,name: nameController.text);
                              }).then((value){
                                 VxToast.show(context, msg: loggedin); 
                                Get.offAll(()=>const Home());
                              });
                          }catch(e){
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isloading(true);
                          } 
                        }
                      },
                      )
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyhave.text.color(fontGrey).make(),
                        login.text.color(redColor).make().onTap(() {
                          Get.back();
                        })
                      ],
                    ),
                ],
               ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -  70).shadowSm.make(),
             )
          ],
        ),
      ),
    ));
  }
}