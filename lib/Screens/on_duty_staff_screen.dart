import 'package:flutter/material.dart';

class OnDutyStaffScreen extends StatelessWidget {
  final String stationName;

  const OnDutyStaffScreen({super.key, required this.stationName});

  List<List<String>> getStaffData(String station) {
    if (station.toLowerCase() == 'raipur') {
      return [
        ['Shri R P Mandal', 'Chief Station Manager', '9752877088'],
        ['Shri S. Bala', 'Station Manager', '97525 96048'],
        ['Shri N. K Sahu', 'Station Manger', '80859 53413'],
        ['Shri N. K. Thakur', 'Station Manger', '98932 82944'],
        ['Shri Amar Kumar Phutane (Incharge)', 'Station Suptd.(Commercial)', '9109112682'],
        ['Shri Satyendra Singh', 'Station Suptd.(Commercial)', '9752877990'],
        ['Shri Artta Trana Jena', 'Divisional Chief Ticket Inspector', '9179032799'],
        ['Shri B. C. Alda', 'Chief Ticket Inspector', '9179043964'],
      ];
    } else if (station.toLowerCase() == 'durg') {
      return [
        ['Shri Lakhbeer Singh Munghera', 'Chief Station Manager', '97528 77068'],
        ['Shri S. K. Dubey', 'Station Manager', '7566556687'],
        ['Shri T. Jaipal', 'Dy. Station Manger', '9752596063'],
        ['Shri Manoj Kumar', 'Station Manger', '9752096157'],
        ['Shri Shankar Kumar Choudhary', 'Dy. Station Manger', '9098122312'],
        ['Shri Pramod Sharma', 'Station Suptd.(Commercial)', '9109112682'],
        ['Shri A. K. Sharma (Station)', 'Chief Ticket Inspector', '91790 34585'],
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final staffData = getStaffData(stationName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Staff at $stationName Station'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FixedColumnWidth(40),
            1: FixedColumnWidth(200),
            2: FixedColumnWidth(200),
            3: FixedColumnWidth(150),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Colors.grey),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('S.No', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Name of Staff', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Designation', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Mobile No.', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            for (int i = 0; i < staffData.length; i++)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${i + 1}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(staffData[i][0]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(staffData[i][1]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(staffData[i][2]),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
