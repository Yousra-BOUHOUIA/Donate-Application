import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/input_field.dart';
import '/views/screens/organization/org_edit_profile.dart'; 

class OrgProfileDetailsScreen extends StatelessWidget {
  const OrgProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: appBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/org_logo.jpg'), // Replace with organization image asset path
                            backgroundColor: Colors.grey[200],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to the EditOrgProfileScreen when the icon is tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditOrgProfileScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Hilal Ahmar", // Replace with dynamic organization name if needed
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "contact@hilal-ahmer-algeria.org", // Replace with dynamic email if needed
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                InputField(
                  label: "Organization name",
                  controller: TextEditingController(text: "Hilal Ahmar"),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Email",
                  controller: TextEditingController(text: "contact@hilal-ahmer-algeria.org"),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Type",
                  controller: TextEditingController(text: "Humanitarian non-profit"),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Phone number",
                  controller: TextEditingController(text: "+213 21 92 74 00"),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Address",
                  controller: TextEditingController(
                    text: "Rue Bouzered Hocine, Annaba 23000, Algeria",
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "About the organization",
                  controller: TextEditingController(
                    text:
                    "Hilal Ahmar is a non-profit organization dedicated to providing humanitarian aid and support to vulnerable communities in Algeria. We offer essential services such as healthcare, emergency relief, and educational programs to empower individuals and help them build a better future.",
                  ),
                  enabled: false,
                  maxLines: 8, // Increased maxLines for a larger field
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10), // Add padding for better spacing
                ),
                const SizedBox(height: 20),
                const Text(
                  "Social platforms",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 10),
                _buildSocialPlatformTile(
                  context,
                  initialText: "https://www.hilaleahmar.com",
                ),
                const SizedBox(height: 10),
                _buildSocialPlatformTile(
                  context,
                  initialText: "https://web.facebook.com/p/",
                ),
                const SizedBox(height: 10),
                _buildSocialPlatformTile(
                  context,
                  initialText: "Add a new platform link",
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialPlatformTile(
    BuildContext context, {
    required String initialText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Row(
          children: [
            // TextField wrapped in Expanded to take available space
            Expanded(
              child: TextField(
                enabled: false, // Prevent editing
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: initialText,
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
