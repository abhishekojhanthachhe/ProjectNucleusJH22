import 'package:arche/constants/font_constants.dart';
import 'package:arche/getxcontrollers/authcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class IndividualChat extends StatelessWidget {
  IndividualChat(
      {this.email,this.chatid
        });
   final String? email;
  final String? chatid;
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<AuthController>(
        initState: (v){
          authController.getparticularusersdetails(email.toString());
          authController.getconundrum(email.toString(),chatid.toString());
        },
        init:AuthController(),
        builder: (authcontroller){
        return
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: screenwidth,
        height: 54,
        decoration: BoxDecoration(
            color: Color(0xffFAFAFA)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 36,
              width: screenwidth*0.816,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: Color(0xffE3E3E3),width: 1),

              ),
              child: Center(
                child: TextField(
                  controller: authcontroller.textmessagecontroller,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: sfproroundedregular,
                      color: Colors.black87,
                      fontSize: 13.5
                  ),
                  decoration: InputDecoration(
                      hintText:
                          authcontroller.personalresponse!="" &&
                              authcontroller.otherresponse!=""?
                          "Type a message":
                          authcontroller.personalresponse=="" &&
                              authcontroller.otherresponse!=""?
                          "You have not shared your view on it yet.":
                          authcontroller.personalresponse!="" &&
                              authcontroller.otherresponse==""?
                          "Your cannot type again. Your chatmate has not replied yet":
                      'Share your views',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff747474),
                          fontFamily: sfproroundedregular,
                          fontSize: 13.5
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(authcontroller.textmessagecontroller.text!=""){
                  authcontroller.sendamessage(chatid.toString());
                }

//                taskcontroller.addatask(context);
              },
              child: Container(
                height: 36,width: 36,
                decoration: BoxDecoration(
                  color: Color(0xff006EFF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    child: Icon(CupertinoIcons.up_arrow,
                      color: Colors.white,
                      size: 20,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
       //     authcontroller.clearcurrentchatroomdata();
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back,
          color: Colors.grey[600],
          size: 24,),
        ),
        title: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(authcontroller.avatarimages[authcontroller.currentchatuseravatarid!.toInt()],
                  width: 40,height: 40,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 3.5,bottom: 5.5),
                child: Text(authcontroller.currentchatusername.toString(),style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.black,
                  fontFamily: sfproroundedregular
                ),),
              )
            ],
          ),
        ),
      ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(top: 22),
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                authcontroller.getcurrentconundrum(context),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(
                        chatid.toString()).orderBy("timesent").snapshots(),
                    builder: (context,snapshots){
                  return !snapshots.hasData?
                      SizedBox(height: 0,):
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot doc = snapshots.data!.docs[index];
                          return
                            doc["message"]==""?SizedBox(height: 0,):
                            Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                          width: screenwidth,
                          child: doc["sentby"]
                              == FirebaseAuth.instance.currentUser!.uid?
                          Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                            children: [
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 3.5),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xff006EFF),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(0)
                                  )
                                ),child: Center(
                                child: Text(doc["message"],style: TextStyle(
                                  fontFamily: sfproroundedregular,
                                  color: Colors.white,
                                  fontSize: 13
                                ),),
                              ),
                              )
                            ],
                    ):
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                             Container(
                                  margin: EdgeInsets.symmetric(vertical: 3.5),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(20)
                                      )
                                  ),child: Center(
                                  child: Text(doc["message"],style: TextStyle(
                                      fontFamily: sfproroundedregular,
                                      color: Colors.black,
                                      fontSize: 11.5
                                  ),),
                                ),
                                ),

                            ],
                          ),
                  );
                });})
              ],
            ),
          ),
        ),
    );});
  }
}
