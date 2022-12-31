import 'package:flutter/material.dart';

import '../models/menuItems.dart';

class HelperDrawer extends StatefulWidget {
  // const HelperDrawer({Key? key}) : super(key: key);

  List<MenuItems> items;
  Function changePage;
  String name;
  HelperDrawer({required this.items,required this.changePage,required this.name});
  @override
  State<HelperDrawer> createState() => _HelperDrawerState();
}

class _HelperDrawerState extends State<HelperDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color:Colors.blue
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/admin.jpg'),
                    radius: 35.0
                  ),
                  SizedBox(height:10.0),
                  Text(
                    (widget.name),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children:
                  widget.items.map((item) => menuItem(item,widget.changePage,context)).toList(),
              ),
            ),
          ),
        ),
      ]
      ),
    );
  }
}

Widget menuItem(MenuItems item,Function changePage,BuildContext context){
  return Material(
    child: InkWell(
      onTap: (){
        Navigator.pop(context);
        changePage(item);
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                item.icon,
                size: 21,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                item.text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
