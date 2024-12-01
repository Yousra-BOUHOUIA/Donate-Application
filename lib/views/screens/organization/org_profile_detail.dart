import 'package:flutter/material.dart';
import 'package:donate_application/views/widgets/input_field.dart';
import '../../../themes/colors.dart';

class orgProfileDetailsScreen extends StatelessWidget {
  const orgProfileDetailsScreen({super.key});

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
                InputField(
                  label: "Organization name",
                  controller: TextEditingController(text: "Hilal Ahmar"),
                  enabled: false, // Non-editable field
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Email",
                  controller: TextEditingController(text: "contact@hilal-ahmer-algeria.org"),
                  enabled: false, // Non-editable field
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Type",
                  controller: TextEditingController(text: "Humanitarian non-profit"),
                  enabled: false, // Non-editable field
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Phone number",
                  controller: TextEditingController(text: "+213 21 92 74 00"),
                  enabled: false, // Non-editable field
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Address",
                  controller: TextEditingController(text: "Rue Bouzered Hocine, Annaba 23000, Algeria"),
                  enabled: false, // Non-editable field
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "About the organization",
                  controller: TextEditingController(
                    text:
                        "Hilal Ahmar is a non-profit organization dedicated to providing humanitarian aid and support to vulnerable communities in Algeria. We offer essential services such as healthcare, emergency relief, and educational programs to empower individuals and help them build a better future.",
                  ),
                  enabled: false, // Non-editable field
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
