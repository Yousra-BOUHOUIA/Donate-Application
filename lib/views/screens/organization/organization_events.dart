
import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/org_card.dart';
import '/views/widgets/footer.dart'; 

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});
  static const String pageRoute = '/org_event';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
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
      body: SingleChildScrollView( // Ensure the entire body is scrollable vertically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event 1
              createCard(context,false,
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'assets/images/donation_image.webp',
                120,
                200,
                
              ),
               createCard(context,false,
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'assets/images/event_image.webp',
                120,
                200,
                
              ),
               createCard(context,false,
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'assets/images/helping_image.jpg',
                120,
                200,
                
              ),
               createCard(context,false,
                "Day of Compassion",
                "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                'assets/images/volenteering_image.webp',
                120,
                200,
                
              ),
              
            ],
          ),
        ),
      ),
    bottomNavigationBar: const Footer(isOrganization: true,),
    );
  }
}
