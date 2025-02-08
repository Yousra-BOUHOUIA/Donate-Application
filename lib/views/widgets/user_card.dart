import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../imports/user_barrel.dart';
import 'package:donate_application/databases/tables/notification.dart';

String btntext = ' ';

// Instantiate the notification table class
final DBNotificationTable notificationTable = DBNotificationTable();

Widget createUserCard(
  BuildContext context,
  String type,
  String title,
  String description,
  Widget image,
  int volunteers,
  int totalVolunteers, {
  Widget? detailsButton,
  int? campaignId, 
  int? userId,
}) {
  if (type == 'donate') {
    btntext = 'Donate Now';
  } else if (type == 'event') {
    btntext = 'Participate Now';
  } else {
    btntext = ''; 
  }

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    color: appBackgroundColor,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: image,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Recruited Volunteers: $volunteers / $totalVolunteers',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: totalVolunteers > 0 ? volunteers / totalVolunteers : 0,
            backgroundColor: Colors.grey[300],
            color: appButtonColor,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              detailsButton ??
                  OutlinedButton(
                    onPressed: () {
                      if (type == 'donate') {
                        Navigator.pushNamed(context, UserDonationDescriptionScreen.pageRoute);
                      } else if (type == 'event') {
                        Navigator.pushNamed(context, UserEventDescriptionScreen.pageRoute);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0E1F2F)),
                    ),
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Color(0xFF0E1F2F),
                      ),
                    ),
                  ),
 ElevatedButton(
  onPressed: () async {
    if (type == 'donate') {
      Navigator.pushNamed(context, AddDonationScreen.pageRoute);
    } else if (type == 'event') {
      await notificationTable.insertNotification(
        1, 
        1, 
        'Participant is requesting to participate in the event: $title',
      );

      
      print("Notification sent to receiver ID 1");

showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Softer edges
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.celebration, // Celebration Icon for a festive touch
            color: Color(0xFF27425D),
            size: 60,
          ),
          const SizedBox(height: 12),
          const Text(
            "THANK YOU!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF27425D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "A notification was sent to the organization hosting the event. "
            "You will be contacted soon!",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
        ],
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF27425D),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  },
);

    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF27425D),
  ),
  child: Text(
    btntext.isNotEmpty ? btntext : 'Donate now',
    style: const TextStyle(
      color: Colors.white,
    ),
  ),
),

            ],
          ),
        ],
      ),
    ),
  );
}
