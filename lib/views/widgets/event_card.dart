import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../imports/user_barrel.dart';
import '../../imports/organization_barrel.dart';

const double cardWidth = 250;
const double cardHeight = 150;

// Reusable event card widget
Widget eventCard(BuildContext context, bool isOrganization, String image) {
  return Container(
    width: cardWidth,
    height: cardHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
      color: Colors.black.withOpacity(0.4),
    ),
    child: InkWell(
      onTap: () {
        // Navigate based on whether it's an organization or user
        if (isOrganization) {
          Navigator.pushNamed(context, OrgEventDescriptionScreen.pageRoute);
        } else {
          Navigator.pushNamed(context, UserEventDescriptionScreen.pageRoute);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.4), // Optional, keeps overlay effect
        ),
      ),
    ),
  );
}
