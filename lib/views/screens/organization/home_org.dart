import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/views/widgets/org_card.dart';
import 'package:donate_application/views/widgets/event_card.dart';
import 'package:donate_application/views/widgets/footer.dart';
import 'package:donate_application/views/widgets/custom_drawer.dart';
import 'package:donate_application/views/screens/organization/users_donations.dart';

import 'package:donate_application/views/screens/organization/organization_all.dart';
import 'package:donate_application/views/screens/organization/organization_donations.dart';
import 'package:donate_application/views/screens/organization/organization_events.dart';

class OrgHomePage extends StatelessWidget {
     const OrgHomePage({super.key});
     static const String pageRoute = '/org_home';

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
      drawer: const CustomDrawer(
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                     InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, CardContentPage.pageRoute);
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
                              Navigator.pushNamed(context, DonationsPage.pageRoute);
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
                              Navigator.pushNamed(context, EventsPage.pageRoute);
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
                    const SizedBox(width: 16),
                    // linking the users donation button to the corresponding page
                    InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, UsersDonationsScreen.pageRoute);
                            },
                            child: const Chip(
                              label: Text(
                                "User Donation",
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
              createCard(context,
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
      bottomNavigationBar: const Footer(isOrganization: true,),
    );
  }
}
