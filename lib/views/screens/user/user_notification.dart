import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges_lib; // Alias the badges package
import '/themes/colors.dart';
import '/views/widgets/footer.dart';




class UserNotification extends StatelessWidget {
  const UserNotification({super.key});
  static const pageRoute = '/user_notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: appBarColor,
      ),
      backgroundColor: appBackgroundColor,
     body: Column(
        children: const [
          const Expanded(child: NotificationsBody()),  // Make sure NotificationsBody takes available space
          const Footer(),  // Add Footer here to be visible on the NotificationsPage
        ],
      ),
    );
  }
}

// Body content for notifications page
class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
       
        children: const [
          NotificationFilterRow(),
          
          Expanded(child: NotificationList()),
        ],
      );
    
  }
}

// Filter row with badges
class NotificationFilterRow extends StatelessWidget {
  const NotificationFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width:double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('All'),
          badges_lib.Badge(
            badgeContent: const Text(
              '1',
              style: TextStyle(color: Colors.black),
            ),
            badgeStyle: const badges_lib.BadgeStyle(
              badgeColor: Color(0xFFF2F4F6),
              elevation: 0,
            ),
          ),
          const Text('Unread'),
          badges_lib.Badge(
            badgeContent: const Text(
              '1',
              style: TextStyle(color:Colors.black),
            ),
            badgeStyle: const badges_lib.BadgeStyle(
              badgeColor: Color(0xFFF2F4F6),
              elevation: 0,
            ),
          ),
          const Text('Mark all as read'),
        ],
      ),
    );
  }
}

// Notification list widget
class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, // Only two notifications
      itemBuilder: (context, index) {
        return NotificationItem(isBlue: index == 0); 
      },
    );
  }
}

// Individual notification item
class NotificationItem extends StatelessWidget {
  final bool isBlue;
  const NotificationItem({super.key, required this.isBlue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10),
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
                  decoration: BoxDecoration(
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('2m ago'),
            SizedBox(width: 8.0),
            Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
