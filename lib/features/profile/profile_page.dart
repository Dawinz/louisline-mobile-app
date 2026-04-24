import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CircleAvatar(radius: 38, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 14),
          Center(
            child: Text(
              'Louisline Passenger',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(height: 24),
          _ProfileTile(
            icon: Icons.phone,
            title: 'Support',
            subtitle: '0683 300 100',
          ),
          _ProfileTile(
            icon: Icons.chat_bubble_outline,
            title: 'WhatsApp',
            subtitle: 'Start support chat',
          ),
          _ProfileTile(
            icon: Icons.settings_outlined,
            title: 'Preferences',
            subtitle: 'Language, notifications, accessibility',
          ),
          _ProfileTile(
            icon: Icons.info_outline,
            title: 'About App',
            subtitle: 'Louisline Mobile v1.0.0',
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
