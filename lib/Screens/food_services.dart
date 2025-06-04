import 'package:flutter/material.dart';

class FoodStall {
  final String stallNumber;
  final String shopName;
  final String ownerName;
  final String phoneNumber;
  final String platformNumber;
  final String nearPoleNumber;

  FoodStall({
    required this.stallNumber,
    required this.shopName,
    required this.ownerName,
    required this.phoneNumber,
    required this.platformNumber,
    required this.nearPoleNumber,
  });
}

class FoodServices extends StatelessWidget {
  const FoodServices({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample food stall data
    final List<FoodStall> foodStalls = [
      FoodStall(
        stallNumber: "A001",
        shopName: "Railway Delights",
        ownerName: "Rahul Sharma",
        phoneNumber: "+91 9876543210",
        platformNumber: "2",
        nearPoleNumber: "P-15",
      ),
      FoodStall(
        stallNumber: "B002",
        shopName: "Spice Express",
        ownerName: "Priya Patel",
        phoneNumber: "+91 8765432109",
        platformNumber: "1",
        nearPoleNumber: "P-08",
      ),
      FoodStall(
        stallNumber: "C003",
        shopName: "Platform Bites",
        ownerName: "Amit Singh",
        phoneNumber: "+91 7654321098",
        platformNumber: "3",
        nearPoleNumber: "P-22",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Food Services')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Food Stalls',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...foodStalls.map((stall) => _buildFoodStallCard(stall)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodStallCard(FoodStall stall) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stall.shopName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Stall #${stall.stallNumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.person, 'Owner: ${stall.ownerName}'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.phone, stall.phoneNumber),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.train, 'Platform: ${stall.platformNumber}'),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.location_on,
              'Near Pole: ${stall.nearPoleNumber}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
