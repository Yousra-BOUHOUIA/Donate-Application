import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/user_card.dart';
import '../../widgets/footer.dart';
import '../../../imports/user_barrel.dart';
import 'package:donate_application/databases/tables/campaign.dart';

class UserDonations extends StatelessWidget {
  UserDonations({super.key});
  static const String pageRoute = '/user_donations';

  final DBCampaignTable _campaignTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        title: const Text("Donations"),
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
            future: _campaignTable.getDonations(),
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
                  var imageBytes = donation['image'];

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
                    donation['type'] ?? 'donation',
                    donation['title'] ?? 'No title',
                    donation['description'] ?? 'No description',
                    imageWidget,
                    donation['resource'] ?? 0,
                    donation['resource'] ?? 0,
                    detailsButton: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          UserDonationDescriptionScreen.pageRoute,
                          arguments: donation,  
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
