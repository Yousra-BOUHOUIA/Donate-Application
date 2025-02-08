import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges_lib;
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';
import '../../widgets/main_background.dart';


class UserNotification extends StatelessWidget {
  const UserNotification({super.key});
  static const String pageRoute = '/user_notifications';

  @override
  Widget build(BuildContext context) {
    return GradientPage(
      gradientStartColor: topGradientStart, // Replace with your gradient start color
      gradientEndColor: topGradientEnd,    // Replace with your gradient end color
      pageTitle: "Notifications",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            
            decoration: const BoxDecoration(
              color: appBackgroundColor, // White background
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), // Top left radius
                topRight: Radius.circular(30), // Top right radius
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
                const Footer(isOrganization: false,),
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
      shrinkWrap: true, // Prevent ListView from taking more space than needed
      physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
      itemCount: 2,
      itemBuilder: (context, index) {
        return const NotificationItem(isBlue: true); 
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final bool isBlue;
  const NotificationItem({super.key, required this.isBlue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: isBlue ? const Color.fromARGB(255, 230, 244, 255) : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Stack(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://www.example.com/profile_pic.png'),
            ),
            if (isBlue) // Display blue dot if unread
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: const Text('Hilal Ahmar'),
        subtitle: Text(
          isBlue
              ? 'has accepted your request to participate on event x'
              : 'has accepted your request to participate on event y',
        ),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('2m ago'),
            SizedBox(width: 8.0),
            Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
