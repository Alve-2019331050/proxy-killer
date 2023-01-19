import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //log out user method
  void logUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: logUserOut, icon: const Icon(Icons.logout)),
          ],
        ),
        body: const Center(
          child: Text(
            "Logged in: ",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ));
  }
}
