import 'package:donate_application/themes/colors.dart';
import 'package:flutter/material.dart';

import '/views/screens/user/user_edit_profile.dart';
import '/views/screens/user/user_post.dart';
import '/views/screens/user/user_profile_details.dart';
import '/views/screens/organization/org_notifications.dart';
import '/views/screens/organization/users_donations.dart';

import 'package:donate_application/views/screens/organization/org_donation_description.dart';
import 'package:donate_application/views/screens/organization/org_event_description.dart';
import 'package:donate_application/views/screens/user/user_donation_description.dart';
import 'package:donate_application/views/screens/user/user_event_description.dart';


import '/views/screens/user/user_notification.dart';


import 'views/screens/organization/org_edit_profile.dart';
import '/views/screens/organization/org_post.dart';
import '/views/screens/organization/org_edit_profile.dart';
import '/views/screens/organization/org_profile_detail.dart';
import '/views/screens/organization/org_profile.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
  
        OrgNotification.pageRoute: (ctx) => const OrgNotification(),
        UserNotification.pageRoute: (ctx) => const UserNotification(),
        UsersDonationsScreen.pageRoute: (ctx) =>  UsersDonationsScreen (),  
        
        UserDonationDescriptionScreen.pageRoute:(ctx) => const UserDonationDescriptionScreen(),
        UserEventDescriptionScreen.pageRoute:(ctx) => const UserEventDescriptionScreen(),
        OrgDonationDescriptionScreen.pageRoute:(ctx) => const OrgDonationDescriptionScreen(),
        OrgEventDescriptionScreen.pageRoute:(ctx) => const OrgEventDescriptionScreen(),         
      },



      home: OrgProfilePage(),

    );
  }
}


