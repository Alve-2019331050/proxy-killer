import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class createBottomSheet extends StatefulWidget {

  String dept,id;
  createBottomSheet({required this.dept,required this.id});
  @override
  State<createBottomSheet> createState() => _createBottomSheetState();
}

class _createBottomSheetState extends State<createBottomSheet> {
  String dropDownValue = 'Assign a new Teacher';

  Widget buildDropDown(dynamic data){
    List<String> teacherList = ['Assign a new Teacher'];
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
          child: Text(
              value,
              style: TextStyle(
                color:Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
              ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
            top:-10,
            child: Container(
              width:80,
              height:5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue[50],
              ),
            ),
        ),
        Padding(
          padding: EdgeInsets.only(top:30),
          child: Column(
            children: [
              Text(
                'Course No : ' + widget.dept + ' ' + widget.id,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height:30.0),
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
              SizedBox(height:40.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width:3, color:Colors.blueGrey),
                    backgroundColor: Colors.indigo,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  onPressed: (){
                    final docUser = FirebaseFirestore.instance.collection('courses')
                        .doc(widget.dept+' '+widget.id);
                    docUser.update({
                    'teacher': dropDownValue,
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}
