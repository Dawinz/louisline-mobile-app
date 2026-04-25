import 'package:flutter/material.dart';

import '../book/book_page.dart';
import '../contact/contact_page.dart';
import '../gallery/gallery_page.dart';
import '../home/home_page.dart';
import '../../localization/app_text.dart';
import '../routes/routes_page.dart';
import '../../theme/app_theme.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _ShellTab(
        label: context.t('home'),
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        page: const HomePage(),
      ),
      _ShellTab(
        label: context.t('routes'),
        icon: Icons.alt_route_outlined,
        selectedIcon: Icons.alt_route,
        page: const RoutesPage(),
      ),
      _ShellTab(
        label: context.t('book'),
        icon: Icons.event_seat_outlined,
        selectedIcon: Icons.event_seat,
        page: const NativeBookPage(),
      ),
      _ShellTab(
        label: context.t('gallery'),
        icon: Icons.photo_library_outlined,
        selectedIcon: Icons.photo_library,
        page: const GalleryPage(),
      ),
      _ShellTab(
        label: context.t('contact'),
        icon: Icons.support_agent_outlined,
        selectedIcon: Icons.support_agent,
        page: const ContactPage(),
      ),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final slide = Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slide, child: child),
          );
        },
        child: KeyedSubtree(key: ValueKey(_index), child: tabs[_index].page),
      ),
      floatingActionButton: PopupMenuButton<AppLanguage>(
        tooltip: context.t('language'),
        icon: const Icon(Icons.language_rounded),
        onSelected: (value) => LocaleScope.of(context).setLanguage(value),
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: AppLanguage.en,
            child: Text('English'),
          ),
          PopupMenuItem(
            value: AppLanguage.sw,
            child: Text('Kiswahili'),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: AppTheme.brandBlue.withAlpha(24),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              color: selected ? AppTheme.brandBlue : const Color(0xFF64748B),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: tabs
              .map(
                (tab) => NavigationDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.selectedIcon),
                  label: tab.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ShellTab {
  const _ShellTab({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;
}
