import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class showResult extends StatefulWidget {
  String dropDownValue;
  DateTime dateTime;
  showResult({required this.dropDownValue, required this.dateTime});
  @override
  State<showResult> createState() => _showResultState();
}

class _showResultState extends State<showResult> {
  Future getAttendance() async {
    var data = await FirebaseFirestore.instance
        .collection("attendance")
        .where('course', isEqualTo: widget.dropDownValue)
        .where('month', isEqualTo: widget.dateTime.month.toString())
        .where('day', isEqualTo: widget.dateTime.day.toString())
        .get();
    // print(data.docs);
    return data.docs;
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
        hour + ' : ' + minute+' '+data['period'],
        style: TextStyle(
          color: Color(0xFF001a33),
          fontSize: 19,
        ),
      )),
      DataCell(Text(
        data['registration no'],
        style: TextStyle(
          color: Color(0xFF001a33),
          fontSize: 19,
        ),
      )),
    ]);
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 35, top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Text(
                'Attendance Result',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001a33),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height:15),
              FutureBuilder(
                  future: getAttendance(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DataTable(
                        columns: [
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
                          DataColumn(
                            label: Text(
                              'Reg. No.',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF001a33),
                              ),
                            ),
                          ),
                        ],
                        rows: _buildList(context, snapshot.data),
                      );
                    } else
                      return Container(child: Text('No Data'));
                  }),
            ]),
          ),
        ),
      ),
    );
    ;
  }
}
