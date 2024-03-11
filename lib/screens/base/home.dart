import 'package:arche/constants/font_constants.dart';
import 'package:arche/getxcontrollers/authcontroller.dart';
import 'package:arche/screens/chat/individual_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<AuthController>(
        initState: (v){
       //   authController.getData();
        },
          init: AuthController(),
          builder: (authcontroller){
        return
      Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [

        ],
        centerTitle: true,
        title: GestureDetector(
          onTap: (){
       //     authcontroller.assignrandomuser(context);
          },
          child: Container(
            child: Text("Nukleus",
              textAlign: TextAlign.center,
              style: TextStyle(
              fontFamily: gilroybold,
              color: Colors.black,
              fontSize: 18.5
            ),),
          ),
        ),
      ),
        body:SingleChildScrollView(
          child: Container(
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authcontroller.findmatchmodule(context),
                Container(
                  width: screenwidth,
                  margin: EdgeInsets.only(left: 18,right: 18,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Your Chats",style: TextStyle(
                          fontFamily: gilroybold,
                          color: Colors.black,
                          fontSize: 18
                        ),),
                      )
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Users").
                    doc(FirebaseAuth.instance.currentUser!.email).collection("chatdocs").snapshots(),
                    builder: (context,snapshot){
                  return !snapshot.hasData?SizedBox(height: 0,):ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            IndividualChat(email:doc["useremail"] ,chatid:doc["chatid"] ,)));
                          },
                          child: Container(
                      width: screenwidth,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(authcontroller.avatarimages[doc["useravatarid"]],
                                  width: 37,
                                  height: 37,),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max
                                  ,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 18,top: 10),
                                      child: Text(doc["username"],style: TextStyle(
                                        fontFamily: gilroymediumd,
                                        color: Colors.black,
                                        fontSize: 14.5
                                      ),),
                                    )
                                  ],

                                )
                              ],
                            ),
                    ),
                        );
                  });
                }),

          //      authcontroller.findsomeone(context),
              ],
            ),
          ),
        ),
    );});
  }
}
