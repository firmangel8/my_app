import 'package:flutter/material.dart';

class ImageOverlayTextShadow extends StatelessWidget {
  final String imageUrl;
  final String text;

  const ImageOverlayTextShadow({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Network image with bottom box shadow
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 10.0), // Bottom shadow
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover, // Adjust as needed
            ),
          ),
        ),
        // Text overlay positioned on bottom
        Positioned(
          bottom: 16.0, // Adjust padding as needed
          left: 16.0, // Adjust padding as needed
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
