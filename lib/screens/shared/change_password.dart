import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/my_button.dart';
import '../../components/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title:  const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF01011a),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 200),
          child: SingleChildScrollView(
            //scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 40),
                MyButton(
                  buttonText: 'Send Restoring Email',
                  onTap: (){
                    //print('email');
                    auth.sendPasswordResetEmail(
                        email: emailController.text.toString())
                        .then((value){
                          Utils().toastMessage(
                              'Email to reset password has been sent to your email address.Please check email.'
                          );
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
