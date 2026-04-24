import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/fade_slide_in.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.brandBlue, AppTheme.brandRed],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: const [
            FadeSlideIn(child: _ContactHero()),
            SizedBox(height: 14),
            FadeSlideIn(
              delay: Duration(milliseconds: 120),
              child: _ContactTile(
                icon: Icons.place_outlined,
                title: 'Address',
                value: 'Urafiki, Dar es Salaam, Tanzania',
              ),
            ),
            FadeSlideIn(
              delay: Duration(milliseconds: 180),
              child: _ContactTile(
                icon: Icons.phone_outlined,
                title: 'Mobile',
                value: '0683 300 100, 0798 700 700',
              ),
            ),
            FadeSlideIn(
              delay: Duration(milliseconds: 240),
              child: _ContactTile(
                icon: Icons.chat_outlined,
                title: 'WhatsApp',
                value: '0683 300 100',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactHero extends StatelessWidget {
  const _ContactHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.brandBlue, AppTheme.brandRed],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Need assistance? Our support team is available daily for booking and route inquiries.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.brandBlue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(value),
      ),
    );
  }
}
