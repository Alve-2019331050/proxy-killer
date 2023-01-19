import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/models/courseCard.dart';

class ManageCourse extends StatefulWidget {
  const ManageCourse({Key? key}) : super(key: key);

  @override
  State<ManageCourse> createState() => _ManageCourseState();
}

class _ManageCourseState extends State<ManageCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:20,vertical:20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'All Assigned Courses',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height:10.0),
              Column(
                children: [
                  //course card will be added,currently dummy data
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CourseCard(),
                      SizedBox(width: 20.0,),
                      CourseCard(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
