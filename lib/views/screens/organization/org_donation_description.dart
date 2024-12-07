import 'package:flutter/material.dart';
import '../../widgets/main_background.dart';
import '../../../themes/colors.dart';

class OrgDonationDescriptionScreen extends StatelessWidget {
  const OrgDonationDescriptionScreen({super.key});
  static const String pageRoute = '/org_donation_description';

  @override
  Widget build(BuildContext context) {
    return GradientPage(
      gradientStartColor: topGradientStart, // Add your gradient start color here
      gradientEndColor: topGradientEnd,   // Add your gradient end color here
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
                // Header section with image background
                Positioned(
                  left: 0,
                  top: 10,
                  child: Container(
                    width: screenWidth * 0.97,
                    height: 250, // Height for the image top section
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/details_image.jpg', // Replace with the path of your image
                        fit: BoxFit.cover, // Ensures the image covers the entire area
                      ),
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
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Share Your Food, Share Your Love",
                            style: TextStyle(
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: const Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.grey, size: 18),
                                    SizedBox(width: 4),
                                    Text(
                                      "Algiers",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
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
                                  child: const LinearProgressIndicator(
                                    value: 0.75, // Progress as a percentage
                                    backgroundColor: Color(0xFFF1EBFF),
                                    color: percentIndicator,
                                    minHeight: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Collected \$150,000",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Description_Text),
                              ),
                              Text(
                                "20 days to go",
                                style: TextStyle(
                                    fontSize: 14, color: Description_Text),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: const TextSpan(
                              text:
                                  "Lorem ipsum dolor sit amet consectetur. Ultricies ut augue amet vel hac. "
                                  "Ut orci adipiscing fusce lacus lectus rhoncus. Lorem ipsum dolor sit amet, "
                                  "consectetur adipiscing elit, sed ... ",
                              style: TextStyle(
                                  fontSize: 14, color: Description_Text),
                              children: [
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
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.verified,
                                color: Color(0xFF36394A),
                                size: 18,
                              ),
                            ],
                          ),
                          const Text(
                            "Verified Account",
                            style:
                                TextStyle(fontSize: 12, color: Colors.grey),
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
