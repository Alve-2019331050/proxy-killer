import 'package:cloud_firestore/cloud_firestore.dart';
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
                color:Colors.indigo,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
          ),
        );
      }).toList(),
    );
  }

  void _showTimePickerEnd(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
    ).then((value){
      setState(() {
        _startTimeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.indigo,
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
                  color:Color(0xFF363f93),
              ),
            ),
            SizedBox(height:30),
            Row(
              children: [
                Text(
                  'Course :',
                  style: TextStyle(
                    fontSize: 25,
                    color:Color(0xFF363f93),
                  ),
                ),
                SizedBox(width: 10,),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('courses').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      return buildDropDown(snapshot.data);
                    }
                    else{
                      return Container();
                    }
                  },
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
                    color: Color(0xFF363f93),
                  ),
                ),
                SizedBox(width:10),
                ElevatedButton(
                    onPressed: _showTimePickerStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF363f93),
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
                    color: Color(0xFF363f93),
                  ),
                ),
                SizedBox(width:10),
                ElevatedButton(
                  onPressed: _showTimePickerEnd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF363f93),
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
                color: Color(0xFF363f93),
              ),
            ),
            SizedBox(height:100),
            Align(
              alignment: Alignment.center,
              child: MyButton(onTap:(){
                Navigator.pop(context);
              })
            )
          ],
        ),
      ),
    );
  }
}
