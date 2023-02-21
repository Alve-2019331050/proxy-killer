import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/admin/home.dart';
import 'package:proxy_killer/screens/home/student/home.dart';
import 'package:proxy_killer/screens/home/teacher/home.dart';
import 'package:proxy_killer/screens/login_page.dart';


class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData && snapshot.data != null){
            //user logged in
            return StreamBuilder(stream: FirebaseFirestore.instance.
                collection("users").doc(snapshot.data?.uid).snapshots(),

              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                if(snapshot.hasData && snapshot.data != null){
                  Map<String, dynamic> user = snapshot.data?.data() as Map<String, dynamic>;

                  if(user['role'] == 'Student'){
                    return const StudentHome();
                  }else if(user['role'] == 'Teacher'){
                    return const TeacherHome();
                  }else{
                    return const AdminHome();
                  }
                }
                return const Material(child: Center(child: CircularProgressIndicator(),),);
              }

            );

            //return HomePage();
          }else{
            //user NOT logged in
            return const LoginPage();
          }

        },
      ),
    );
  }
}