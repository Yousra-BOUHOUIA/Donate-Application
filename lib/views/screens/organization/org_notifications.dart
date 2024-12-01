import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges_lib; 
import 'package:donate_application/themes/colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
      body: const NotificationsBody(),
    );
  }
}

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

class NotificationFilterRow extends StatelessWidget {
  const NotificationFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
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
                      color: Colors.black, // Changed to black
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    height: 2,
                    width: 20,
                    color: Colors.blue, // Blue underline
                  ),
                ],
              ),
              const SizedBox(width: 8),
              badges_lib.Badge(
                badgeContent: const Text(
                  '2',
                  style: TextStyle(color: Colors.black),
                ),
                badgeStyle: const badges_lib.BadgeStyle(
                  badgeColor: Color(0xFFF2F4F6),
                  elevation: 0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Unread',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed to black
                ),
              ),
              const SizedBox(width: 8),
              badges_lib.Badge(
                badgeContent: const Text(
                  '2',
                  style: TextStyle(color: Colors.black),
                ),
                badgeStyle: const badges_lib.BadgeStyle(
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
              color: Colors.black, // Changed to black
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
        color: const Color.fromARGB(255, 230, 244, 255), // Light blue background
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE0E0E0),
                child: Text(
                  'AB',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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
              const Text(
                '2m',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.more_vert, size: 18, color: Colors.grey),
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
                child: const Text('Accept',style:TextStyle(color:Colors.white)),
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
