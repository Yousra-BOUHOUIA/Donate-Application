import 'package:donate_application/imports/user_barrel.dart';
import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/org_card.dart';
import '/views/widgets/event_card.dart';
import '/views/widgets/footer.dart';
import '/views/widgets/custom_drawer.dart';
import 'package:donate_application/databases/tables/campaign.dart';
import '/imports/organization_barrel.dart';

class OrgHomePage extends StatefulWidget {
  OrgHomePage({super.key});
  static const String pageRoute = '/org_home';

  @override
  _OrgHomePageState createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {
  final DBCampaignTable _campaignTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer(); 
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Tataou3"),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.volunteer_activism),
            ),
          ],
        ),
        backgroundColor: appBackgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: const CustomDrawer(
        profilePicture: 'assets/images/org_profile.jpg',
        name: 'Organization Name',
        email: 'email@example.com',
        isOrganization: true,
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Events: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      eventCard(context, true, 'assets/images/event_picture.jpg'),
                      const SizedBox(width: 16),
                      eventCard(context, true, 'assets/images/event_picture.jpg'),
                      const SizedBox(width: 16),
                      eventCard(context, true, 'assets/images/event_picture.jpg'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Categories: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CardContentPage.pageRoute); 
                        },
                        child: const Chip(
                          label: Text(
                            "All",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: appButtonColor,
                          shape: StadiumBorder(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, EventsPage.pageRoute);                     
                        },
                        child: const Chip(
                          label: Text(
                            "Events",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: appButtonColor,
                          shape: StadiumBorder(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DonationsPage.pageRoute);                     
                        },
                        child: const Chip(
                          label: Text(
                            "Donations",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: appButtonColor,
                          shape: StadiumBorder(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, UsersDonationsScreen.pageRoute);                     
                        },
                        child: const Chip(
                          label: Text(
                            "User Donations",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: appButtonColor,
                          shape: StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Latest Campaigns: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

FutureBuilder<List<Map<String, dynamic>>>( 
  future: _campaignTable.getAllRecords(), 
  builder: (context, snapshot) { 
    if (snapshot.connectionState == ConnectionState.waiting) { 
      return const CircularProgressIndicator(); 
    } 
    if (snapshot.hasError) { 
      return Text('Error: ${snapshot.error}'); 
    } 
    if (!snapshot.hasData || snapshot.data!.isEmpty) { 
      return const Text('No campaigns available.'); 
    } 

    final campaigns = snapshot.data!;

    return Column(
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

        return createOrgCard(
          context,
          campaign['type'],
          campaign['title'] ?? 'No title',
          campaign['description'] ?? 'No description',
          imageWidget, 
          campaign['resource'] ?? 0,
          campaign['resource'] ?? 0,
          detailsButton: ElevatedButton(
            onPressed: () {
              if (campaign['type'] == 'event') {
                Navigator.pushNamed(
                  context,
                  OrgEventDescriptionScreen.pageRoute,
                  arguments: campaign,
                );
              } else if (campaign['type'] == 'donation') {
                Navigator.pushNamed(
                  context,
                  OrgDonationDescriptionScreen.pageRoute,
                  arguments: campaign,
                );
              }
            },
            child: const Text('Details'),
          ),
        );
      }).toList(),
    );
  },
)

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateCampaignScreen()),
          );
        },
        backgroundColor: appButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const Footer(isOrganization: true),
    );
  }
}
