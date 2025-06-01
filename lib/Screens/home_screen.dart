import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rail_sahayak/Screens/TrainTimingsScreen.dart';
import 'package:rail_sahayak/Screens/amenities.dart';
import 'package:rail_sahayak/Screens/book_coolie.dart';
import 'package:rail_sahayak/Screens/food_services.dart';
import 'package:rail_sahayak/Screens/login_screen.dart';
import 'package:rail_sahayak/Screens/on_duty_staff_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedStation = 'Select Station';
  final List<String> stations = ['Raipur', 'Durg'];

  void _bookTrain() async {
    final Uri url = Uri.parse('https://www.irctc.co.in/nget/train-search');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch IRCTC");
    }
  }

  void _bookRetiringRoom() async {
    final Uri url = Uri.parse('https://www.rr.irctc.co.in/home');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch IRCTC");
    }
  }

  void _trainRunningInfo() async {
    final Uri url = Uri.parse('https://enquiry.indianrail.gov.in/mntes/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch IRCTC");
    }
  }

  void _passengerAmenities() async {
    if (selectedStation != 'Select Station') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AmenitiesScreen(stationName: selectedStation),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a station first")),
      );
    }
  }

  void _trainTimings() async {
    if (selectedStation != 'Select Station') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TrainTimingsScreen(stationName: selectedStation),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a station first")),
      );
    }
  }

  void _ondutystaff() async {
    if (selectedStation != 'Select Station') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OnDutyStaffScreen(stationName: selectedStation),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a station first")),
      );
    }
  }

  Widget buildServiceCard(String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.white, // 👈 Add your desired background color here
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.redAccent, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    ),
  );
}

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: children,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F0),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Text('RailSahayak Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.currency_rupee),
              title: const Text('Pricing'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancellation'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.train, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('RailSahayak', style: TextStyle(color: Colors.black)),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text("Welcome to", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const Text("RailSahayak", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 8),
            const Text(
              "Your one-stop solution for all railway station services. Book, explore, and get assistance with ease.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedStation == 'Select Station' ? null : selectedStation,
              hint: const Text('Select Station'),
              isExpanded: true,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedStation = newValue;
                  });
                }
              },
              items: stations.map<DropdownMenuItem<String>>((String station) {
                return DropdownMenuItem<String>(
                  value: station,
                  child: Text(station),
                );
              }).toList(),
            ),

            /// Section 1 - Services at Your Station
            buildSection("Our Services", [
              buildServiceCard("Book a Coolie", Icons.luggage, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BookCoolie()));
              }),
              buildServiceCard("4-Wheel Chair", Icons.accessible, () {}),
              buildServiceCard("4-Wheel Cart", Icons.electric_rickshaw, () {}),
              buildServiceCard("Retiring Room",  Icons.hotel, _bookRetiringRoom),
              buildServiceCard("Food Services",  Icons.restaurant, () { Navigator.push(context, MaterialPageRoute(builder: (_) => FoodServices()));}),
              buildServiceCard("Shop & Enjoy", Icons.shopping_bag, () {}),
              buildServiceCard("Baby Care",  Icons.child_care, () {}),
              buildServiceCard("Passenger Help", Icons.person,_ondutystaff),
              buildServiceCard("More Services",  Icons.more_horiz, () {}),
            ]),

            /// Section 2 - Station Guide
            buildSection("Station Guide", [
              buildServiceCard("Amenities",  Icons.info, _passengerAmenities),
              buildServiceCard("Duty Staff",  Icons.group, _ondutystaff),
              buildServiceCard("Guide Map",  Icons.map, () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coming Soon")));
              }),
              buildServiceCard("Train Timings",  Icons.access_time, _trainTimings),
              buildServiceCard("Other Info",  Icons.info_outline, () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coming Soon")));
              }),
            ]),

            /// Section 3 - Travel Services
            buildSection("Travel Services", [
              buildServiceCard("Train Tickets", Icons.train, _bookTrain),
              buildServiceCard("Retiring Room",  Icons.hotel, _bookRetiringRoom),
              buildServiceCard("Running Info",  Icons.directions_railway, _trainRunningInfo),
            ]),
          ],
        ),
      ),
    );
  }
}
