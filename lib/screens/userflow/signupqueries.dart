import 'package:arche/constants/font_constants.dart';
import 'package:arche/getxcontrollers/questioncontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class SignUpQueries extends StatelessWidget {
   SignUpQueries({Key? key}) : super(key: key);
   List<String> question1=[
     "In social situations, I'm usually the one who makes the first move.",
     "I often push myself very hard when trying to achieve a goal.",
   "I rarely discuss my problems with other people.",
"I like people who have unconventional views.",
   "I wouldn’t spend my time reading a book of poetry"];
  List<String> illustration=["assets/20944874-min.jpg","assets/Wavy_Bus-32_Single-01-min.jpg",
    "assets/11098-min.jpg","assets/WhatsApp Image 2021-11-21 at 06.37.21.jpeg",
    "assets/2009.i305.010_cozy_home_set-17.jpg"];
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<QuestionController>(
          init: QuestionController(),
          builder: (signupquerycontroller){
return      Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: screenwidth,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
        //          top: 12
          top: screenwidth*0.029    ),
              child: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: GestureDetector(
                  onTap: (){
                    print(screenwidth.toString());
                  },
                  child: Container(

                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                       //     right: 8.5,
                            right: screenwidth*0.0206
                          ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:EdgeInsets.only(
//                                  left: 8,top: 1
                                  left: screenwidth*0.0194,top: screenwidth*0.00243
                              ),
                              child: Text("Hacking Socials.",style: TextStyle(
                                  fontFamily: sfproroundedsemibold,
                                  color: Color(0xff006EE9),
                                  fontSize: screenwidth*0.0474
                              ),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
//                  top: 26,bottom: 26
                  top: screenwidth*0.0632,bottom: screenwidth*0.0632
              ),
              width: screenwidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(illustration[signupquerycontroller.questionsindex],
                width: screenwidth*0.508,)
              ],),
            ),
            Container(
              padding: EdgeInsets.only(
//                  left:36, right: 36
                  left:screenwidth*0.08759, right: screenwidth*0.08759
              ),
              width: screenwidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(question1[signupquerycontroller.questionsindex],textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: sfproroundedmedium,
                      color: Colors.black,
                 //     fontSize: 21
                   fontSize: screenwidth*0.0510 ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenwidth*0.027),
                    child: Text("On a scale of 5 with 5 as the likeliest and 1 as the least. "
                        "How much do you agree with this?",textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: sfproroundedregular,
                          color: Colors.black,
                    //      fontSize: 15
                        fontSize: screenwidth*0.0364
                      ),),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
      //            top: 27
        top: screenwidth*0.06569      ),
              width: screenwidth*0.6132,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for(int i=0;i<5;i++)
                    GestureDetector(
                      onTap: (){
                        signupquerycontroller.setselectedresponse(i);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
              //        height: 32,width: 32,
                height: screenwidth*0.0778,width:  screenwidth*0.0778,
                        decoration: BoxDecoration(
                          color: signupquerycontroller.selectedresponseindex==i?
                          Color(0xff006EFF):Color(0xff9FC4F5),
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text((i+1).toString(),
                          style: TextStyle(
                            fontFamily: sfproroundedregular,
                            color: Colors.white,
              //            fontSize: 15
                              fontSize: screenwidth*0.0364
                          ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Container(
          //    height: 5.5,
            height: screenwidth*0.0133,
              margin: EdgeInsets.only(
//                  top: 68
                  top: screenwidth*0.1654
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int i=0;i<5;i++)
                  AnimatedContainer(
                    margin: EdgeInsets.only(
                //        left: 5.5
                  left:       screenwidth*0.0133,
                    ),
                    duration: Duration(milliseconds: 250),
             //       height: 5.5,
                    height: screenwidth*0.0133,
                    width: signupquerycontroller.questionsindex==i?
                   // 21.5:5.5,
                    screenwidth*0.0523:screenwidth*0.0133,
                    decoration: BoxDecoration(
                      color: Color(0xffB2B2B2),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  )
                ],
              ),
            ),
            signupquerycontroller.nextbutton(context),
          ],
        ),
      ),
    );});
  }
}
