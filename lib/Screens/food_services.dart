import 'package:flutter/material.dart';

class FoodServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Services'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/food1.png'), // Rename appropriately
            SizedBox(height: 10),
            Image.asset('assets/images/food2.png'),
            SizedBox(height: 10),
            Image.asset('assets/images/food3.png'),
          ],
        ),
      ),
    );
  }
}
