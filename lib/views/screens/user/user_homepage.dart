import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/user_card.dart';
import '/views/widgets/event_card.dart';
import '/views/widgets/footer.dart';
import '/views/widgets/custom_drawer.dart';

import '/imports/user_barrel.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});
  static const String pageRoute = '/user_home';

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
                    eventCard(context, false, 'Event 1 Description', 'assets/images/event_picture.jpg', '10'),
                    const SizedBox(width: 16),
                    eventCard(context, false, 'Event 2 Description', 'assets/images/event_picture.jpg', '20'),
                    const SizedBox(width: 16),
                    eventCard(context, false, 'Event 3 Description', 'assets/images/event_picture.jpg', '30'),
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
              createUserCard(
                context,
                false,
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
