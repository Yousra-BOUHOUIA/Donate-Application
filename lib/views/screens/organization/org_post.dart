import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/org_card.dart';
import '../../widgets/footer.dart';
import 'package:donate_application/databases/tables/campaign.dart';
import '/imports/organization_barrel.dart';

class OrgPostsScreen extends StatelessWidget {
  OrgPostsScreen({super.key});
  static const String pageRoute = '/org_post';
  final DBCampaignTable _postTable = DBCampaignTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("My Posts", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _postTable.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No posts available.'));
              }

              final posts = snapshot.data!;

              print("Fetched ${posts.length} posts");

              final displayedPosts =
                  posts.length > 50 ? posts.sublist(0, 50) : posts;

              print("Displaying ${displayedPosts.length} posts");

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: displayedPosts.map((post) {
                  var imageBytes = post['image'];

                  Widget imageWidget = SizedBox(
                    width: 150,
                    height: 150,
                    child: imageBytes != null
                        ? Image.memory(
                            imageBytes,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                  );

                  return createOrgCard(
                    context,
                    'post',
                    post['title'] ?? 'No title',
                    post['description'] ?? 'No description',
                    imageWidget,
                    100,
                    50,
                    detailsButton: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          OrgEventDescriptionScreen.pageRoute,
                          arguments: post,
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
      ),
    );
  }
}