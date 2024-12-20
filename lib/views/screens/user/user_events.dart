import 'package:flutter/material.dart';
import '../../widgets/user_card.dart';
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';
import 'package:donate_application/databases/tables/campaign.dart';

class UserEvents extends StatelessWidget {
  UserEvents({super.key});
  static const String pageRoute = '/user_events';

  final DBCampaignTable _campaignTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        title: const Text("Events"),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _campaignTable.getEvents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No events available.');
                  }

                  final campaigns = snapshot.data!;
                  return Column(
                    children: campaigns.map((campaign) {
                      return createUserCard(
                        context,
                        campaign['type'],
                        campaign['title'] ?? 'No title',
                        campaign['description'] ?? 'No description',
                        'assets/images/org_image.jpg',
                        campaign['resource'] ?? 0,
                        campaign['resource'] ?? 0,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(isOrganization: false),
    );
  }
}
