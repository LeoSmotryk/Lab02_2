import 'package:flutter/material.dart';

class ImagesPage extends StatefulWidget {
  final String category;
  final String title;

  const ImagesPage({super.key, required this.category, required this.title});

  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  int currentIndex = 0;

  void _nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % 3;
    });
  }

  void _previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + 3) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth / 3.5;
    double imageHeight = imageWidth * 2 / 3;
    double sideImageWidth = imageWidth * 0.6;
    double sideImageHeight = sideImageWidth * 2 / 3;
    double fontSize = imageWidth / 10;
    double fontSizeB = imageWidth / 18;
    double iconSize = imageHeight / 3;
    double iconPadding = screenWidth / 35;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Stack(
                    key: ValueKey<int>(currentIndex),
                    alignment: Alignment.center,
                    children: [
                      _buildSideImage((currentIndex - 1 + 3) % 3,
                          sideImageWidth, sideImageHeight, -imageWidth),
                      _buildMainImage(currentIndex, imageWidth, imageHeight),
                      _buildSideImage((currentIndex + 1) % 3, sideImageWidth,
                          sideImageHeight, imageWidth),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    fixedSize: Size(imageWidth / 1.4, imageHeight / 7),
                    textStyle: TextStyle(
                      fontSize: fontSizeB,
                    ),
                  ),
                  child: const Text('Назад на головну'),
                ),
              ],
            ),
          ),
          _buildNavigationButton(Icons.chevron_left, _previousImage,
              Alignment.centerLeft, iconSize, iconPadding),
          _buildNavigationButton(Icons.chevron_right, _nextImage,
              Alignment.centerRight, iconSize, iconPadding),
        ],
      ),
    );
  }

  Widget _buildMainImage(int index, double width, double height) {
    return ClipRRect(
      key: ValueKey<int>(index),
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/${widget.category}/${index + 1}.jpg',
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _errorPlaceholder(width, height),
      ),
    );
  }

  Widget _buildSideImage(
      int index, double width, double height, double offsetX) {
    return Transform.translate(
      offset: Offset(offsetX, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ClipRRect(
          key: ValueKey<int>(index),
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/images/${widget.category}/${index + 1}.jpg',
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _errorPlaceholder(width, height),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed,
      Alignment alignment, double iconSize, double iconPadding) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: iconPadding),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: iconSize, color: Colors.white),
        ),
      ),
    );
  }

  Widget _errorPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[800],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.white),
      ),
    );
  }
}
