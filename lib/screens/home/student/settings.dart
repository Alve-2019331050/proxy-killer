import 'package:flutter/material.dart';

import '../../shared/settings_screen.dart';

class studentSetting extends StatefulWidget {
  const studentSetting({Key? key}) : super(key: key);

  @override
  State<studentSetting> createState() => _studentSettingState();
}

class _studentSettingState extends State<studentSetting> {
  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}

