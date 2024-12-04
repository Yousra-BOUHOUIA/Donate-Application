import 'package:donate_application/themes/colors.dart';
import 'package:flutter/material.dart';

import 'package:donate_application/views/screens/user/user_edit_profile.dart';
import 'package:donate_application/views/screens/user/user_post.dart';
import 'package:donate_application/views/screens/user/user_profile_details.dart';
import 'package:donate_application/views/screens/organization/org_notifications.dart';
import 'package:donate_application/views/screens/organization/user_donations.dart';
import 'package:donate_application/views/screens/common/donation_description.dart';
import 'package:donate_application/views/screens/common/event_description.dart';
import 'package:donate_application/views/screens/user/user_notification.dart';


import 'package:donate_application/views/screens/organization/org_edit_profile.dart';
import 'package:donate_application/views/screens/organization/org_post.dart';
import 'package:donate_application/views/screens/organization/org_edit_profile.dart';
import 'package:donate_application/views/screens/organization/org_profile_detail.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationsPage(),
      routes: {
  
        NotificationsPage.pageRoute: (ctx) => const NotificationsPage(),
        UsersDonationsScreen.pageRoute: (ctx) =>  UsersDonationsScreen (),  
        DonationDescriptionScreen.pageRoute: (ctx) =>  DonationDescriptionScreen (),  
        EventDescriptionScreen.pageRoute: (ctx) =>   EventDescriptionScreen (),  
        UserNotification.pageRoute: (ctx) =>    UserNotification(),  
        
         
        
},
    );
  }
}


