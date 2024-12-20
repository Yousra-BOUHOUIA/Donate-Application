import 'package:flutter/material.dart';
import '../../../imports/user_barrel.dart';
import '../../../themes/colors.dart';
import '../../widgets/user_card.dart';
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
          child: FutureBuilder<List<Map<String, dynamic>>>( 
            future: _campaignTable.getEvents(),
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

              final campaigns = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: campaigns.map((campaign) {
                  var imageBytes = campaign['image'];

                  Widget imageWidget = SizedBox(
                    width: 150, 
                    height: 150, 
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                    ),
                  );

                  return createUserCard(
                    context,
                    campaign['type'] ?? 'event',
                    campaign['title'] ?? 'No title',
                    campaign['description'] ?? 'No description',
                    imageWidget,
                    campaign['resource'] ?? 0,
                    campaign['resource'] ?? 0,
                    detailsButton: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          UserEventDescriptionScreen.pageRoute,
                          arguments: campaign, 
                        );
                      },
                      child: const Text('Details'),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const Footer(isOrganization: false),
    );
  }
}
