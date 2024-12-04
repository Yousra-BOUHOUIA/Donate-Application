import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
Widget createCard(String title, String description, String image,
      int volunteers, int totalVolunteers) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Recruited Volunteers: $volunteers / $totalVolunteers',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: volunteers / totalVolunteers,
              backgroundColor: Colors.grey[300],
              color: appButtonColor,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                onPressed: () {
                  // Details button logic
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0E1F2F)), // Blue border
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(
                    color: Color(0xFF0E1F2F), 
                  ),
                ),
              ),
              ],
            ),
          ],
        ),
      ),
    );
}
