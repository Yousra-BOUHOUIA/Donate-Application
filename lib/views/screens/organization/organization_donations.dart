import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/views/widgets/org_card.dart';
import 'package:donate_application/views/widgets/footer.dart'; 

class DonationsPage extends StatelessWidget {
  const DonationsPage({super.key});
  static const String pageRoute = '/org_donations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donations"),
         backgroundColor:appBackgroundColor,
        centerTitle: true, // Center the title in the AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        // Ensure the entire body is scrollable vertically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event 1
              createCard(context,
                "Clothing Drive",
                "Join us for a clothing drive to provide winter clothes to those in ...",
                'assets/images/donation_image.webp',
                150,
                250,
              ),
              // Event 2
              createCard(context,
                "Food Donation Campaign",
                "We are collecting non-perishable food items to help families... ",
                'assets/images/event_image.webp',
                180,
                280,
              ),
              // Event 3
              createCard(context,
                "Book Donation Initiative",
                "Help us donate books to schools in underprivileged areas...",
                'assets/images/helping_image.jpg',
                160,
                270,
              ),
              // Event 4
              createCard(context,
                "Toy Drive for Children",
                "This holiday season, let's bring joy to children by donating toys. Every donation matters!",
                'assets/images/volenteering_image.webp',
                140,
                230,
              ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: const Footer(isOrganization: true,),
    );

  }
}
