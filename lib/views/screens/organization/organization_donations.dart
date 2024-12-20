import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart';
import 'package:donate_application/databases/tables/campaign.dart'; // Import your donations database

class DonationsPage extends StatelessWidget {
   DonationsPage({super.key});
  static const String pageRoute = '/org_donations';
  final DBCampaignTable _donationsTable = DBCampaignTable(); // Assuming the same table class for donations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donations"),
        backgroundColor: appBackgroundColor,
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
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _donationsTable.getDonations(), // Assuming this method fetches the donations
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No donations available.'));
              }

              final donations = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: donations.map((donation) {
                  return createOrgCard(
                    context,
                    'donation',
                    donation['title'] ?? 'No title',
                    donation['description'] ?? 'No description',
                    donation['image'] ?? 'assets/images/default_image.webp',
                    donation['collected'] ?? 0,
                    donation['goal'] ?? 0,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const Footer(
        isOrganization: true,
      ), // Footer widget
    );
  }
}
