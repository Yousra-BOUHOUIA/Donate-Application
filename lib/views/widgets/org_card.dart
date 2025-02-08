import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../imports/organization_barrel.dart';

Widget createOrgCard(
  BuildContext context,
  String type,
  String title,
  String description,
  Widget image,
  int volunteers,
  int totalVolunteers, {
  Widget? detailsButton,
}) {
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
            value: volunteers / totalVolunteers,
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
                      if (type == 'donation') {
                        Navigator.pushNamed(
                          context,
                          OrgDonationDescriptionScreen.pageRoute,
                        );
                      } else if (type == 'event') {
                        Navigator.pushNamed(
                          context,
                          OrgEventDescriptionScreen.pageRoute,
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0E1F2F)), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.black, 
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
