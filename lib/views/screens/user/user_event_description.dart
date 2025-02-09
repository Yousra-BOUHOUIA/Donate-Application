import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/main_background.dart';

class UserEventDescriptionScreen extends StatelessWidget {
  static const String pageRoute = '/user_event_description';

  const UserEventDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the campaign data passed through navigation
    final Map<String, dynamic> event = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return GradientPage(
      gradientStartColor: topGradientStart,
      gradientEndColor: topGradientEnd,
      pageTitle: "Details",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double screenWidth = MediaQuery.of(context).size.width;
          final double screenHeight = MediaQuery.of(context).size.height;

          return Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: appBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Stack(
              children: [
                // Image header section
                Positioned(
                  left: 0,
                  top: 10,
                  child: Container(
                    width: screenWidth * 0.97,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: event['image'] != null
                          ? Image.memory(
                              event['image'],
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
                // Main content section below image
                Positioned(
                  left: 0,
                  top: 250,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight - 250,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title'] ?? 'No Title',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.grey, size: 18),
                                    const SizedBox(width: 4),
                                    Text(
                                      event['location'] ?? 'No location',
                                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: event['progress'] ?? 0.0,
                                    backgroundColor: const Color(0xFFF1EBFF),
                                    color: percentIndicator,
                                    minHeight: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recruited Volunteers: ${event['volunteersRecruited'] ?? 0}/${event['volunteersNeeded'] ?? 0}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold, color: Description_Text),
                              ),
                              Text(
                                "${event['daysLeft'] ?? 0} days to go",
                                style: const TextStyle(fontSize: 14, color: Description_Text),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          RichText(
                            text: TextSpan(
                              text: event['description'] ?? 'No description available.',
                              style: const TextStyle(fontSize: 14, color: Description_Text),
                              children: const [
                                TextSpan(
                                  text: "Show More",
                                  style: TextStyle(
                                    color: Color(0xFF666D80),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          const Row(
                            children: [
                              Text(
                                "Social Project",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.verified,
                                color: Color(0xFF36394A),
                                size: 18,
                              ),
                            ],
                          ),
                           const SizedBox(height: 20),
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: ElevatedButton(
                              onPressed: () {
                                //send notification to the organization
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appButtonColor,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Participate Now",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
