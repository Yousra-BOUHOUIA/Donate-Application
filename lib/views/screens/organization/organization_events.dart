import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart';
import 'package:donate_application/databases/tables/campaign.dart'; // Import your events database

class EventsPage extends StatelessWidget {
  EventsPage({super.key});
  static const String pageRoute = '/org_event';
  final DBCampaignTable _compaignTable = DBCampaignTable(); // Assuming the same table class for events

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        backgroundColor: appBackgroundColor,
        centerTitle: true, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _compaignTable.getEvents(), // Assuming this method fetches the events
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No events available.'));
              }

              final compaigns = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: compaigns.map((compaign) {
                  return createOrgCard(
                    context,
                    'event',
                    compaign['title'] ?? 'No title',
                    compaign['description'] ?? 'No description',
                    compaign['image'] ?? 'assets/images/default_image.webp',
                    compaign['participants'] ?? 0,
                    compaign['goal'] ?? 0,
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
