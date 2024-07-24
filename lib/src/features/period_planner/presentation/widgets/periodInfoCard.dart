import 'package:flutter/material.dart';

class PeriodInfoCard extends StatelessWidget {
  PeriodInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[50], // Set the card color to match the previous container color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4, // Adjust the elevation to add shadow to the card
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Period',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Day 5',
              style: TextStyle(fontSize: 38, color: Colors.pink, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Low chance of getting pregnant',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
