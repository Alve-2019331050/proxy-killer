import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/components/my_button.dart';
import 'package:proxy_killer/screens/home/admin/create_course.dart';
import 'package:proxy_killer/screens/home/teacher/show_result.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String dropDownValue = 'Select Course';
  DateTime _dateTime = DateTime.now();
  bool setDataDone = false;
  DatabaseReference attendance = FirebaseDatabase.instance.ref("Attendance");
  bool result = false;

  Widget buildDropDown(dynamic data) {
    List<String> courseList = ['Select Course'];
    int length = data!.docs.length;
    for (int i = 0; i < length; i++) {
      var object = data!.docs[i];
      courseList.add(object['dept'] + ' ' + object['id']);
    }
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(50),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton(
              value: dropDownValue,
              elevation: 18,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              onChanged: (String? value) {
                setState(() {
                  dropDownValue = value!;
                });
              },
              icon: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.arrow_drop_down_circle_outlined)),
              iconEnabledColor: Color(0xFF001a33),
              underline: Container(),
              dropdownColor: Colors.blue[50],
              items: courseList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Color(0xFF001a33),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            )));
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: Color(0xFF001a33), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Color(0xFF001a33), // body text color
            ),
            dialogBackgroundColor: Colors.blue[50],
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF001a33), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  Future getClass() async {
    var data = await FirebaseFirestore.instance.collection("classes").get();
    return data.docs;
  }

  bool check(var classinfo, var student) {
    if (classinfo['day'] != student.child('day').value) return false;
    if (classinfo['month'] != student.child('month').value) return false;
    int classmin = classinfo['start minute'];
    int h = classinfo['start hour'];
    if (classinfo['start period'] == 'pm') h = h + 12;
    classmin = classmin + 60 * h;
    int studentmin = int.parse(student.child('minute').value);
    h = int.parse(student.child('hour').value);
    if (student.child('designation').value == 'PM') h = h + 12;
    studentmin = studentmin + 60 * h;
    if (studentmin < classmin) return false;
    classmin = classinfo['end minute'];
    h = classinfo['end hour'];
    if (classinfo['end period'] == 'pm') h = h + 12;
    classmin = classmin + 60 * h;
    if (studentmin > classmin) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    List<dynamic> classInfo = [];
    List<dynamic> attendanceList = [];
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: FutureBuilder(
          future: getClass(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              classInfo.clear();
              for (int i = 0; i < snapshot.data.length; i++) {
                classInfo.add(snapshot.data[i]);
              }
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: FirebaseAnimatedList(
                      query: attendance,
                      itemBuilder: (context, snapshot, animation, index) {
                        String reg_no = snapshot.child('id').value.toString();
                        while (reg_no.length < 3) reg_no = '0' + reg_no;
                        for (int i = 0; i < classInfo.length; i++) {
                          if (check(classInfo[i], snapshot)) {
                            Map<String, dynamic> data = {
                              'course': classInfo[i]['course'],
                              'registration no': '2019331' + reg_no,
                              'day': classInfo[i]['day'],
                              'month': classInfo[i]['month'],
                              'hour': snapshot.child('hour').value,
                              'minute': snapshot.child('minute').value,
                              'period': snapshot.child('designation').value,
                            };
                            sendData(data);
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\tSelect course and date to see\n\t\t\t\t\t\t\t\t\tattendance report',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF001a33),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Text(
                          'Course : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF001a33),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                var object = snapshot.data!;
                                String name = object['name'];
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('courses')
                                      .where('teacher', isEqualTo: name)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return buildDropDown(snapshot.data);
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                              } else
                                return const Material(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    flex: 3,
                    child: Row(children: [
                      Text(
                        'Pick date : ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF001a33),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _showDatePicker,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF001a33),
                        ),
                        child: Text(
                          _dateTime.month.toString() +
                              '/' +
                              _dateTime.day.toString() +
                              '/' +
                              _dateTime.year.toString(),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    flex: 3,
                    child: MyButton(
                        buttonText: 'See Report',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => showResult(dropDownValue:dropDownValue,dateTime:_dateTime)),
                          );
                        }),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    flex: 12,
                    child: Container(),
                  ),
                ],
              );
            } else
              return const Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          },
        ),
      ),
    );
  }
}

Future sendData(Map<String, dynamic> data) async {
  final doc = FirebaseFirestore.instance.collection('attendance');
  bool ok = true;
  await doc.get().then(
    (QuerySnapshot snap) {
      for (var docSnapshot in snap.docs) {
        if (identical(docSnapshot.data(), data) == false) {
          ok = false;
        }
      }
    },
    onError: (e) => print("Error getting document: $e"),
  );
  // print(ok);
  if (ok) await doc.add(data);
}
