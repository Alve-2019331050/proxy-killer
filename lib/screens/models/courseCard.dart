import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({Key? key}) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:5.0),
      width:175,
      height:175,
      decoration: BoxDecoration(
        color: Colors.grey[500],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CSE 252',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Advanced Competitive Programming',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'Abid Hossain Mishal',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          onPressed: (){
            print('Clicked');
          },
        ),
      ),
    );
  }
}
