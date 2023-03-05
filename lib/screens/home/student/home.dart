import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/student/dashboard.dart';
import 'package:proxy_killer/screens/home/student/settings.dart';
import 'package:proxy_killer/screens/shared/drawer.dart';

import '../../models/menuItems.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  MenuItems currentPage = MenuItems(text: 'Dashboard',icon: Icons.dashboard_outlined,tap: Dashboard());
  List<MenuItems> items = [
    MenuItems(text: 'Dashboard',icon: Icons.dashboard_outlined,tap: Dashboard()),
    MenuItems(text: 'Settings',icon: Icons.settings,tap: studentSetting()),
  ];

  //log out user method
  void logUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      drawer: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(uid).snapshots(),
        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            Map<String, dynamic> user = snapshot.data?.data() as Map<String, dynamic>;
            // print(user['name']);
            String name = user['name'];
            return HelperDrawer(
                items: items,
                changePage: (page){
                  setState((){
                    currentPage = page;
                  });
                },
                name:name
            );
          }
          else return const Material(child: Center(child: CircularProgressIndicator(),),);
        }
      ),
      appBar: AppBar(
        backgroundColor:Color(0xFF001a33),
        title: Text(
          '${currentPage.text}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(onPressed: logUserOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: currentPage.tap,
    );
  }
}
