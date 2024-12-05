import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/views/screens/user/user_event_description.dart';

Widget createCard(BuildContext context,String title, String description, String image, int volunteers, int totalVolunteers) {
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
                  image, // Use local asset
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
                  Navigator.pushNamed(context, UserEventDescriptionScreen.pageRoute); 
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
              ElevatedButton(
                onPressed: () {
                  // Participate Now button logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27425D),
                ),
                child: const Text(
                  'Participate Now',
                  style: TextStyle(
                    color: Colors.white, 
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ); // This closes the Card widget properly
}
