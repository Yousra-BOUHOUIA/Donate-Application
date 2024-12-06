import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


import '/imports/organization_barrel.dart';
import '/imports/user_barrel.dart';


class Footer extends StatefulWidget {
  final bool isOrganization;

  const Footer({super.key, required this.isOrganization});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int? _selectedIndex; // Keeps track of the selected tab index (null means no tab selected)


  


  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (widget.isOrganization) {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, OrgHomePage.pageRoute);
          break;
        case 1:
          Navigator.pushNamed(context, DonationsPage.pageRoute);
          break;
        case 2:
          Navigator.pushNamed(context, OrgNotification.pageRoute);
          break;
        case 3:
          Navigator.pushNamed(context, OrgProfileDetailsScreen.pageRoute);
          break;
      }
    } else {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, UserHomePage.pageRoute);
          break;
        case 1:
          Navigator.pushNamed(context, UserDonations.pageRoute);
          break;
        case 2:
          Navigator.pushNamed(context, UserNotification.pageRoute);
          break;
        case 3:
          Navigator.pushNamed(context, UserProfileDetailsScreen.pageRoute);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.black,
          
          padding: const EdgeInsets.all(16),
          gap: 8,
          selectedIndex: _selectedIndex ?? -1, // Highlights the active tab or none if null
          onTabChange: _onTabChange,
          tabs: const [
            GButton(
              icon: Icons.home,
              
            ),
            GButton(
              icon: Icons.volunteer_activism,
             
            ),
            GButton(
              icon: Icons.notifications,
              
            ),
            GButton(
              icon: Icons.account_box,
              
            ),
          ],
        ),
      ),
    );
  }
}
