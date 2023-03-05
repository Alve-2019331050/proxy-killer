import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxy_killer/components/my_button.dart';

class startClass extends StatefulWidget {
  const startClass({Key? key}) : super(key: key);

  @override
  State<startClass> createState() => _startClassState();
}

class _startClassState extends State<startClass> {
  TimeOfDay _startTimeOfDay = new TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTimeOfDay = new TimeOfDay(hour: 0, minute: 0);
  String dropDownValue = 'Select Course';

  Widget buildDropDown(dynamic data){
    List<String> courseList = ['Select Course'];
    int length = data!.docs.length;
    for(int i=0;i<length;i++){
      var object = data!.docs[i];
      courseList.add(object['dept']+' '+object['id']);
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
      items: courseList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value,
              style: TextStyle(
                color:Color(0xFF001a33),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
          ),
        );
      }).toList(),
    );
  }

  final _timePickerTheme = TimePickerThemeData(
    backgroundColor: Colors.blue[50],
    // hourMinuteShape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(0)),
    //   side: BorderSide(color: Colors.blue, width: 1),
    // ),
    dayPeriodBorderSide: const BorderSide(color: Colors.black26, width: 2),
    // dayPeriodColor: Colors.blue[900],
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(8)),
    //   side: BorderSide(color: Color(0xff5e83ba), width: 4),
    // ),
    // dayPeriodTextColor: Colors.white,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.black26, width: 4),
    ),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected) ? Colors.blue.shade900 : Colors.black26),
    hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? Colors.white : Colors.blue.shade900),
    dialHandColor: Colors.blue[900],
    dialBackgroundColor: Colors.black26,
    hourMinuteTextStyle: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
    dayPeriodTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    entryModeIconColor: Colors.black87,
  );

  void _showTimePickerEnd(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              // This uses the _timePickerTheme defined above
              timePickerTheme: _timePickerTheme,
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black87),
                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor: MaterialStateColor.resolveWith((states) => Colors.black87),
                ),
              ),
            ),
            child: child!,
          );
        },
    ).then((value){
      setState(() {
        _endTimeOfDay = value!;
      });
    });
  }

  void _showTimePickerStart(){
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // This uses the _timePickerTheme defined above
            timePickerTheme: _timePickerTheme,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black87),
                foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                overlayColor: MaterialStateColor.resolveWith((states) => Colors.black87),
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value){
      setState(() {
        _startTimeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF001a33),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left:30,top:40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Text(
              'It\'s time to Start\na new Class!',
              style: TextStyle(
                  fontSize: 30,
                  color:Color(0xFF001a33),
              ),
            ),
            SizedBox(height:30),
            Row(
              children: [
                Text(
                  'Course :',
                  style: TextStyle(
                    fontSize: 25,
                    color:Color(0xFF001a33),
                  ),
                ),
                SizedBox(width: 10,),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                  builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.hasData){
                      var object = snapshot.data!;
                      String name = object['name'];
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('courses').where('teacher',isEqualTo: name).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(snapshot.hasData){
                            return buildDropDown(snapshot.data);
                          }
                          else{
                            return Container();
                          }
                        },
                      );
                    }
                    else return const Material(child: Center(child: CircularProgressIndicator(),),);
                  }
                ),
              ],
            ),
            SizedBox(height:60),
            Row(
              children:[
                Text(
                  'Pick Starting time :',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF001a33),
                  ),
                ),
                SizedBox(width:10),
                ElevatedButton(
                    onPressed: _showTimePickerStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF001a33),
                    ),
                    child: Text(
                      _startTimeOfDay.format(context).toString(),
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(height:30),
            Row(
              children:[
                Text(
                  'Pick Ending time :',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF001a33),
                  ),
                ),
                SizedBox(width:10),
                ElevatedButton(
                  onPressed: _showTimePickerEnd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF001a33),
                  ),
                  child: Text(
                    _endTimeOfDay.format(context).toString(),
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '       (Allowed)',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF001a33),
              ),
            ),
            SizedBox(height:80),
            Align(
              alignment: Alignment.center,
              child: MyButton(buttonText:'Start Class',onTap:(){
                print(_startTimeOfDay);
                print(_endTimeOfDay);
                print(dropDownValue);
                Navigator.pop(context);
              })
            )
          ],
        ),
      ),
    );
  }
}
