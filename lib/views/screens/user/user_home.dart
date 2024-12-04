import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'user_card.dart';
import 'event_card.dart';


class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Sidebar logic
          },
          icon: const Icon(Icons.menu),
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
                    eventCard('Event 1 Description', 'lib/assets/images/event_picture.jpg', '10'),
                    const SizedBox(width: 16),
                    eventCard('Event 2 Description', 'lib/assets/images/event_picture.jpg', '20'),
                    const SizedBox(width: 16),
                    eventCard('Event 3 Description', 'lib/assets/images/event_picture.jpg', '30'),
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
              createCard(
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'lib/assets/images/user_image.jpg',
                120,
                200,
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}
