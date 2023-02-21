import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/components/my_textfield.dart';
import 'package:proxy_killer/components/my_button.dart';

import 'auth_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //log user in method
  void logUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //shows Invalid Email message if wrong email given
    void wrongEmailMessage() {
      Widget okButton = ElevatedButton(
        child: const Text("OK",style: TextStyle(color: Colors.white),),
        onPressed:(){Navigator.of(context).pop();},
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: (SizedBox(
            height: 150.0,
            width: 30.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: const <Widget>[
                  Text(
                    'Login Failed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Sorry, we can't find an account with this email address.",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          )),actions: [
            okButton,
          ],
          );
        },
      );
    }

    //shows Wrong Password message if wrong password given
    void wrongPasswordMessage() {
      Widget okButton = ElevatedButton(
        child: const Text("OK",style: TextStyle(color: Colors.white),),
        onPressed:(){Navigator.of(context).pop();},
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: (SizedBox(
              height: 150.0,
              width: 30.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: const <Widget>[
                    Text(
                      'Incorrect Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "The password you entered is incorrect. Please try again later.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            )),actions: [
            okButton, //bug: ok button when pressed not working
          ],
          );
        },
      );
    }

    //logging in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 50),
            //logo
            const Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(height: 50),

            //welcome text
            const Text(
              'Welcome To ProxyKiller...',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            //username textfield
            MyTextField(
              hintText: "Username",
              controller: emailController,
              obscureText: false,
            ),

            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),

            //forgot password?
            Padding(
              padding: const EdgeInsets.only(left: 210.0),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 25),

            //sign in button
            MyButton(
              buttonText: 'Log In',
              onTap: logUserIn,
            ),
            //or
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.5,
                    color: Colors.indigo[300],
                  )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 0.5,
                    color: Colors.indigo[300],
                  )),
                ],
              ),
            ),
            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?',
                    style: TextStyle(
                      color: Colors.indigo[300],
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    )),
                const SizedBox(width: 4),
                Text(
                  'Register now',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
