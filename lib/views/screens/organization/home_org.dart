import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/org_card.dart';
import '/views/widgets/event_card.dart';
import '/views/widgets/footer.dart';
import '/views/widgets/custom_drawer.dart';

import '/imports/organization_barrel.dart';
import '/imports/user_barrel.dart';

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
                Navigator.pushNamed(context, '/home'); // Navigate to home page
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
                    eventCard(context, true, 'Event 1 Description', 'assets/images/event_picture.jpg', '10'),
                    const SizedBox(width: 16),
                    eventCard(context, true, 'Event 2 Description', 'assets/images/event_picture.jpg', '20'),
                    const SizedBox(width: 16),
                    eventCard(context, true, 'Event 3 Description', 'assets/images/event_picture.jpg', '30'),
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
              createCard(
                context,
                false,
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
          _showPostOptions(context);
        },
        backgroundColor: appButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const Footer(isOrganization: true),
    );
  }

  // Function to show options for "Event" or "Donate"
  static void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Create Post",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                     // Navigator.pushNamed(context, 'add the form page');
                    },
                    icon: const Icon(Icons.event, color: Colors.white),
                    label: const Text("Event", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appButtonColor,
                      minimumSize: const Size(120, 50), 
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      //Navigator.pushNamed(context, 'add the form page');
                    },
                    icon: const Icon(Icons.volunteer_activism, color: Colors.white),
                    label: const Text("Donate", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appButtonColor,
                      minimumSize: const Size(120, 50), 
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
