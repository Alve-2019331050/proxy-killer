import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future getStudentData() async{
    var data = await FirebaseFirestore.instance.collection("users").where('role',isEqualTo:'Student').get();
    return data.docs;
  }

  Future getTeacherData() async{
    var data = await FirebaseFirestore.instance.collection("users").where('role',isEqualTo:'Teacher').get();
    return data.docs;
  }

  Future getCourseData() async{
    var data = await FirebaseFirestore.instance.collection("courses").get();
    return data.docs;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFE3F1FD),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 160.0,
                          height: 220.0,
                          child: FutureBuilder(
                            future:getStudentData(),
                            builder:(context,snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Material(child: Center(child: CircularProgressIndicator(),),);
                              }
                              else {
                                print(snapshot.data.length);
                                return Card(
                                  color: Color(0xFF001a33),//const Color.fromARGB(0, 0, 0, 0),
                                  //elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: Color(0xFFE3F1FD),
                                            size: 80.0,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            "Student",
                                            style: TextStyle(
                                              color: Colors.white,//Color(0xFF001a33),
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            snapshot.data.length.toString(),
                                            style: TextStyle(
                                              color: Colors.white,// Color(0xFF001a33),
                                              fontSize: 40.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          ),
                        ),
                        SizedBox(
                          width: 160.0,
                          height: 220.0,
                          child: FutureBuilder(
                            future: getTeacherData(),
                            builder: (context,snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Material(child: Center(child: CircularProgressIndicator(),),);
                              }
                              else{
                                return Card(
                                  color: Color(0xFF001a33),//const Color.fromARGB(0, 0, 0, 0),
                                  //elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: Color(0xFFE3F1FD),
                                            size: 80.0,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            "Teacher",
                                            style: TextStyle(
                                              color: Colors.white,//Color(0xFF001a33),
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            snapshot.data.length.toString(),
                                            style: TextStyle(
                                              color: Colors.white,//Color(0xFF001a33),
                                              fontSize: 40.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                );
                              }
                            }
                          )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 160.0,
                          height: 220.0,
                          child:FutureBuilder(
                            future: getCourseData(),
                            builder:(context,snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Material(child: Center(child: CircularProgressIndicator(),),);
                              }
                              else{
                                return Card(
                                  color: Color(0xFF001a33), //const Color.fromARGB(0, 0, 0, 0),
                                  //elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.school,
                                            color: Color(0xFFE3F1FD),
                                            size: 80.0,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            "Course",
                                            style: TextStyle(
                                              color: Colors.white,//Color(0xFF001a33),
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            snapshot.data.length.toString(),
                                            style: TextStyle(
                                              color: Colors.white,//Color(0xFF001a33),
                                              fontSize: 40.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
