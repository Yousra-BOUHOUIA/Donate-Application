import '../../../themes/colors.dart';
import 'package:flutter/material.dart';

class TermsAndPoliciesScreen extends StatelessWidget {
  const TermsAndPoliciesScreen({super.key});
  static const String pageRoute = '/term_and_policies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Terms and Policies", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildSection("1. Types of data we collect"),
            const SizedBox(height: 30),
            _buildSection("2. Use of your personal data"),
            const SizedBox(height: 30),
            _buildSection("3. Disclosure of your personal data"),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        title == "1. Types of data we collect"
            ? const Text(
                "We collect personal data such as your name, contact information, donation history, and volunteering preferences. This data is used to facilitate donations and connect you with relevant volunteering opportunities.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            : title == "2. Use of your personal data"
                ? const Text(
                    "Your personal data is used to process donations, manage your volunteering engagements, and send you updates about new opportunities. We may also use your information for statistical purposes to improve the user experience and enhance the app's functionality.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  )
                : title == "3. Disclosure of your personal data"
                    ? const Text(
                        "We do not share your personal data with third parties without your consent, except in cases where it is necessary for processing donations or facilitating volunteering opportunities. We may also share data for legal compliance or to prevent fraud.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    : const Text(
                        "Lorem ipsum dolor sit amet consectetur. Ultricies ut augue amet vel hac. Ut orci adipiscing fusce lacus lectus rhoncus.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
      ],
    );
  }
}
