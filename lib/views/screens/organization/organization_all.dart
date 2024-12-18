/*import 'package:flutter/material.dart';
import '../../widgets/main_background.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart';

class CardContentPage extends StatelessWidget {
  const CardContentPage({super.key});
  static const String pageRoute = '/org_all';

  // Fetching data from the `DBCardTable`
  Future<List<Map<String, dynamic>>> fetchCards() async {
    final DBCampaignTable = DBCampaignTable();
    return await DBCampaignTable.getAllRecords();
  }

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
                        future: fetchCards(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Error loading cards.'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No cards available.'));
                          } else {
                            final cards = snapshot.data!;
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cards.length,
                              itemBuilder: (context, index) {
                                final card = cards[index];
                                return createOrgCard(
                                  context,
                                  false,
                                  card['title'] ?? 'Untitled',
                                  card['location'] ?? 'No location provided',
                                  card['image'] ??
                                      'assets/images/default_image.png',
                                  0, // Placeholder for current amount
                                  0, // Placeholder for target amount
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const Footer(
              isOrganization: true,
            ), // Footer widget
          );
        },
      ),
    );
  }
}
*/
