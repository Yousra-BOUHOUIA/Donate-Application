import 'package:flutter/material.dart';

import 'imports/common_barrel.dart';
import 'imports/organization_barrel.dart';
import 'imports/user_barrel.dart';



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
  
        LanguageSelectionScreen.pageRoute:(ctx) => const LanguageSelectionScreen(),         
        ContactUsScreen.pageRoute:(ctx) => const ContactUsScreen(),         
        TermsAndPoliciesScreen.pageRoute:(ctx) => const TermsAndPoliciesScreen(),         
        ChangePasswordApp.pageRoute:(ctx) => const ChangePasswordApp(),  
        ProductDescriptionPage.pageRoute:(ctx) => const ProductDescriptionPage(),
        LoginPage.pageRoute:(ctx) => const LoginPage(), 
        SignUpAsUserPage.pageRoute:(ctx) => const SignUpAsUserPage(), 
        SignUpAsOrganizationPage.pageRoute:(ctx) => const SignUpAsOrganizationPage(), 
        
        


        //organization profile routes
      
        OrgProfilePage.pageRoute:(ctx) => const OrgProfilePage(),
        OrgProfileDetailsScreen.pageRoute:(ctx) => const OrgProfileDetailsScreen(),   
        OrgPostsScreen.pageRoute:(ctx) => const OrgPostsScreen(),         
      
        EditOrgProfileScreen.pageRoute:(ctx) => const EditOrgProfileScreen(),         
        OrgNotification.pageRoute: (ctx) => const OrgNotification(),

        
        OrgHomePage.pageRoute: (ctx) => const OrgHomePage (),
        EventsPage.pageRoute: (ctx) => const EventsPage (),
        DonationsPage.pageRoute: (ctx) => const DonationsPage (),
        CardContentPage.pageRoute: (ctx) => const CardContentPage (),
               

      
        // User profile routes
        UserProfilePage.pageRoute:(ctx) => const UserProfilePage(),
        UserProfileDetailsScreen.pageRoute:(ctx) => const UserProfileDetailsScreen(),         
        EditUserProfileScreen.pageRoute:(ctx) => const EditUserProfileScreen(),         
        UserPostsScreen.pageRoute:(ctx) => const UserPostsScreen(), 
        OrgDonationDescriptionScreen.pageRoute:(ctx) => const OrgDonationDescriptionScreen(),
        OrgEventDescriptionScreen.pageRoute:(ctx) => const OrgEventDescriptionScreen(),  
        UserNotification.pageRoute: (ctx) => const UserNotification(),
        UsersDonationsScreen.pageRoute: (ctx) =>  UsersDonationsScreen (),  
        UserDonationDescriptionScreen.pageRoute:(ctx) => const UserDonationDescriptionScreen(),
        UserEventDescriptionScreen.pageRoute:(ctx) => const UserEventDescriptionScreen(),
        AddDonationScreen.pageRoute:(ctx) => const AddDonationScreen(),
        UserHomePage.pageRoute: (ctx) => const UserHomePage (),
        UserDonations.pageRoute: (ctx) => const UserDonations (),
        UserAll.pageRoute: (ctx) => const UserAll (),
        UserEvents.pageRoute: (ctx) =>  const UserEvents (),



        
      },



      home: const LoginPage(),

    );
  }
}

