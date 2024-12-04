import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/views/widgets/org_card.dart';
import 'package:donate_application/views/widgets/event_card.dart';
import 'package:donate_application/views/widgets/footer.dart';
import 'package:donate_application/views/widgets/custom_drawer.dart';

class OrgHomePage extends StatelessWidget {
  const OrgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open sidebar
            },
            icon: const Icon(Icons.menu),
          ),
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
      drawer: CustomDrawer(
        profilePicture: 'assets/images/org_profile.jpg', // Replace with actual URL or asset
        name: 'Organization Name',
        email: 'email@example.com',
        isOrganization: true,
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
                    eventCard('Event 1 Description', 'assets/images/event_picture.jpg', '10'),
                    const SizedBox(width: 16),
                    eventCard('Event 2 Description', 'assets/images/event_picture.jpg', '20'),
                    const SizedBox(width: 16),
                    eventCard('Event 3 Description', 'assets/images/event_picture.jpg', '30'),
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
                  children: const [
                    Chip(
                      label: Text("All", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: 16),
                    Chip(
                      label: Text("Donations", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: 16),
                    Chip(
                      label: Text("Events", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: 16),
                    Chip(
                      label: Text("Get Donation", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
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
              createCard(
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'assets/images/org_image.jpg',
                120,
                200,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add post logic
        },
        backgroundColor: appButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const Footer(),
    );
  }
}
