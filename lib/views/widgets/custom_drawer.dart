import 'package:flutter/material.dart';
import 'package:donate_application/views/screens/organization/org_notifications.dart';
import 'package:donate_application/views/screens/user/user_notification.dart';

class CustomDrawer extends StatelessWidget {
  final String profilePicture; 
  final String name;          
  final String email;         
  final bool isOrganization;   

  const CustomDrawer({
    super.key,
    required this.profilePicture,
    required this.name,
    required this.email,
    this.isOrganization = false,
  });

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
                  _buildMenuItem(context,Icons.home, "Home"),
                  _buildMenuItem(context,Icons.volunteer_activism, "Donations"),
                  _buildMenuItem(context,Icons.event, "Events"),
                  _buildMenuItem(context,Icons.notifications, "Notifications"),
                  _buildMenuItem(context,Icons.person, "Profile"),
                  _buildMenuItem(context,Icons.settings, "Settings"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context , icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: () {
        // Add navigation or action here
        if(title == 'Notifications' && isOrganization==true)
          {Navigator.pushNamed(context, OrgNotification.pageRoute); }
        else if(title == 'Notifications' && isOrganization==false)
            {Navigator.pushNamed(context, UserNotification.pageRoute); }
      },
    );
  }
}
