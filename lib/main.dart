import 'package:donate_application/bloc/Footer.dart';
import 'package:donate_application/bloc/SignUp.dart';
import 'package:donate_application/bloc/add_donation.dart';
import 'package:donate_application/bloc/create_compaign_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'imports/common_barrel.dart';
import 'imports/organization_barrel.dart';
import 'imports/user_barrel.dart';



void main() {
  runApp(
   MultiBlocProvider(
  providers: [
    BlocProvider<FooterCubit>(create: (_) => FooterCubit()),
    BlocProvider<SignupCubit>(create: (_) => SignupCubit()),
    BlocProvider<AddDonationCubit>(create: (_) => AddDonationCubit()),
    BlocProvider<CreateCampaignCubit>(create: (_) => CreateCampaignCubit()), // Add this line
  ],
  child: const MyApp(),
)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LanguageSelectionScreen.pageRoute: (ctx) =>
            const LanguageSelectionScreen(),
        ContactUsScreen.pageRoute: (ctx) => const ContactUsScreen(),
        TermsAndPoliciesScreen.pageRoute: (ctx) =>
            const TermsAndPoliciesScreen(),
        ChangePasswordScreen.pageRoute: (ctx) => const ChangePasswordScreen(
              isOrganization: false,
            ),
        ProductDescriptionPage.pageRoute: (ctx) => ProductDescriptionPage(),
        LoginPage.pageRoute: (ctx) => const LoginPage(),
        SignUpAsUserPage.pageRoute: (ctx) => const SignUpAsUserPage(),
        SignUpAsOrganizationPage.pageRoute: (ctx) =>
            const SignUpAsOrganizationPage(),

        //organization profile routes

        OrgProfilePage.pageRoute: (ctx) => const OrgProfilePage(),
        OrgProfileDetailsScreen.pageRoute: (ctx) =>
            const OrgProfileDetailsScreen(),
        OrgPostsScreen.pageRoute: (ctx) => OrgPostsScreen(),

        // EditOrgProfileScreen.pageRoute: (ctx) => const EditOrgProfileScreen(),
        OrgNotification.pageRoute: (ctx) => const OrgNotification(),

        OrgHomePage.pageRoute: (ctx) => const OrgHomePage(),
        EventsPage.pageRoute: (ctx) => EventsPage(),
        DonationsPage.pageRoute: (ctx) => DonationsPage(),
        CardContentPage.pageRoute: (ctx) => CardContentPage(),

        // User profile routes
        UserProfilePage.pageRoute: (ctx) => const UserProfilePage(),
        UserProfileDetailsScreen.pageRoute: (ctx) =>
            const UserProfileDetailsScreen(),
        // EditUserProfileScreen.pageRoute: (ctx) =>
        //     EditUserProfileScreen(),
        UserPostsScreen.pageRoute: (ctx) => const UserPostsScreen(),
        OrgDonationDescriptionScreen.pageRoute: (ctx) =>
            const OrgDonationDescriptionScreen(),
        OrgEventDescriptionScreen.pageRoute: (ctx) =>
            const OrgEventDescriptionScreen(),
        UserNotification.pageRoute: (ctx) => const UserNotification(),
        UsersDonationsScreen.pageRoute: (ctx) => UsersDonationsScreen(),
        UserDonationDescriptionScreen.pageRoute: (ctx) =>
            const UserDonationDescriptionScreen(),
        UserEventDescriptionScreen.pageRoute: (ctx) =>
            const UserEventDescriptionScreen(),
        AddDonationScreen.pageRoute: (ctx) =>  const AddDonationScreen(),
        UserHomePage.pageRoute: (ctx) => const UserHomePage(),
        UserDonations.pageRoute: (ctx) => UserDonations(),
        UserAll.pageRoute: (ctx) => UserAll(),
        UserEvents.pageRoute: (ctx) => UserEvents(),
      },
      //home: const ChangePasswordScreen(isOrganization: true,),
      home: const SignUpAsUserPage(),
    );
  }
}
