import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:software_engineering/controller/bottom_nav_bar.dart';
import 'package:software_engineering/firebase_options.dart';
import 'package:software_engineering/login/sign_in.dart';
import 'package:software_engineering/screen/introduction_screen.dart';
import 'database/data_manager.dart';

DataManager dataManager = DataManager();
int? initScreen;

void main() async {
  Animate.restartOnHotReload = true;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true
  );

  // initialize hive
  await Hive.initFlutter();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');

  await preferences.setInt('initScreen', 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
        routes: {
          'home': (context) => const HomeController(),
          'onboard': (context) => const IntroductionScreen(),
        },
      ),
    );
  }
}

// control the state to Log In and Log out
class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          // check if there is user's log in
          if(snapshot.hasData) {
            return MyBottomNavBar();
          }
          else {
            MyBottomNavBar.controller.jumpToTab(0);
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
