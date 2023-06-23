import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/list.dart';
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

             Column(
              children: [
                custTextField(hint: nameHint,title: name),
                custTextField(hint: emailHint,title: email),
                custTextField(hint: passwordHint,title: password),
                custTextField(hint: passwordHint,title: retypePassword),
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
                        ]
                      )),
                    ),
                    ],
                  ),
                  5.heightBox,
                  //ourButton().box.width(context.screenWidth -50 ).make(),
                  ourButton(color: isChek == true? redColor : lightGrey, title: signup,textcolor: whiteColor,onPress: (){})
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
                  10.heightBox,
                  RichText(text: const TextSpan(
                    children: [
                      TextSpan(
                        text: alreadyhave,
                        style: TextStyle(
                          fontFamily: bold, color: fontGrey
                        ),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(
                          fontFamily: bold, color: redColor
                        ),
                      )
                    ],
                  ),
                  ).onTap(() { 
                    Get.back();
                  }),
              ],
             ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -  70).shadowSm.make()
          ],
        ),
      ),
    ));
  }
}