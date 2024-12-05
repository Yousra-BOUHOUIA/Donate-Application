import 'package:flutter/material.dart';
import 'package:donate_application/views/screens/common/product_des.dart';
import 'package:donate_application/views/widgets/footer.dart';
import 'package:donate_application/views/widgets/main_background.dart';
import 'package:donate_application/themes/Colors.dart'; // Ensure this import path is correct

class UsersDonationsScreen extends StatelessWidget {
  static const String pageRoute = '/users_donations';

  UsersDonationsScreen({super.key});

  final List<Map<String, String>> cardData = [
    {
      'image': 'assets/images/headphones_image.avif',
      'name': 'Headphones',
      'contact': '987-654-3210',
      'address': '5678 Oak St',
      'date': '2024-10-15',
    },
    {
      'image': 'assets/images/desk_image.jpg',
      'name': 'Desk',
      'contact': '123-456-7890',
      'address': '1234 Elm St',
      'date': '2024-11-29',
    },
    {
      'image': 'assets/images/table_image.avif',
      'name': 'Table',
      'contact': '555-123-4567',
      'address': '9876 Pine St',
      'date': '2024-09-12',
    },
    {
      'image': 'assets/images/pc_image.jpg',
      'name': 'PC',
      'contact': '444-555-6666',
      'address': '3456 Maple St',
      'date': '2024-08-22',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GradientPage(
      gradientStartColor: topGradientStart, // Add your gradient start color here
      gradientEndColor: topGradientEnd, // Add your gradient end color here
      pageTitle: "Details",
      child: Column(
        children: [
          Expanded(
            child: Container(
            padding: const EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 4),
            decoration: const BoxDecoration(
              color: appBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: cardData.length,
                itemBuilder: (context, index) {
                  final card = cardData[index];
                  return buildCard(
                    context,
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
          const Footer(isOrganization: true,), // Footer widget at the bottom
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, String imagePath, String name, String contact, String address, String date) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDescriptionPage.pageRoute);
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
