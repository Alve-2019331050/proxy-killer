import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proxy_killer/firebase_options.dart';
import 'package:proxy_killer/screens/auth_page.dart';
import 'package:proxy_killer/screens/home/teacher/home.dart';
import 'package:proxy_killer/screens/home/admin/home.dart';
import 'package:proxy_killer/screens/home/admin/register_teacher.dart';
import 'package:proxy_killer/screens/home/student/home.dart';
import 'package:proxy_killer/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proxy_killer/screens/shared/settings_screen.dart';

import 'screens/shared/change_password.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'proxy-killer',
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          children:  const [
            Text(
              'ProxyKiller',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                //fontWeight: FontWeight.bold,
                letterSpacing: 10.0,
                fontFamily: 'HomemadeApple',
              ),
            )
          ],
        ),
        backgroundColor: const Color(0xFF01011a),
        nextScreen: const AuthPage(),
      duration: 800,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
