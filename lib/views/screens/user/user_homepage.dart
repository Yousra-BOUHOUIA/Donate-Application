import 'package:flutter/material.dart';
import '../../widgets/user_card.dart';
import '/themes/colors.dart';
import '/views/widgets/event_card.dart'; 
import '/views/widgets/footer.dart';
import '/views/widgets/custom_drawer.dart';
import 'package:donate_application/databases/tables/campaign.dart';
import '/imports/user_barrel.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});
  static const String pageRoute = '/user_homepage';
  
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final DBCampaignTable _campaignTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); 
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Tataou3"),
            IconButton(
              onPressed: () {
                // Add logic here if needed
              },
              icon: const Icon(Icons.volunteer_activism),
            ),
          ],
        ),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: const CustomDrawer(
        profilePicture: 'assets/images/user_profile.png',
        name: 'User Name',
        email: 'email@example.com',
        isOrganization: false,
      ),
      body: Container(
        color: appBackgroundColor, 
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
                  height: 200, // Adjusted for event card
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      eventCard(context, false, 'assets/images/event_picture.jpg'),
                      const SizedBox(width: 16),
                      eventCard(context, false, 'assets/images/event_picture.jpg'),
                      const SizedBox(width: 16),
                      eventCard(context, false, 'assets/images/event_picture.jpg'),
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
                          Navigator.pushNamed(context, UserAll.pageRoute);
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
                          Navigator.pushNamed(context, UserDonations.pageRoute);
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
                          Navigator.pushNamed(context, UserEvents.pageRoute);
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
                      return const Center(child: CircularProgressIndicator());
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

                      return createUserCard(
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
                                UserEventDescriptionScreen.pageRoute,
                                arguments: campaign,
                              );
                            } else if (campaign['type'] == 'donation') {
                              Navigator.pushNamed(
                                context,
                                UserDonationDescriptionScreen.pageRoute,
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
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDonationScreen()),
          );
        },
        backgroundColor: appButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const Footer(isOrganization: false),
    );
  }
}
