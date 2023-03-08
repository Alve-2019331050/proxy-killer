import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetStudentInfo extends StatelessWidget {
  final String documentId;


  const GetStudentInfo({required this.documentId});

  @override
  Widget build(BuildContext context) {

    //get the Collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
            Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
            return Text(
              ' ${data['registration number']}\n ${data['name']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            );

        }
        return Text('loading');
      }),
    );
  }
}
