import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mascot_app/DrownerMenu/ContactHome.dart';
import 'package:mascot_app/DrownerMenu/InfoComponent.dart';
import 'package:mascot_app/DrownerMenu/Ppolicies.dart';
import 'package:mascot_app/ExtraComponents/Funtions.dart';
import 'package:mascot_app/ExtraComponents/wrapper.dart';
import 'package:mascot_app/Login/Loginmain.dart';
import 'package:mascot_app/mainApp.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:mascot_app/provider/cards_provider.dart';
import 'package:mascot_app/provider/dewornm_provider.dart';
import 'package:mascot_app/provider/event_provider.dart';
import 'package:mascot_app/provider/medicalV_provider.dart';
import 'package:mascot_app/provider/notes_provider.dart';
import 'package:mascot_app/provider/vaccine_provider.dart';
import 'package:provider/provider.dart'; 

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel>.value(
              value: AuthServices().user,
              child: MultiProvider( 
              providers: [
                ChangeNotifierProvider(
                  create: (context) => EventProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => CardProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => NotesProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => VaccineProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => DewornmProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => MedicalVProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'MascotApp',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: Wrapper(),
              ),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
            title: 'MascotApp',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              body: Image.asset('./Assets/logo ocho.png', height: 200,),
            ),
          );
      },
    );
  }
}