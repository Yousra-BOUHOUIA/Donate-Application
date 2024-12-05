import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges_lib;
import '/themes/colors.dart';
import '/views/widgets/footer.dart'; 
import '/views/widgets/main_background.dart'; 

class OrgNotification extends StatelessWidget {
  static const String pageRoute = '/org_notifications';
  const OrgNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPage(
      gradientStartColor: topGradientStart, 
      gradientEndColor: topGradientEnd,    
      pageTitle: "Notifications",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            
            decoration: const BoxDecoration(
              color: appBackgroundColor, 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), 
                topRight: Radius.circular(30),
              ),
              ),
            child: Column(
              children: [
              
                
                // Body Content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Column(
                      children: [
                        NotificationFilterRow(),
                        Expanded(child: NotificationList()),
                      ],
                    ),
                  ),
                ),
                // Footer
                const Footer(isOrganization: true,),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationFilterRow extends StatelessWidget {
  const NotificationFilterRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                       ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    height: 2,
                    width: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const badges_lib.Badge(
                badgeContent: Text(
                  '2',
                  style: TextStyle(color: Colors.black),
                ),
                badgeStyle: badges_lib.BadgeStyle(
                  badgeColor: Color(0xFFF2F4F6),
                  elevation: 0,
                ),
              ),

            ],
              ),
          const Row(
            children: [
              Text(
                'Unread',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              badges_lib.Badge(
                badgeContent: Text(
                  '2',
                  style: TextStyle(color: Colors.black),
                ),
                 badgeStyle: badges_lib.BadgeStyle(
                  badgeColor: Color(0xFFF2F4F6),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const Text(
            'Mark all as read',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const NotificationItem();
      },
    );
  }
}
class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 230, 244, 255),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE0E0E0),
                child: Text(
                  'AB',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ashwin Bose',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'is requesting to participate in x event',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                '2m',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(width: 8),
              Icon(Icons.more_vert, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appButtonColor,
                  minimumSize: const Size(80, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text('Accept', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.grey),
                  minimumSize: const Size(80, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Decline',
                  style: TextStyle(color: appButtonColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
