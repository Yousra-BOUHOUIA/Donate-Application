import 'package:flutter/material.dart';
class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});
  static const pageRoute = '/product_description';
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> productDescription = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () { Navigator.pop(context); },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Horizontal Image Carousel
           Container(
              color: const Color(0xFFF4F8FF), // Light blue background
              height: 300,  // Increased height for the image
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  productDescription['image'] != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,  // Ensures full width
                          child: Image.memory(
                            productDescription['image'],
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
           
            // Product Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDescription['title'] ?? 'No title',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Colour: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productDescription['color'] ?? 'No color',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Condition: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productDescription['condition'] ?? 'No condition',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // User Information
            Container(
              color: const Color(0xFFDCE6F9), // Light blue for user info background
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "User: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productDescription['username'] ?? 'no username',

                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Contact: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productDescription['contact'] ?? 'No contact',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Location: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productDescription['location'] ?? 'No location',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}