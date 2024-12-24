
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../imports/user_barrel.dart';
import '../../imports/organization_barrel.dart';




class CustomDrawer extends StatelessWidget {
  //final String profilePicture; 
  final Uint8List? profilePicture;
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
                  /*CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profilePicture),
                  ),*/
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: profilePicture != null
                        ? MemoryImage(profilePicture!) // Use binary data
                        : null,
                    child: profilePicture == null
                        ? const Icon(Icons.person) // Fallback icon
                        : null,
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
        if(title == 'Home')
        {
          if(isOrganization==true)
          {
            Navigator.pushNamed(context, OrgHomePage.pageRoute);
          }
          else{
            Navigator.pushNamed(context, UserHomePage.pageRoute);
          }
        }
        else if(title == 'Donations')
        {
          if(isOrganization==true)
          {
            Navigator.pushNamed(context, DonationsPage.pageRoute);
          }
          else{
            Navigator.pushNamed(context, UserDonations.pageRoute);
          }
        }
         else if(title == 'Events')
        {
          if(isOrganization==true)
          {
            Navigator.pushNamed(context, EventsPage.pageRoute);
          }
          else{
            Navigator.pushNamed(context, UserEvents.pageRoute);
          }
        }
         else if(title == 'Notifications')
        {
          if(isOrganization==true)
          {
            Navigator.pushNamed(context, OrgNotification.pageRoute);
          }
          else{
            Navigator.pushNamed(context, UserNotification.pageRoute);
          }
        }
         else if(title == 'Settings')
        {
          if(isOrganization==true)
          {
            Navigator.pushNamed(context, OrgProfilePage.pageRoute);
          }
          else{
            Navigator.pushNamed(context, UserProfilePage.pageRoute);
          }
        }
         else if(title == 'Profile')
        {
          if(isOrganization==true)
          {
            Navigator.pushNamed(context, OrgProfileDetailsScreen.pageRoute);
          }
          else{
            Navigator.pushNamed(context, UserProfileDetailsScreen.pageRoute);
          }
        }
        
        
      }, 
    );
  }
}
