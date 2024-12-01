import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:donate_application/themes/colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0; // Keeps track of the selected tab index

  // This method handles the navigation logic
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Uncomment and replace with your actual navigation logic
    /*
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/donations');
        break;
      case 2:
        Navigator.pushNamed(context, '/notifications');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
    */
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
          tabBackgroundColor: footerbtncolor,
          padding: const EdgeInsets.all(16),
          gap: 8,
          selectedIndex: _selectedIndex, 
          onTabChange: _onTabChange, 
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.volunteer_activism,
              text: 'Donations',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Notifications',
            ),
            GButton(
              icon: Icons.account_box,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
