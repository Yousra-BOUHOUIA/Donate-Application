import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/views/widgets/user_card.dart';
import 'package:donate_application/views/widgets/event_card.dart';
import 'package:donate_application/views/widgets/footer.dart';
import 'package:donate_application/views/widgets/custom_drawer.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

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
        profilePicture: 'assets/images/user_profile.jpg', // Replace with actual URL or asset
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
                height: cardHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    eventCard(context,'Event 1 Description', 'assets/images/event_picture.jpg', '10'),
                    const SizedBox(width: 16),
                    eventCard(context,'Event 2 Description', 'assets/images/event_picture.jpg', '20'),
                    const SizedBox(width: 16),
                    eventCard(context,'Event 3 Description', 'assets/images/event_picture.jpg', '30'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Categories:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Chip(
                      label: Text("All", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: chipSpacing),
                    Chip(
                      label: Text("Donations", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: chipSpacing),
                    Chip(
                      label: Text("Events", style: TextStyle(color: Colors.white)),
                      backgroundColor: appButtonColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(width: chipSpacing),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Latest Campaigns:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              createCard(context,
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'assets/images/user_image.jpg',
                120,
                200,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
