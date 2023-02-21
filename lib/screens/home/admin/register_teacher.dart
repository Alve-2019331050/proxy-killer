import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proxy_killer/components/my_button.dart';

class RegisterTeacher extends StatefulWidget {
  const RegisterTeacher({Key? key}) : super(key: key);

  @override
  State<RegisterTeacher> createState() => _RegisterTeacherState();
}

/*class UserHelper{
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static saveUser(User user) async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<string,
  }
}
*/
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
      //pop the loading circle
      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore _db = FirebaseFirestore.instance;
    //print(uid);
    final userRef = _db.collection("users").doc(uid);
    //add user details
    addUserDetails(
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
                  Icon(
                    Icons.note_add,
                    size: 100,
                    color: Colors.indigo,
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color : Colors.indigo,
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigoAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigoAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigoAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
