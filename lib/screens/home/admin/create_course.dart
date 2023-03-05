import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class createCourse extends StatefulWidget {
  const createCourse({Key? key}) : super(key: key);

  @override
  State<createCourse> createState() => _createCourseState();
}

class _createCourseState extends State<createCourse> {
  TextEditingController name = new TextEditingController();
  TextEditingController id = new TextEditingController();
  TextEditingController dept = new TextEditingController();
  String dropDownValue = 'Select Teacher';

  Widget buildDropDown(dynamic data){
    List<String> teacherList = ['Select Teacher'];
    int length = data!.docs.length;
    for(int i=0;i<length;i++){
      var object = data!.docs[i];
      teacherList.add(object['name']);
    }
    return DropdownButton<String>(
      value: dropDownValue,
      elevation: 18,
      style: const TextStyle(fontSize:17,color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String? value){
        setState(() {
          dropDownValue = value!;
        });
      },
      items: teacherList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF001a33),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:15.0),
                Text("Create a new", style: TextStyle(fontSize: 30, color:Color(0xFF001a33)),),
                Text("Course !", style: TextStyle(fontSize: 30, color:Color(0xFF001a33)),),

                SizedBox(height:30.0),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                  ),
                ),
                SizedBox(height:30.0),
                TextFormField(
                  controller: id,
                  decoration: InputDecoration(
                    labelText: 'Course No',
                  ),
                ),
                SizedBox(height:30.0),
                TextFormField(
                  controller: dept,
                  decoration: InputDecoration(
                    labelText: 'Department',
                  ),
                ),
                SizedBox(height:20.0),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').where('role',isEqualTo: 'Teacher').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      return buildDropDown(snapshot.data);
                    }
                    else{
                      return Container();
                    }
                  },
                ),
                SizedBox(height:50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create Course',
                      style: TextStyle(fontSize:30,color:Color(0xFF001a33)),
                    ),
                    CircleAvatar(
                      radius:30,
                      backgroundColor: Color(0xFF001a33),
                      child: IconButton(
                          onPressed: (){
                            Map<String,dynamic> data = {
                              'name':name.text,
                              'id':id.text,
                              'dept':dept.text,
                              'teacher':dropDownValue,
                            };
                            sendData(data);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future sendData(Map<String,dynamic> data) async{
  final doc = FirebaseFirestore.instance.collection('courses')
      .doc(data['dept']+' '+data['id']);
  await doc.set(data);
}
