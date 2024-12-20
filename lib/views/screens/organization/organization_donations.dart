import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart';
import '/databases/tables/campaign.dart';
import '/imports/organization_barrel.dart';


class DonationsPage extends StatelessWidget {
  DonationsPage({super.key});
  static const String pageRoute = '/org_donations';
  final DBCampaignTable _compaignTable = DBCampaignTable(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donations"),
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
            future: _compaignTable.getDonations(), 
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

              final compaigns = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: compaigns.map((compaigns) {
                  var imageBytes = compaigns['image'];

                  Widget imageWidget = SizedBox(
                    width: 150, // Fixed width
                    height: 150, // Fixed height
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover, 
                    ),
                  );

                  return createOrgCard(
                    context,
                    'donation', 
                    compaigns['title'] ?? 'No title',
                    compaigns['description'] ?? 'No description',
                    imageWidget, 
                    compaigns['resource'] ?? 0,
                    compaigns['resource'] ?? 0,
                    detailsButton: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          OrgDonationDescriptionScreen.pageRoute,
                          arguments: compaigns, 
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
      bottomNavigationBar: const Footer(
        isOrganization: true,
      ), // Footer widget
    );
  }
}
