import 'package:flutter/material.dart';

class AmenitiesScreen extends StatefulWidget {
  final String stationName;

  const AmenitiesScreen({Key? key, required this.stationName})
      : super(key: key);

  @override
  State<AmenitiesScreen> createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  late Map<String, String> amenityDescriptions;

 final Map<String, String> raipurAmenities = {
  "FOOT OVER BRIDGE BSP END": "COLUMN NO. 07-08",
  "RAIL MAIL SERVICE": "COLUMN NO. 09-11",
  "Dy STATION SUPERINTENDENT": "COLUMN NO.11-12",
  "STATION MANAGER": "COLUMN NO. 12-13",
  "Wheel Chair, Ramp, Stretcher": "04-WHEEL CHAIR, 1- RAMP, 1- STRETCHER",
  "CHIEF TICKET INSPECTOR STATION": "COLUMN NO. 12-13",
  "VIP- LOUNGE": "COLUMN NO-13-14",
  "ATVM": "ENTRANCE OF VIP GATE",
  "RETIRING ROOM (03 NOS AC, 02 NOS NONAC)": "UPSTAIRS COLUMN NO 15-16",
  "DORMITORY (08 BEDS)": "UPSTAIRS COLUMN NO 15-16",
  "UPPER CLASS WAITING GENTS": "COLUMN NO. 17-18",
  "UPPER CLASS WAITING LADIES": "COLUMN NO. 17-18",
  "SECOND CLASS WAITING HALL GENTS": "COLUMN NO. 19-20",
  "SECOND CLASS WAITING HALL LADIES": "COLUMN NO.18-19",
  "PAY & USE TOILET": "ALL WAITING HALL",
  "FOOT OVER BRIDGE NEAR GATE NO 02": "COLUMN NO. 18-19",
  "LIFT (03 NOS)": "01 NEAR GATE NO.02 COLUMN 21-22, 02 FOB AT PF 02/03, 03 FOB AT PF 05/06",
  "SAHYOG COUNTER": "GATE NO-02",
  "ATM (SBI, PNB, BOB) 03 NOS": "NEAR BOOKING COUNTER",
  "CLOAK ROOM": "COLUMN NO. 23",
  "FOOT OVER BRIDGE NEW": "COLUMN NO. 24-25",
  "AKSHITA (ONLY FOR LADIES)": "COLUMN NO. 30-31",
  "OPEN WAITING AREA GENTS": "COLUMN NO. 31-32",
  "FOOT OVER BRIDGE DURG END": "COLUMN NO. 34-35",
  "ATVM 02 NOS": "COLUMN NO. 41-42",
  "BATTERY OPERATED CAR FOR DIVYANG SENIOR CITIZEN 01 NOS": "STANDING NEAR GATE NO.2",
  "AC DORMITORY (14 BEDS)": "UP STAIRS PRS BUILDING",
  "PARCEL OFFICE OUTSIDE PLATFORM MAIN SIDE": "IN FRONT OF EXIT GATE OF PF 1A",
  "PRS BUILDING": "NEAR TWO WHEELER PARKING",
  "TWO WHEELER PARKING": "NEAR ENTRANCE OF STATION AREA GURUDWARA SIDE",
  "FOUR WHEELER PARKING": "IN FRONT OF STATION BUILDING GATE NO 02",
  "FOUR WHEELER PARKING (PREMIUM)": "IN FRONT OF VIP GATE, GATE NO. 01",
  "ESCALATOR UPWARD AND DOWNWARD": "01 NOSOUT SIDE GATE NO 02 01 NOS PF 07 GUDIYARI SIDE",
};


  final Map<String, String> durgAmenities = {
  "RAIL MAIL SERVICE": "AT PF-01 NEAR POLE NO-",
  "Dy STATION SUPERINTENDENT": "AT PF-01 NEAR POLE NO-25",
  "STATION MANAGER": "AT PF-01 NEAR POLE NO-24",
  "04-WHEEL CHAIR, 1- RAMP, 1- STRECHER AT ENQUIRY OFFICE": "AT PF-01 NEAR POLE NO-26",
  "CHIEF TICKET INSPECTOR STATION": "AT PF-01 NEAR POLE NO-25",
  "VIP- LOUNGE": "AT PF-01 NEAR POLE NO-24 & 25",
  "ATVM": "AT CONCOURSE AREA",
  "RETIRING ROOM (02 No. AC, 07 No. NON AC)": "AT 1ST FLOOR OF THE STATION BUILDING",
  "DORMITORY (02 BEDS)": "AT 1ST FLOOR OF THE STATION BUILDING",
  "UPPER CLASS WAITING GENTS": "AT 1ST FLOOR OF THE STATION BUILDING",
  "UPPER CLASS WAITING LADIES": "AT 1ST FLOOR OF THE STATION BUILDING",
  "SECOND CLASS WAITING HALL": "AT PF-01 NEAR POLE NO-28",
  "BATTERY OPERATED CAR FOR DIVYANG SENIOR CITIZEN 01 NOS":
      "NEAR EXIT GATE BEHIND STATION MODEL IN CONCOURSE AREA",
  "PARCEL OFFICE OUT SIDE PLATFORM MAIN SIDE":
      "AT NGP END OF THE STATION BUILDING",
  "TWO WHEELER PARKING": "NEAR ENTRANCE AND EXIT GATE OF THE STATION",
  "TWO WHEELER PARKING (PREMIUM)":
      "IN CIRCULATING AREA BEHIND BOOKING OFFICE BUILDING",
  "FOUR WHEELER PARKING": "NEAR ENTRANCE AND EXIT GATE OF THE STATION",
  "FOUR WHEELER PARKING (PREMIUM)":
      "IN CIRCULATING AREA BEHIND THE EXIT OF THE STATION BUILDING",
};


  @override
  void initState() {
    super.initState();
    if (widget.stationName.toLowerCase() == 'raipur') {
      amenityDescriptions = raipurAmenities;
    } else if (widget.stationName.toLowerCase() == 'durg') {
      amenityDescriptions = durgAmenities;
    } else {
      amenityDescriptions = {}; // Default empty for unknown station
    }
  }

  void _showAmenityDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFFDE7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titles = amenityDescriptions.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Passenger Amenities at ${widget.stationName} Station"),
        backgroundColor: Colors.redAccent,
      ),
      body: amenityDescriptions.isEmpty
          ? const Center(child: Text("No data available for this station"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5,
                children: titles.map((title) {
                  return GestureDetector(
                    onTap: () =>
                        _showAmenityDialog(title, amenityDescriptions[title]!),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.brown.shade200),
                      ),
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
