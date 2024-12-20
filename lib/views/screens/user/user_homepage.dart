import 'package:flutter/material.dart';
import '../../widgets/user_card.dart';
import '/themes/colors.dart';
import '/views/widgets/event_card.dart'; // Ensure this is imported
import '/views/widgets/footer.dart';
import '/views/widgets/custom_drawer.dart';
import 'package:donate_application/databases/tables/campaign.dart';
import '/imports/user_barrel.dart';

class UserHomePage extends StatelessWidget {
  UserHomePage({super.key});
  static const String pageRoute = '/user_home';
  final DBCampaignTable _campaignTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Sidebar logic
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Tataou3"),
            IconButton(
              onPressed: () {
                // Logo action (optional)
              },
              icon: const Icon(Icons.volunteer_activism),
            ),
          ],
        ),
        backgroundColor: appBackgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: const CustomDrawer(
        profilePicture: 'assets/images/user_profile.png',
        name: 'User Name',
        email: 'email@example.com',
        isOrganization: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Events:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200, // Adjusted for event card
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Updated eventCard function to only show the image
                    eventCard(context, false, 'assets/images/event_picture.jpg'),
                    const SizedBox(width: 16),
                    eventCard(context, false, 'assets/images/event_picture.jpg'),
                    const SizedBox(width: 16),
                    eventCard(context, false, 'assets/images/event_picture.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Categories:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, UserAll.pageRoute);
                      },
                      child: const Chip(
                        label: Text(
                          "All",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: appButtonColor,
                        shape: StadiumBorder(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, UserDonations.pageRoute);
                      },
                      child: const Chip(
                        label: Text(
                          "Donations",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: appButtonColor,
                        shape: StadiumBorder(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, UserEvents.pageRoute);
                      },
                      child: const Chip(
                        label: Text(
                          "Events",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: appButtonColor,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Latest Campaigns:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _campaignTable.getAllRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No campaigns available.');
                  }

                  final campaigns = snapshot.data!;
                  return Column(
                    children: campaigns.map((campaign) {
                      return createUserCard(
                        context,
                        campaign['type'],
                        '', // No title needed
                        campaign['description'] ?? 'No description',
                        'assets/images/org_image.jpg',
                        campaign['resource'] ?? 0,
                        campaign['resource'] ?? 0,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDonationScreen()),
          );
        },
        backgroundColor: appButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const Footer(isOrganization: false),
    );
  }
}
