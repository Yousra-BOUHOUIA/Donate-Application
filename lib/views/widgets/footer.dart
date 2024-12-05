import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:donate_application/themes/colors.dart';

import '/imports/organization_barrel.dart';
import '/imports/user_barrel.dart';


class Footer extends StatefulWidget {
  final bool isOrganization;

  const Footer({Key? key, required this.isOrganization}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int? _selectedIndex; // Keeps track of the selected tab index (null means no tab selected)

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final ModalRoute? currentRoute = ModalRoute.of(context);
    if (currentRoute != null) {
      final newIndex = _getIndexFromRoute(currentRoute.settings.name);
      if (newIndex != _selectedIndex) {
        setState(() {
          _selectedIndex = newIndex;
        });
      }
    }
  }

  int? _getIndexFromRoute(String? route) {
    if (widget.isOrganization) {
      switch (route) {
        case OrgHomePage.pageRoute:
          return 0;
        case DonationsPage.pageRoute:
          return 1;
        case OrgNotification.pageRoute:
          return 2;
        case OrgProfilePage.pageRoute:
          return 3;
        default:
          return null; // No tab selected for undefined routes
      }
    } else {
      switch (route) {
        case UserHomePage.pageRoute:
          return 0;
        case UserDonations.pageRoute:
          return 1;
        case UserNotification.pageRoute:
          return 2;
        case UserProfilePage.pageRoute:
          return 3;
        default:
          return null; // No tab selected for undefined routes
      }
    }
  }

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
          Navigator.pushNamed(context, OrgProfilePage.pageRoute);
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
          Navigator.pushNamed(context, UserProfilePage.pageRoute);
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
          tabBackgroundColor: footerbtncolor,
          padding: const EdgeInsets.all(16),
          gap: 8,
          selectedIndex: _selectedIndex ?? -1, // Highlights the active tab or none if null
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
