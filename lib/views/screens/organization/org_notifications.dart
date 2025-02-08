import 'package:donate_application/views/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges_lib;
import '../../../databases/tables/notification.dart';
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';
import '../../widgets/main_background.dart';



class OrgNotification extends StatefulWidget {
  static const String pageRoute = '/org_notifications';
  const OrgNotification({super.key});

  @override
  _OrgNotificationState createState() => _OrgNotificationState();
}

class _OrgNotificationState extends State<OrgNotification> {
  List<Map<String, dynamic>> _notifications = [];
  final DBNotificationTable _notificationTable = DBNotificationTable();

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  /// Fetch notifications from the database
  Future<void> _fetchNotifications() async {
    final notifications = await _notificationTable.fetchNotificationsWithSenderName();
    setState(() {
      _notifications = notifications;
    });
  }

  /// Delete a notification
  Future<void> _deleteNotification(int notifId) async {
    await _notificationTable.deleteNotification(notifId);
    _fetchNotifications();
  }

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
                const NotificationFilterRow(),
                Expanded(
                  child: _notifications.isEmpty
                      ? const Center(child: Text("No notifications"))
                      : NotificationList(notifications: _notifications, onDelete: _deleteNotification),
                ),
                const Footer(isOrganization: true),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Notification filter UI
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
          const Column(
            children: [
              Text(
                'All',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 2),
              SizedBox(height: 2, width: 20, child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue))),
            ],
          ),
          badges_lib.Badge(
            badgeContent: Text(
              '2', // Replace with dynamic count if needed
              style: const TextStyle(color: Colors.black),
            ),
            badgeStyle: const badges_lib.BadgeStyle(
              badgeColor: Color(0xFFF2F4F6),
              elevation: 0,
            ),
          ),
          const Text(
            'Mark all as read',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

/// Notification list
class NotificationList extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;
  final Function(int) onDelete;

  const NotificationList({super.key, required this.notifications, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationItem(notification: notifications[index], onDelete: onDelete);
      },
    );
  }
}

/// Notification item
class NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;
  final Function(int) onDelete;

  const NotificationItem({super.key, required this.notification, required this.onDelete});

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
                  children: [
                    Text(
                      notification['username'] ?? 'Yousra', // Display username
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      notification['message'] ?? 'No message',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                notification['date_sent'] ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                onPressed: () {
                  // Accept logic
                },
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
                onPressed: () => onDelete(notification['notif_id']),
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
