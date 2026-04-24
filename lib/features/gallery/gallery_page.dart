import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/fade_slide_in.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  static const images = [
    'assets/images/hero_1.jpeg',
    'assets/images/hero_2.jpeg',
    'assets/images/hero_3.jpeg',
    'assets/images/hero_4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.brandBlue, AppTheme.brandRed],
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        itemCount: images.length * 2,
        itemBuilder: (context, index) {
          final image = images[index % images.length];
          return FadeSlideIn(
            delay: Duration(milliseconds: 70 * (index % 6)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(image, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(140),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
