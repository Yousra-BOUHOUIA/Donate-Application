import 'package:flutter/material.dart';
import '/themes/colors.dart';

class DonationDescriptionScreen extends StatelessWidget {
  const DonationDescriptionScreen({super.key});
  static const pageRoute = '/donation_description';


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
     

     
      appBar: AppBar(
    backgroundColor: Colors.transparent, // Make AppBar background transparent
    elevation: 0, 
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: const Text("Details"),
  ),
      body: Container(
            padding: const EdgeInsets.all(4),
             decoration: const BoxDecoration(
                      color: appBackgroundColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
          
            child: Stack(
              children: [
                
                Positioned(
                  
                  left: 0,
                  top: 10, 
                  child: Container(
                    width: screenWidth*0.97,
                    height: 250, // Height for the gradient top section
                    decoration:BoxDecoration(
                      
                        color:Colors.black,
                       borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            
                // Main content section below gradient
                Positioned(
                  left: 0,
                  top: 250 ,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight - 250, 
                   padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                   
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Location in rounded container
                          const Text(
                            "Share Your Food, Share Your Love",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: const Row(
                                  children: [
                                    Icon(Icons.location_on, color: Colors.grey, size: 18),
                                    SizedBox(width: 4),
                                    Text(
                                      "Algiers",
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
            
                          // Progress bar and stats
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const LinearProgressIndicator(
                                    value: 0.75, // Progress as a percentage
                                    backgroundColor:  Color(0xFFF1EBFF),
                                    color: percentIndicator,
                                    minHeight: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Collected \$150,000",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Description_Text),
                              ),
                              Text(
                                "20 days to go",
                                style: TextStyle(fontSize: 14, color: Description_Text),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
            
                          // Description with "Show More" button
                          RichText(
                            text: const TextSpan(
                              text: "Lorem ipsum dolor sit amet consectetur. Ultricies ut augue amet vel hac. "
                                  "Ut orci adipiscing fusce lacus lectus rhoncus. Lorem ipsum dolor sit amet, "
                                  "consectetur adipiscing elit, sed ... ",
                              style: TextStyle(fontSize: 14, color:  Description_Text),
                              children: [
                                TextSpan(
                                  text: "Show More",
                                  style: TextStyle(
                                    color: Color(0xFF666D80),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
            
                          // Verified account section
                          const Row(
                            children: [
                              Text(
                                "Social Project",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.verified,
                                color: Color(0xFF36394A),
                                size: 18,
                              ),
                            ],
                          ),
                          const Text(
                            "Verified Account",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
      
    );
  }
}
