import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/admin/manage_course.dart';
import 'package:proxy_killer/screens/home/teacher/start_class.dart';
import 'package:proxy_killer/screens/models/courseCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    List<Widget> myWidgets = [];
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal:20,vertical:20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width:5, color:Colors.blueGrey),
                        backgroundColor: Color(0xFF001a33),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const startClass()),
                        );
                      },
                      child: Text('Start a new Class'),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Enroll student in your Course',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001a33),
                  ),
                ),
                SizedBox(height:15.0),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasData){
                    var object = snapshot.data!;
                    String name = object['name'];
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('courses').where('teacher',isEqualTo: name).snapshots(),
                      builder:(context,AsyncSnapshot<QuerySnapshot> snapshot){
                          if(snapshot.hasData){
                            int length = snapshot.data!.docs.length;
                            var previous = null;
                            myWidgets.clear();
                            for(int i=0;i<length;i++){
                              var object = snapshot.data!.docs[i];
                              if(identical(previous,null)==false){
                                myWidgets.add(Column(
                                  children:[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CourseCard(name:previous['name'],id:previous['id'],dept:previous['dept'],teacher:previous['teacher'],option: 1),
                                        SizedBox(width: 20.0,),
                                        CourseCard(name:object['name'],id:object['id'],dept:object['dept'],teacher:object['teacher'],option: 1),
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
                              myWidgets.add(Row(
                                children: [
                                  CourseCard(name:previous['name'],id:previous['id'],dept:previous['dept'],teacher:previous['teacher'],option: 1),
                                  SizedBox(width: 20.0,),
                                ]
                              ));
                            }
                          }
                          return createCourseList(myWidgets);
                      });
                  }
                  else return const Material(child: Center(child: CircularProgressIndicator(),),);
                }),
              ],
            ),
          )
      ),
    );
  }
}
