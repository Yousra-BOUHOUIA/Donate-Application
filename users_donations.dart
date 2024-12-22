import 'package:donate_application/databases/tables/user_donation.dart';
import 'package:flutter/material.dart';
import '../../../imports/common_barrel.dart';
import '../../widgets/footer.dart';
import '../../widgets/main_background.dart';
import '/themes/Colors.dart'; // Ensure this import path is correct



class UsersDonationsScreen extends StatelessWidget {
  static const String pageRoute = '/users_donations';
  final DBUser_donationTable _users_donationsTable = DBUser_donationTable();

  UsersDonationsScreen({super.key});

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
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 4),
              decoration: const BoxDecoration(
                color: appBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _users_donationsTable.getAllRecords(), // Use the correct table for your future
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No records available.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  final records = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                     var imageBytes = record['image'];

                  Widget imageWidget = SizedBox(
                    width: 150, // Fixed width
                    height: 150, // Fixed height
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover, 
                    ),
                  );
                      return buildCard(
                        context,
                        imageBytes,
                        imageWidget,
                        record['title'] ?? 'No title',
                        record['contact'] ?? 'No contact',
                        
                        
                        record['color'] ?? 'No color',
                        record['condition'] ?? 'No condition',
                        record['location'] ?? 'No location',
                        record['username'] ?? 'No username',
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const Footer(isOrganization: true), // Footer widget at the bottom
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context,var imageBytes, Widget imageWidget, String name, String contact, String color, String condition, String location, String username) {
  return GestureDetector(
    onTap: () {
      // Prepare the data to be passed to the ProductDescriptionPage
      final Map<String, dynamic> productDescription = {
        'image':imageBytes,
        'title': name,
        'contact': contact,
        'color': color,
        'condition': condition,
        'location': location,
        'username': username,
      };

      // Navigate to the ProductDescriptionPage and pass the data
      Navigator.pushNamed(
        context,
        ProductDescriptionPage.pageRoute,
        arguments: productDescription,
      );
    },
    child: Card(
      color: Colors.white,
      elevation: 4,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child: imageWidget, // Directly use the passed image widget here
          ),
          Expanded( // Make the container take available space
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 181, 183, 186),
              ),
              child: Padding(
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
                      location,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}