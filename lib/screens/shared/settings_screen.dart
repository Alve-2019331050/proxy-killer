
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../auth_page.dart';
import 'change_password.dart';
import '../models/settings_tile.dart';
//import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              //Settings text
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  color: Color(0xFF080121)
                ),
              ),

              const SizedBox(height: 100.0),
              
              SettingsTile(
                color: const Color(0xFF080121),//Color(0xFF03010a),
                icon: Ionicons.lock_closed,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>const ChangePassword())
                  );
                },

              ),

              const SizedBox(height: 40.0),

              SettingsTile(
                color: const Color(0xFF080121),//Color(0xFF03010a),
                icon: Ionicons.person_circle_outline,
                title: 'Edit information',
                onTap: () {  },

              ),

              const SizedBox(height: 40.0),

              SettingsTile(
                color: const Color(0xFF080121),//Color(0xFF03010a),
                icon: Ionicons.color_palette_outline,
                title: 'Theme',
                onTap: () {  },

              ),

              const SizedBox(height: 40.0),

            ],
          ),
        ),
      ),
    );
  }
}
