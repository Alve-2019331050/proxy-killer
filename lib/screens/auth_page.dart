import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/admin/home.dart';
import 'package:proxy_killer/screens/login_page.dart';


class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            //user logged in
            return AdminHome();
          }else{
            //user NOT logged in
            return LoginPage();
          }

        },
      ),
    );
  }
}