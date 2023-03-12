import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class showAttendance extends StatefulWidget {
  String course;

  showAttendance({required this.course});

  @override
  State<showAttendance> createState() => _showAttendanceState();
}

class _showAttendanceState extends State<showAttendance> {
  String registration_no = "";
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  int totClass = 1, appeared = 1;

  Future getReg() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snapshot) => {
              setState(() {
                registration_no = snapshot['registration number'];
              })
            });
  }

  Future getData() async {
    var ref = await FirebaseFirestore.instance
        .collection('classes')
        .where('course', isEqualTo: widget.course)
        .get();
    setState(() {
      totClass = ref.docs.length;
    });
    return ref;
  }

  Future getAttendance() async {
    var ref = await FirebaseFirestore.instance
        .collection('attendance')
        .where('course', isEqualTo: widget.course)
        .where('registration no', isEqualTo: registration_no)
        .get();
    setState(() {
      appeared = ref.docs.length;
    });
    return ref;
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    String hour = data['hour'];
    while(hour.length<2) hour = '0'+hour;
    String minute = data['minute'];
    while(minute.length<2) minute = '0'+minute;
    return DataRow(cells: [
      DataCell(Text(
        data['day']+' / '+data['month'],
        style: TextStyle(
          color: Color(0xFF001a33),
          fontSize: 19,
        ),
      )),
      DataCell(Text(
        hour + ' : ' + minute+' '+data['period'],
        style: TextStyle(
          color: Color(0xFF001a33),
          fontSize: 19,
        ),
      )),
    ]);
  }

  @override
  void initState() {
    super.initState();
    getReg();
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
        body: Padding(
          padding: EdgeInsets.only(
            top: 1,
          ),
          child: Column(
            children: [
              Text(
                widget.course,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001a33),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 25),
                  FutureBuilder(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          totClass = snapshot.data!.docs.length;
                          return Card(
                            color: Color(0xFF001a33),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2.0,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    SizedBox(height: 3),
                                    FittedBox(
                                      child: Text(
                                        'Total Class',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    FittedBox(
                                      child: Text(
                                        snapshot.data!.docs.length.toString(),
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else
                          return Container();
                      }),
                  SizedBox(width: 10),
                  FutureBuilder(
                      future: getAttendance(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          appeared = snapshot.data!.docs.length;
                          return Card(
                            color: Color(0xFF001a33),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2.0,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    SizedBox(height: 3),
                                    FittedBox(
                                      child: Text(
                                        'Appeared',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    FittedBox(
                                      child: Text(
                                        snapshot.data!.docs.length.toString(),
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else
                          return Container();
                      }),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: FutureBuilder(
                    future: Future.wait([getData(), getAttendance()]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          radius: 100,
                          lineWidth: 30,
                          percent: appeared / totClass,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.shade200,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                              (appeared /
                                          ((totClass == 0) ? 1 : totClass) *
                                          100)
                                      .toInt()
                                      .toString() +
                                  '%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Color(0xFF001a33),
                              )),
                        );
                      } else
                        return Container();
                    }),
              ),
              SizedBox(height: 20),
              Divider(
                color: Color(0xFF001a33),
                thickness: 3,
                height: 20,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: getAttendance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001a33),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001a33),
                                ),
                              ),
                            ),
                          ],
                          rows: _buildList(context, snapshot.data!.docs),
                        );
                      } else
                        return Container(child: Center(child: Text('No Data')));
                    }),
              ),
            ],
          ),
        ));
  }
}
