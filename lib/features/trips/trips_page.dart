import 'package:flutter/material.dart';

import '../../widgets/fade_slide_in.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trips')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, index) {
          return FadeSlideIn(
            delay: Duration(milliseconds: 80 * index),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.route)),
                title: Text('Route #${index + 1}'),
                subtitle: const Text('Departure 08:00 AM • 4h 15m'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
