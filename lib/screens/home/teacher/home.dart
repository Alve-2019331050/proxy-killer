import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/teacher/attendance.dart';
import 'package:proxy_killer/screens/home/teacher/dashboard.dart';
import 'package:proxy_killer/screens/home/teacher/settings.dart';

import '../../models/menuItems.dart';
import '../../shared/drawer.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  MenuItems currentPage = MenuItems(text: 'Dashboard',icon: Icons.dashboard_outlined,tap: Dashboard());
  List<MenuItems> items = [
    MenuItems(text: 'Dashboard',icon: Icons.dashboard_outlined,tap: Dashboard()),
    //to-do: change attendance icon
    MenuItems(text: 'Attendance',icon: Icons.calendar_month_sharp,tap: Attendance()),
    MenuItems(text: 'Settings',icon: Icons.settings,tap: teacherSetting()),
  ];

  //log out user method
  void logUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.blue[50],
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
