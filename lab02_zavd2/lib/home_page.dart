import 'package:flutter/material.dart';
import 'images_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth / 3.5;
    double imageHeight = imageWidth * 2 / 3;
    double sBWidth = screenWidth / 35;
    double fontSize = imageWidth / 10;
    double fontSizeB = imageWidth / 13.5;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 129, 127, 127),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Переглядач картинок',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageCard(context, '356', 'Porsche 356', imageWidth,
                  imageHeight, fontSizeB),
              SizedBox(width: sBWidth),
              _buildImageCard(context, '911', 'Porsche 911', imageWidth,
                  imageHeight, fontSizeB),
              SizedBox(width: sBWidth),
              _buildImageCard(context, '930', 'Porsche 930', imageWidth,
                  imageHeight, fontSizeB),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(BuildContext context, String category, String title,
      double width, double height, double fontSize) {
    return Card(
      color: Colors.white,
      elevation: 5, // Тінь
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: Image.asset(
              'assets/images/$category/1.jpg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImagesPage(category: category, title: title)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: Size(width / 1.2, height / 6),
                textStyle: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              child: Text(title),
            ),
          ),
        ],
      ),
    );
  }
}
