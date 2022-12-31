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
    MenuItems(text: 'Settings',icon: Icons.settings,tap: Settings()),
    MenuItems(text: 'Logout',icon: Icons.logout_outlined,tap: Dashboard())
  ];
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
          name: 'Student'
      ),
      appBar: AppBar(
        title: Text(
          '${currentPage.text}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      body: currentPage.tap,
    );
  }
}
