import 'package:flutter/material.dart';

import '../../shared/settings_screen.dart';

class teacherSetting extends StatefulWidget {
  const teacherSetting({Key? key}) : super(key: key);

  @override
  State<teacherSetting> createState() => _teacherSettingState();
}

class _teacherSettingState extends State<teacherSetting> {
  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}

