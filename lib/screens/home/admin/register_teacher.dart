import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proxy_killer/components/my_button.dart';

class RegisterTeacher extends StatefulWidget {
  const RegisterTeacher({Key? key}) : super(key: key);

  @override
  State<RegisterTeacher> createState() => _RegisterTeacherState();
}

class _RegisterTeacherState extends State<RegisterTeacher> {
  //Text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signUp() async{
    //create user
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    //find uid
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore _db = FirebaseFirestore.instance;
    //print(uid);
    final userRef = _db.collection("users").doc(uid);
    //add user details
    await addUserDetails(
      _nameController.text.trim(),
      _emailController.text.trim(),
      userRef,
    );
    //log out teacher
    FirebaseAuth.instance.signOut();
    //print('hello');
    //signing admin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'admin@gmail.com',
        password: 'ph5078',
      );
      //pop the loading circle
      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    //uid = FirebaseAuth.instance.currentUser?.uid;
    //print(uid);
  }

  Future addUserDetails(String name, String email,final userRef) async{
    await userRef.set({
      'name': name,
      'email': email,
      'role':'Teacher',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 50,),
                  Icon(
                    Icons.people_alt_rounded,
                    size: 100,
                    color: Color(0xFF001a33),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Fill up Teacher Information",
                    style: TextStyle(
                      fontSize: 25,
                      //fontWeight: FontWeight.bold,
                      color : Color(0xFF001a33),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
              //Name TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF001a33)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: 'Name',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              //Email TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF001a33)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              //Password TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF001a33)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              const SizedBox(height: 30,),

              //Register Button
              MyButton(
                  buttonText: 'Register',
                  onTap: (){
                    signUp();
                  },
              ),
            ],
          ),
        ),

      ),
    );
  }
}
