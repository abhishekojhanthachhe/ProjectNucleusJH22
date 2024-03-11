import 'package:arche/constants/font_constants.dart';
import 'package:arche/getxcontrollers/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authcontroller){
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: GestureDetector(
            onTap: ()async{

//              authcontroller.emailsignup(email: "testemail@emal.com",password: "newone");
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/leaf.svg",
                    //    width: 28,
                    width: screenwidth*0.0654,
                  ),
                  Container(
                    //             margin: EdgeInsets.only(left: ),
                    child: Text(
                      "Arch",
                      style: TextStyle(
                        fontFamily: sfproroundedmedium,
                        color: Colors.black,
                        //       fontSize: 28
                        fontSize: screenwidth*0.0654, ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body:  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    //        top: 12
                      top: screenwidth*0.0280
                  ),
                  child: Image.asset("assets/2953998.jpg",
                    width: screenwidth*0.55,),
                ),
                GestureDetector(
                  onTap: (){
                    print(screenwidth.toStringAsFixed(1));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      //        top: 7.5
                        top: screenwidth*0.0175
                    ),
                    width: screenwidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an account?\nLogin with email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: sfproroundedsemibold,
                            color: Color(0xff006EE9),
                            //        fontSize: 22
                            fontSize: screenwidth*0.0514  ),),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
//                      top: 18
                      top: screenwidth*0.0420
                  ),
                  width: screenwidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Join with your Google Calendar email and easily import\n"
                            "all your events instantly.",
                          textAlign:TextAlign.center,
                          style: TextStyle(
                              fontFamily: sfproroundedmedium,
                              //   fontSize: 13.5,
                              fontSize: screenwidth*0.0315,
                              color: Colors.black
                          ),),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    //              top:  24
                      top: screenwidth*0.056
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenwidth*0.881,
                        //   height: 39,
                        height: screenwidth*0.0911,
                        padding: EdgeInsets.symmetric(horizontal: 10.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffF0F0F0),
                              width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
                                offset: Offset(0,0),blurRadius: 10)]
                        ),
                        child: TextFormField(
                          style: TextStyle(
                              fontFamily: sfproroundedregular,
                              //   fontSize: 14.5,
                              fontSize: screenwidth*0.0338,
                              color: Colors.black
                          ),
                          controller: authcontroller.loginemailcontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter email address",
                            hintStyle: TextStyle(
                                fontFamily: sfproroundedregular,
                                //    fontSize: 14.5,
                                fontSize: screenwidth*0.0338,
                                color: Color(0xff606060)
                            ),

                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          //        top: 15
                            top: screenwidth*0.0350
                        ),
                        width: screenwidth*0.881,
                        //   height: 39,
                        height: screenwidth*0.0911,
                        padding: EdgeInsets.symmetric(horizontal: 10.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffF0F0F0),
                              width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
                                offset: Offset(0,0),blurRadius: 10)]
                        ),
                        child: TextFormField(
                          style: TextStyle(
                              fontFamily: sfproroundedregular,
                              //   fontSize: 14.5,
                              fontSize: screenwidth*0.0338,
                              color: Colors.black
                          ),
                          controller: authcontroller.loginpasswordcontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: sfproroundedregular,
                                //    fontSize: 14.5,
                                fontSize: screenwidth*0.0338,
                                color: Color(0xff606060)
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    authcontroller.signIn(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      //         top: 38
                        top: screenwidth*0.0887   ),
                    width: screenwidth*0.574,
                    //  height: 32.5,
                    height: screenwidth*0.0759,
                    decoration: BoxDecoration(
                      color: Color(0xff006EFF),
                      borderRadius: BorderRadius.all(Radius.circular(7)),

                    ),
                    child: Center(
                      child: Text("Sign In",style: TextStyle(
                        fontFamily: sfproroundedregular,
                        color: Colors.white,
                        //       fontSize: 14.5
                        fontSize: screenwidth*0.0338,
                      ),),
                    ),
                  ),
                ),

//                authcontroller.sociallogincolumn(context),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, '/SignUp', (route) => false);
                  },
                  child: Container(
                    width: screenwidth,
                    margin: EdgeInsets.only(
                      //       top: 19
                        top: screenwidth*0.0443
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontFamily: sfpromedium,
                                  color: Colors.black,
                                  //                fontSize: 13.5
                                  fontSize: screenwidth*0.0315

                              ),
                              children: [
                                TextSpan(text: "Don’t Have an account? "),
                                TextSpan(text: "Sign Up",style: TextStyle(
                                    fontFamily: sfpromedium,
                                    color: Color(0xff006EFF),
                                    //         fontSize: 13.5
                                    fontSize: screenwidth*0.0315
                                ),)

                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );});

  }
}
