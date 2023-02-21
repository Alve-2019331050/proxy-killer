import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/admin/create_course.dart';
import 'package:proxy_killer/screens/models/courseCard.dart';
import 'package:proxy_killer/screens/shared/bottomSheet.dart';



class ManageCourse extends StatefulWidget {
  const ManageCourse({Key? key}) : super(key: key);

  @override
  State<ManageCourse> createState() => _ManageCourseState();
}

class _ManageCourseState extends State<ManageCourse> {

  @override
  Widget build(BuildContext context) {
    List<Widget> myWidgets = [];
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:20,vertical:20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //new course creation
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width:5, color:Colors.blueGrey),
                        backgroundColor: Colors.indigo,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const createCourse()),
                        );
                      },
                      child: Text('Create new Course'),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'All Assigned Courses',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height:10.0),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('courses').snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
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
                                    CourseCard(name:previous['name'],id:previous['id'],dept:previous['dept'],teacher:previous['teacher'],option: 0),
                                    SizedBox(width: 20.0,),
                                    CourseCard(name:object['name'],id:object['id'],dept:object['dept'],teacher:object['teacher'],option: 0),
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
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CourseCard(name:previous['name'],id:previous['id'],dept:previous['dept'],teacher:previous['teacher'],option: 0),
                              SizedBox(width: 20.0,),
                            ]
                        ));
                      }
                      print(myWidgets.length);
                    }
                    return createCourseList(myWidgets);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget createCourseList(List<Widget> myWidget){
  return Column(
    children: [
      for(var w in myWidget) w
    ],
  );
}
