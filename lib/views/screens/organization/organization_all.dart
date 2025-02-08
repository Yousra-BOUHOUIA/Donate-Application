import 'package:flutter/material.dart';
import '../../widgets/main_background.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart';
import 'package:donate_application/databases/tables/campaign.dart';
import '/imports/organization_barrel.dart';


class CardContentPage extends StatelessWidget {
  CardContentPage({super.key});
  static const String pageRoute = '/org_all';
  final DBCampaignTable _campaignTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return GradientPage(
      gradientStartColor: topGradientStart,
      gradientEndColor: topGradientEnd,
      pageTitle: "All",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: constraints.maxHeight - 16,
                    margin: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      color: appBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FutureBuilder<List<Map<String, dynamic>>>( 
                        future: _campaignTable.getAllRecords(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text('No records available.');
                          }

                          final records = snapshot.data!;
                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            children: records.map((record) {
                              var imageBytes = record['image'];

                              Widget imageWidget = SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.memory(
                                  imageBytes,
                                  fit: BoxFit.cover,
                                ),
                              );

                              // Check the type of campaign (event or donation)
                              return createOrgCard(
                                context,
                                record['type'],
                                record['title'] ?? 'No title',
                                record['description'] ?? 'No description',
                                imageWidget,
                                record['resource'] ?? 0,
                                record['resource'] ?? 0,
                                detailsButton: ElevatedButton(
                                  onPressed: () {
                                    if (record['type'] == 'event') {
                                      Navigator.pushNamed(
                                        context,
                                        OrgEventDescriptionScreen.pageRoute,
                                        arguments: record,
                                      );
                                    } else if (record['type'] == 'donation') {
                                      Navigator.pushNamed(
                                        context,
                                        OrgDonationDescriptionScreen.pageRoute,
                                        arguments: record,
                                      );
                                    }
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
                ],
              ),
            ),
            bottomNavigationBar: const Footer(isOrganization: true),
          );
        },
      ),
    );
  }
}
