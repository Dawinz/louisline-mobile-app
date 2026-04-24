import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/fade_slide_in.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({super.key});

  static const routes = [
    'Dar es Salaam -> Morogoro',
    'Dar es Salaam -> Ifakara',
    'Dar es Salaam -> Malinyi',
    'Morogoro -> Dar es Salaam',
    'Ifakara -> Dar es Salaam',
    'Malinyi -> Dar es Salaam',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.brandBlue, AppTheme.brandRed],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        itemCount: routes.length,
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
                leading: const CircleAvatar(
                  backgroundColor: Color(0x1A29388D),
                  child: Icon(Icons.alt_route, color: AppTheme.brandBlue),
                ),
                title: Text(
                  routes[index],
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Daily schedule and premium comfort service.',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
