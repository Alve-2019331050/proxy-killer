import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'get_student_info.dart';

class enrollStudent extends StatefulWidget {

  String dept,id;
  enrollStudent({required this.dept,required this.id});
  @override
  State<enrollStudent> createState() => _enrollStudentState();
}

class _enrollStudentState extends State<enrollStudent> {

  final user = FirebaseAuth.instance.currentUser!;

  //document IDs
  List<String> docIDs = [];
  
  //get docIDs
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('users').get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        })
    );
  }

  //keeps selected student here or do whatever you want (for Alve)
  List<String> selectedStudent =  [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF001a33),
        title: Text(
          'Registered Students',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                      future: getDocId(),
                      builder: (context,snapshot) {
                        return ListView.builder(
                            //itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Card(
                                  shape : const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0xFF001a33),
                                      child: Icon(Icons.people_alt_rounded),

                                    ),
                                    shape : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))
                                    ),
                                    //for alve : this is the listener for inkwell.
                                    onTap: (){
                                      setState(() {

                                      });
                                    },
                                    title: GetStudentInfo(documentId : docIDs[index]),
                                    tileColor: Colors.blue.shade100,
                                    trailing: Container(
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF001a33),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          //for alve : use a conditional here to convert add to remove and vice versa
                                          'Add',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                        },
                      );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
