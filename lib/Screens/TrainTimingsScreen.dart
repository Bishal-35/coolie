import 'package:flutter/material.dart';

class TrainTimingsScreen extends StatelessWidget {
  final String stationName;

  const TrainTimingsScreen({super.key, required this.stationName});

  @override
  Widget build(BuildContext context) {
    // Sample data based on your screenshot
    final upTrains = [
      ['58201 (BSP-R)', '08:55'],
      ['58203 (GAD – R PASS)', '12:38'],
      ['68862 (JSG – G MEMU)', '16:25'],
      ['68719 (BSP – R MEMU)', '18:26'],
      ['68727 (BSP – R MEMU)', '20:29'],
      ['-', '-'],
    ];

    final downTrains = [
      ['18110 (NITR – TATA EXP)', '06:00'],
      ['68728 (R – BSP MEMU)', '07:17'],
      ['68861 (G – JSG MEMU)', '09:33'],
      ['68706 (DGG – BSP MEMU)', '15:17'],
      ['58204 (R – KRBA PASS)', '18:44'],
      ['58202 (R – BSP PASS)', '19:34'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Train Timings for $stationName Station'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Number of Trains stop at station :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('(a) UP Direction (Towards NGP Side) : 05'),
            const Text('(b) DN Direction (Towards HWH Side) : 06'),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: Colors.grey.shade400),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('UP Trains Numbers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Departure Time',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('DN Trains Numbers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Departure Time',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown)),
                    ),
                  ],
                ),
                for (int i = 0; i < upTrains.length; i++)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(upTrains[i][0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(upTrains[i][1]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(downTrains[i][0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(downTrains[i][1]),
                      ),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
