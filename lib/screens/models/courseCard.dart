import 'package:flutter/material.dart';
import 'package:proxy_killer/screens/home/teacher/enroll_student.dart';

import '../shared/bottomSheet.dart';

class CourseCard extends StatefulWidget {
  // const CourseCard({Key? key}) : super(key: key);

  String name,dept,teacher,id;
  int option;
  CourseCard({required this.name,required this.id,required this.dept,required this.teacher,required this.option});
  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {

  Future<dynamic> bottomSheet(){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.blue[50],
        builder: (context) => DraggableScrollableSheet(
          expand:false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: createBottomSheet(dept:widget.dept,id:widget.id),
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:5.0),
      width:175,
      height:175,
      decoration: BoxDecoration(
        color: Color(0xFF001a33),
        borderRadius: BorderRadius.circular(15),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0,3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:10,vertical:10),
        child: TextButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.dept + ' ' + widget.id,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                widget.teacher,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          onPressed: (){
            if(widget.option == 0) bottomSheet();
            else if(widget.option == 1){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => enrollStudent(dept:widget.dept,id:widget.id)),
              );
            }
          },
        ),
      ),
    );
  }
}
