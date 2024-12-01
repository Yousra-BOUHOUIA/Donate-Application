import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';

class UsersDonationsScreen extends StatelessWidget {
  UsersDonationsScreen({super.key});

  final List<Map<String, String>> cardData = [
    {
      'image': 'project/assets/desk.jpg',
      'name': 'Desk',
      'contact': '123-456-7890',
      'address': '1234 Elm St',
      'date': '2024-11-29',
    },
    {
      'image': 'project/assets/headphone.jpg',
      'name': 'Headphones',
      'contact': '987-654-3210',
      'address': '5678 Oak St',
      'date': '2024-10-15',
    },
    {
      'image': 'project/assets/table.jpg',
      'name': 'Table',
      'contact': '555-123-4567',
      'address': '9876 Pine St',
      'date': '2024-09-12',
    },
    {
      'image': 'project/assets/pc.jpg',
      'name': 'PC',
      'contact': '444-555-6666',
      'address': '3456 Maple St',
      'date': '2024-08-22',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Users Donations',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
          ),
        ),
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: const Color(0x00f8f6f6),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 3 / 4,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: cardData.length,
                itemBuilder: (context, index) {
                  final card = cardData[index];

                  return buildCard(
                    card['image']!,
                    card['name']!,
                    card['contact']!,
                    card['address']!,
                    card['date']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String imagePath, String name, String contact, String address, String date) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double halfHeight = constraints.maxHeight * 0.65;

          return Column(
            children: [
              // Temporary solution: Replacing the image with a black container
              Container(
                height: halfHeight,
                width: double.infinity,
                color: Colors.black,  // Black container instead of an image
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.person, size: 18),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact,
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              address,
                              style: const TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              date,
                              style: const TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
