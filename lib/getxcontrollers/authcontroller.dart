import 'dart:math';

import 'package:arche/constants/font_constants.dart';
import 'package:arche/screens/chat/individual_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  TextEditingController loginemailcontroller=TextEditingController();
  TextEditingController signupnamecontroller=TextEditingController();
  TextEditingController signupemailcontroller=TextEditingController();
  TextEditingController signuppasswordcontroller=TextEditingController();
  TextEditingController textmessagecontroller=TextEditingController();
  List<String> alluserslist = <String>[];
  List allusersarray=[];
  List currentchatlist=[];
  int currentconundrumindex=0;
  List conundrumslist=[
    "King and Queen- 4 people, King and Queen, Farmer and wife, Queen"
  "goes hunting and accidentally kills farmer instead of deer. Farmer's "
  "wife asks King for justice, King exclaims, You can kill me as an eye "
        "for an eye Dilemma is Do you feel this is justified?",

    "Child throws a stone across a fence, kills an old man, and is unaware "
        "of it. You are God. Does the child go to heaven or hell?",

    "Tom and Jerry - Clip - Who do you think \nwas right, Tom or Jerry?",

    "Jack and the Beanstalk - Is Jack justified in killing the monster "
        "to feed for his family? Do you feel one should cross any limits to achieve what one wants?"
  ];
  List conundrumsimages=[

  ];
  String? usertoconnectwith;
  String? currentchatroom;
  String? currentchatusername;
  String? personalresponse;
  String? otherresponse;
  int? currentchatuseravatarid=0;
  TextEditingController loginpasswordcontroller=TextEditingController();
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<String> avatarimages=["assets/bear.png","assets/cat.png","assets/chicken.png",
  "assets/dog-2.png","assets/dog-3.png","assets/ostrich.png","assets/panda.png",
  "assets/penguin.png","assets/polar-bear.png","assets/sloth.png"];

  createuserdocument()async{
    int randomindex=new Random().nextInt(9);
    await FirebaseFirestore.instance.collection("Users").
    doc(auth.currentUser!.email).set({
      "avatarid":randomindex,
      "name":signupnamecontroller.text
    });
    setcurrentuseravatar(randomindex);
  }
  assignaconundrum(String anotheruseremail,String chatid)async{
    int conundrumindex=new Random().nextInt(3);
    final currentuseremail=FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection("Conundrums").
    doc(chatid).set(
        {"conundrumindex":conundrumindex,
          });
  }
   getparticularusersdetails(String email)async{
    await FirebaseFirestore.instance.collection("Users").
    doc(email).get().then((value){
      // first add the data to the Offset object
      currentchatusername =  value.data()!['name'];
      currentchatuseravatarid=value.data()!['avatarid'];
        //then add the data to the List<Offset>, now we have a type Offset
      update();
    });
  }
  getconundrum(String otheruseremail,String chatid)async{
    final personalemail=FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection("Conundrums").
    doc(chatid).get().then((value){
      // first add the data to the Offset object
      currentconundrumindex =  value.data()!['conundrumindex'];
      //then add the data to the List<Offset>, now we have a type Offset
      update();
    });
  }
 Widget getcurrentconundrum(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return    Container(
      width: screenwidth,
      margin: EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/ZVENWG.gif",width: 240,),
          Container(
            margin: EdgeInsets.only(
              //        top: 7.5
                top: screenwidth*0.0182
            ),
            child: Text(conundrumslist[2],style: TextStyle(
                fontFamily: sfproroundedmedium,
                fontSize: 15.5,
                color: Colors.grey[700]
            ),),
          )
        ],
      ),
    );
 }

  getallchatdocs()async{
    final currentuseremail=FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection("Users").
    doc(currentuseremail).get().then((value){
      // first add the data to the Offset object

    });
  }
  assignrandomuser(BuildContext context) async{
    int randomindex;
    await FirebaseFirestore.instance.collection("AllUsers").
    doc('mtKqh0SpveVPGvXXeMHi').get().then((value){
        // first add the data to the Offset object
        List.from(value.data()!['alluseremails']).forEach((element){
          String data =  element;
          //then add the data to the List<Offset>, now we have a type Offset
          alluserslist.add(data);
        });
    });
    final currentuseremail=FirebaseAuth.instance.currentUser!.email;
    randomindex=new Random().nextInt(alluserslist.length-1);
    usertoconnectwith=alluserslist[randomindex];
  //  if(usertoconnectwith==currentuseremail){
    //  randomindex=new Random().nextInt(alluserslist.length-1);
      //usertoconnectwith=alluserslist[randomindex];
   // }
    createchatroom(usertoconnectwith.toString());
    assignaconundrum(usertoconnectwith.toString(),currentuseremail.toString()+"_"+
        usertoconnectwith.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    IndividualChat(email: usertoconnectwith,chatid: currentuseremail.toString()+"_"+
        usertoconnectwith.toString(),)));
  //  for(int i=0;i<alluserslist.length;i++){print(alluserslist[i]);}
  }
  setcurrentuseravatar(int index)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("useravatarindex", index);
  }
  getintfromsharedprefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final avatarindex=prefs.getInt("useravatarindex");
    return avatarindex;
  }
  getcurrentuseravatar()async{
    int index =  await getintfromsharedprefs();
    return index;
  }

  createchatroom(String anotheruseremail)async{
    final currentuseremail=FirebaseAuth.instance!.currentUser!.email;
    final currentusername=FirebaseAuth.instance!.currentUser!.displayName;
    await FirebaseFirestore.instance.collection(currentuseremail.toString()+"_"+anotheruseremail).add(
        {"createddate":DateFormat.yMMMd().format(DateTime.now()),
        "message":"",
          "sentby":"",
          "seen":""
        });
    getparticularusersdetails(anotheruseremail);
    // FirebaseFirestore.instance.collection("Users").doc(currentuseremail.toString()).
    await FirebaseFirestore.instance.collection("Users").doc(currentuseremail.toString()).
    collection("chatdocs").doc(currentuseremail.toString()+"_"+anotheruseremail).set(
        {"chatid":currentuseremail.toString()+"_"+anotheruseremail,
        "username":currentchatusername,
          "useravatarid":currentchatuseravatarid,
          "useremail":anotheruseremail,

        });
    int index =  await getintfromsharedprefs();
    await FirebaseFirestore.instance.collection("Users").doc(anotheruseremail.toString()).
    collection("chatdocs").doc(currentuseremail.toString()+"_"+anotheruseremail).set(
        {"chatid":currentuseremail.toString()+"_"+anotheruseremail,
          "username":currentusername,
          "useravatarid":index,
          "useremail":currentuseremail,
        });

 //   await FirebaseFirestore.instance.collection("Users").doc(
   //     currentuseremail.toString()).update({"chatdocs":
  //  FieldValue.arrayUnion([currentuseremail.toString()+"_"+anotheruseremail])});
 //   await FirebaseFirestore.instance.collection("Users").doc(
   //     anotheruseremail.toString()).update({"chatdocs":
  //  FieldValue.arrayUnion([currentuseremail.toString()+"_"+anotheruseremail])});
    currentchatroom=currentuseremail.toString()+"_"+anotheruseremail;
    update();
  }
  executethatstuff(){
    var currentuseravatarre= getcurrentuseravatar();
    int currentuseravatarr=currentuseravatarre;
    print(currentuseravatarre);
  }

  sendamessage(String currentchatroom)async{
    final currentuid= FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection(currentchatroom).
        add({
      "message":textmessagecontroller.text,
      "sentby":currentuid,
      "timesent": DateFormat.yMd().add_jm().format(DateTime.now()),
      "seen":0
    });
    textmessagecontroller.text="";
  }


 Widget findsomeone(BuildContext context){
    return ListView.builder(
      scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: allusersarray.length,
        itemBuilder: (context,index){
          return Container(
            child: Text(allusersarray[index],style: TextStyle(
              fontSize: 21,
              color: Colors.black
            ),),
          );
    });
  }
  navigatetosignupqueries(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(context, '/SignUpQueries', (route) => false);
  }
  getcurrentuser()async{
    String email=  auth.currentUser!.email.toString();
    print(email);
  }
  emailsignup(BuildContext context)async{
    auth.createUserWithEmailAndPassword(email: signupemailcontroller.text,
          password:signuppasswordcontroller.text).then((value) {
            auth.currentUser!.updateDisplayName(signupnamecontroller.text);
      registeruserinlist();
      signupemailcontroller.text="";
        signuppasswordcontroller.text="";
        createuserdocument();
        navigatetosignupqueries(context);
      });
  }
  registeruserinlist()async{
    await FirebaseFirestore.instance.collection("AllUsers").doc(
        "mtKqh0SpveVPGvXXeMHi").update({"alluseremails":
    FieldValue.arrayUnion([signupemailcontroller.text])});
  }


  signOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut().then((value){
      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
    });
  }
  //SIGN IN METHOD
  Future signIn(BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: loginemailcontroller.text,
          password: loginpasswordcontroller.text);
      Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
      return null;
    } on FirebaseAuthException catch (e) {

      return e.message;
    }
  }

  //SIGN OUT METHOD

  googlesignin()async{
    final googleSignIn=GoogleSignIn();
    final googleUser=await googleSignIn.signIn();
    if(googleUser!=null){
      final googleAuth=await googleUser.authentication;
      print(googleAuth.accessToken);
      print(googleAuth.idToken);
   //   final credential=GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//      await FirebaseAuth.instance.signInWithCredential(credential);

    }else{
      print("Error signing in");
    }

  }
  Widget sociallogincolumn(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()async{
              googlesignin();
            },
            child: Container(
              margin: EdgeInsets.only(
//                top: 11
                  top: screenwidth*0.0257
              ),
              padding: EdgeInsets.symmetric(
//                horizontal: 17.5
                  horizontal: screenwidth*0.0408
              ),
              width: screenwidth*0.906,
              //       height: 40,
              height: screenwidth*0.0934,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  boxShadow: [BoxShadow(offset: Offset(0,0),
                      blurRadius: 10,color: Colors.black.withOpacity(0.05))]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/glogo.png",
//                width: 20,
                    width: screenwidth*0.0467,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth*0.2),
                    child: Text("Continue with Google",
                      style: TextStyle(
                          fontFamily: sfpromedium,
                          color: Colors.black,
//                    fontSize: 13.5
                          fontSize: screenwidth*0.0315
                      ),),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget findmatchmodule(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15,top: 12),
            child: Image.asset("assets/6111095.jpg",width: 248,
            ),
          ),
    GestureDetector(
    onTap: (){
    assignrandomuser(context);
    },
    child: Container(
            height: 37,
            width: 213,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Center(
              child: Text("Find a match",style: TextStyle(
                fontSize: 16,
                fontFamily:gilroybold,
                color: Colors.white
              ),),
            ),
          )),
          Container(
            width: screenwidth,
            margin: EdgeInsets.only(left: 18,right: 18, top:27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 23,width: 23,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFFA0A0)
                  ),
                  child: Center(
                    child: Text("!",style: TextStyle(
                        fontFamily:gilroymediumd,
                        color: Colors.white,
                        fontSize: 19
                    ),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Text("We use your responses to match you with someone\nwhom "
                      "you might have an interesting conversation with.",style: TextStyle(
                      fontFamily:gilroymediumd,
                      color: Colors.black,
                    fontSize: 13
                  ),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}