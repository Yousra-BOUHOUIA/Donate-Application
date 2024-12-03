import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String profilePicture; 
  final String name;          
  final String email;         
  final bool isOrganization;   

  const CustomDrawer({
    Key? key,
    required this.profilePicture,
    required this.name,
    required this.email,
    this.isOrganization = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF8F6F6), // Set background color
        child: Column(
          children: [
            // Profile Header
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white, // Keep white for header background
              ),
              child: Row(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profilePicture),
                  ),
                  const SizedBox(width: 10),
                  // Name and Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Options
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.home, "Home"),
                  _buildMenuItem(Icons.volunteer_activism, "Donations"),
                  _buildMenuItem(Icons.event, "Events"),
                  _buildMenuItem(Icons.notifications, "Notifications"),
                  _buildMenuItem(Icons.person, "Profile"),
                  _buildMenuItem(Icons.settings, "Settings"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: () {
        // Add navigation or action here
      },
    );
  }
}
