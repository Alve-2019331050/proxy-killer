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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: FutureBuilder(
              future: getDocId(),
              builder: (context,snapshot) {
                return ListView.builder(
                    //itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF001a33),
                          child: Icon(Icons.people_alt_rounded),
                        ),
                        title: GetStudentInfo(documentId : docIDs[index]),
                        tileColor: Colors.blue.shade100,
                      ),
                    );
                },
              );
        }
      ),
    );
  }
}
