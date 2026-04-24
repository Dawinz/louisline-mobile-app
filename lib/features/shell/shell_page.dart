import 'package:flutter/material.dart';

import '../contact/contact_page.dart';
import '../gallery/gallery_page.dart';
import '../home/home_page.dart';
import '../routes/routes_page.dart';
import '../webview/webview_tab_page.dart';
import '../../theme/app_theme.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  static final List<_ShellTab> _tabs = [
    const _ShellTab(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: HomePage(),
    ),
    const _ShellTab(
      label: 'Routes',
      icon: Icons.alt_route_outlined,
      selectedIcon: Icons.alt_route,
      page: RoutesPage(),
    ),
    const _ShellTab(
      label: 'Book',
      icon: Icons.event_seat_outlined,
      selectedIcon: Icons.event_seat,
      page: WebViewTabPage(
        title: 'Book Ticket',
        url: 'https://www.louisline.co.tz/book',
      ),
    ),
    const _ShellTab(
      label: 'Gallery',
      icon: Icons.photo_library_outlined,
      selectedIcon: Icons.photo_library,
      page: GalleryPage(),
    ),
    const _ShellTab(
      label: 'Contact',
      icon: Icons.support_agent_outlined,
      selectedIcon: Icons.support_agent,
      page: ContactPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        child: KeyedSubtree(key: ValueKey(_index), child: _tabs[_index].page),
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
          destinations: _tabs
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
