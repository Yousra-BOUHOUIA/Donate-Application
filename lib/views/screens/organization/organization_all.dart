import 'package:flutter/material.dart';
import '../../widgets/main_background.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart'; 

class CardContentPage extends StatelessWidget {
  const CardContentPage({super.key});
  static const String pageRoute = '/org_all';

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
                          createOrgCard(context,false,
                            "Day of Compassion",
                            "On the Day of Compassion, we aim to bring smiles to the children in orphanages. Join us to make a difference.",
                            'assets/images/donation_image.webp',
                            120,
                            200,
                          ),
                          createOrgCard(context,false,
                            "Day of Joy",
                            "Spread happiness by participating in community events and activities.",
                            'assets/images/event_image.webp',
                            80,
                            150,
                          ),
                          createOrgCard(context,false,
                            "Community Cleanup",
                            "Join us in making our neighborhoods cleaner and greener.",
                            'assets/images/helping_image.jpg',
                            50,
                            100,
                          ),
                          createOrgCard(context,false,
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
            bottomNavigationBar: const Footer(isOrganization: true,), // Added Footer widget here
          );
        },
      ),
    );
  }
}

