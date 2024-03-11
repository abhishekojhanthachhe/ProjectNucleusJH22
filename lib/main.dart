import 'package:arche/screens/auth/login.dart';
import 'package:arche/screens/auth/signup.dart';
import 'package:arche/screens/base/home.dart';
import 'package:arche/screens/splash.dart';
import 'package:arche/screens/userflow/signupqueries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arche- Jacobs HAck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/Splash': (BuildContext context) => SplashScreen(),
        '/Login': (BuildContext context) => Login(),
        '/SignUp': (BuildContext context) => SignUp(),
        '/SignUpQueries': (BuildContext context) => SignUpQueries(),
        '/Home': (BuildContext context) => Home(),
//        '/OnBoarding': (BuildContext context) => MainOnBoarding(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Firebase.initializeApp();
          await FirebaseFirestore.instance.collection("Testtransmission").add(
              {
                "newone":"1"
              });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
