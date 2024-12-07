import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../imports/user_barrel.dart';
import '../../imports/organization_barrel.dart';



const double cardWidth = 250;
const double cardHeight = 150;
const double chipSpacing = 10.0;
const EdgeInsets cardPadding = EdgeInsets.all(8.0);

// Reusable event card widget
Widget eventCard(BuildContext context,bool isOrganization,String description, String image, String statistics) {
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: cardPadding,
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 ElevatedButton(
                    onPressed: () {
                      if(isOrganization)
                      {
                            Navigator.pushNamed(context, OrgEventDescriptionScreen.pageRoute); 
                      }
                      else{
                         Navigator.pushNamed(context, UserEventDescriptionScreen.pageRoute); 
                      }
                             
                             
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appButtonColor, // Set the button background color to blue
                    ),
                    child: const Text(
                        'Learn More',
                        style: TextStyle(
                            color: Colors.white, // Set the text color to white
                          ),
                      ),
                  ),

                // Circle for Statistics
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: percentIndicator,
                  ),
                  child: Center(
                    child: Text(
                      statistics,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
