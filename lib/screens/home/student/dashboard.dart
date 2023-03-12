import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/courseCard.dart';
import '../admin/manage_course.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future getData(dynamic course) async{
    var ref = await FirebaseFirestore.instance.collection('courses').doc(course).get();
    // print(ref.data());
  }

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    List<Widget> myWidgets = [];
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Courses you are enrolled in',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001a33),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('takes')
                      .where('docID',isEqualTo: uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var previous = null;
                      int length = snapshot.data!.docs.length;
                      myWidgets.clear();
                      for (int i = 0; i < length; i++) {
                        var object = snapshot.data!.docs[i];
                        if(identical(previous,null)==false){
                          myWidgets.add(Column(
                              children:[
                                Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CourseCard(name:previous['name'],id:previous['course'].substring(4),dept:previous['course'].substring(0,3),teacher:previous['teacher'],option: 2),
                                      SizedBox(width: 20.0,),
                                      CourseCard(name:object['name'],id:object['course'].substring(4),dept:object['course'].substring(0,3),teacher:object['teacher'],option: 2),
                                    ]
                                ),
                                SizedBox(height:10.0),
                              ]
                          ));
                          previous = null;
                        }
                        else{
                          previous = object;
                        }
                      }
                      if(identical(previous, null)==false){
                        myWidgets.add(Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CourseCard(name:previous['name'],id:previous['course'].substring(4),dept:previous['course'].substring(0,3),teacher:previous['teacher'],option: 2),
                              SizedBox(width: 20.0,),
                            ]
                        ));
                      }
                    }
                    return createCourseList(myWidgets);
                  })
              ],
            ),
          )),
    );
  }
}
