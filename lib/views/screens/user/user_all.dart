import 'package:flutter/material.dart';
import 'package:donate_application/views/widgets/main_background.dart';
import 'package:donate_application/views/widgets/user_card.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/views/widgets/footer.dart'; 

class CardContentPage extends StatelessWidget {
  const CardContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPage(
      gradientStartColor: topGradientStart,
      gradientEndColor: topGradientEnd,
      pageTitle: "All",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: constraints.maxHeight - 16,
                    margin: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      color: appBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          createCard(context,
                            "Day of Compassion",
                            "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                            'assets/images/donation_image.webp',
                            120,
                            200,
                          ),
                          createCard(context,
                            "Day of Joy",
                            "Spread happiness by participating in community events and activities.",
                            'assets/images/event_image.webp',
                            80,
                            150,
                          ),
                          createCard(context,
                            "Community Cleanup",
                            "Join us in making our neighborhoods cleaner and greener.",
                            'assets/images/helping_image.jpg',
                            50,
                            100,
                          ),
                          createCard(context,
                            "Community Cleanup",
                            "Join us in making our neighborhoods cleaner and greener.",
                            'assets/images/volenteering_image.webp',
                            50,
                            100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const Footer(), // Added Footer widget here
          );
        },
      ),
    );
  }
}
