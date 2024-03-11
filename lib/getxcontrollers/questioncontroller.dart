import 'package:arche/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController{
  int questionsindex=0;
  int selectedresponseindex=8;

  setquestionsindex(int index){

    questionsindex=index;
    update();
  }
  setselectedresponse(int index){
    selectedresponseindex=index;
    update();
  }
  Widget nextbutton(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: screenwidth,
        margin: EdgeInsets.only(
          //       top: 56
            top: screenwidth*0.1408 ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if(selectedresponseindex!=8){
                      if(questionsindex==4){
                        Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
                      }else{
                        setquestionsindex(questionsindex+1);
                      }
                      selectedresponseindex=8;
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: screenwidth*0.574,
                    //   height: 35,
                    height: screenwidth*0.0817,
                    decoration: BoxDecoration(
                      color: selectedresponseindex==8?
                      Color(0xff9FC4F5):
                      Color(0xff006EFF),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Center(
                      child: Container(
                        child: Text("Next",style: TextStyle(
                            fontFamily: sfproroundedregular,
                            color: Colors.white,
//                      fontSize: 14.5
                            fontSize:screenwidth*0.0338
                        ),),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                top: 35,left: 27
                  top: screenwidth*0.0817,left: screenwidth*0.0630
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Skip",style: TextStyle(
                      fontFamily: sfproroundedregular,
//                  fontSize: 15.5,
                      fontSize: screenwidth*0.0362,
                      color: Color(0xff6A6A6A)
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}