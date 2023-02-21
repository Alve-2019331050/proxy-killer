import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/admin/manage_course.dart';
import 'package:proxy_killer/screens/home/admin/register_student.dart';
import 'package:proxy_killer/screens/home/admin/register_teacher.dart';
import 'package:proxy_killer/screens/models/menuItems.dart';
import 'package:proxy_killer/screens/shared/drawer.dart';
import 'dashboard.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  MenuItems currentPage = MenuItems(text: 'Dashboard',icon: Icons.dashboard_outlined,tap: Dashboard());
  List<MenuItems> items = [
    MenuItems(text: 'Dashboard',icon: Icons.dashboard_outlined,tap: Dashboard()),
    MenuItems(text: 'Register New Teacher',icon: Icons.app_registration_outlined,tap: RegisterTeacher()),
    MenuItems(text: 'Register New Student',icon: Icons.app_registration_outlined,tap: RegisterStudent()),
    MenuItems(text: 'Manage Courses',icon: Icons.settings_applications_outlined, tap: ManageCourse()),
  ];

  //log out user method
  void logUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HelperDrawer(
          items: items,
          changePage: (page){
            setState((){
              currentPage = page;
            });
          },
        name: 'Admin'
      ),
      appBar: AppBar(
        backgroundColor:Colors.indigo,
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
