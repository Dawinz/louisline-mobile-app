import 'package:flutter/material.dart';

import '../../localization/app_text.dart';
import '../../theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _pageIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _OnboardingItem(
        title: context.t('onboard1Title'),
        subtitle: context.t('onboard1Sub'),
        image: 'assets/images/hero_1.jpeg',
      ),
      _OnboardingItem(
        title: context.t('onboard2Title'),
        subtitle: context.t('onboard2Sub'),
        image: 'assets/images/hero_2.jpeg',
      ),
      _OnboardingItem(
        title: context.t('onboard3Title'),
        subtitle: context.t('onboard3Sub'),
        image: 'assets/images/hero_3.jpeg',
      ),
    ];
    final isLast = _pageIndex == items.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.brandBlue,
                    const Color(0xFF4D1FA7),
                    AppTheme.darkBg,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: widget.onGetStarted,
                    child: Text(
                      context.t('skip'),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: items.length,
                    onPageChanged: (index) =>
                        setState(() => _pageIndex = index),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'onboarding-image-$index',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: Image.asset(
                                    item.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                  child: Row(
                    children: [
                      ...List.generate(
                        items.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          margin: const EdgeInsets.only(right: 8),
                          width: _pageIndex == index ? 28 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            color: _pageIndex == index
                                ? AppTheme.brandAmber
                                : Colors.white30,
                          ),
                        ),
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.brandAmber,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (isLast) {
                            widget.onGetStarted();
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeOutCubic,
                            );
                          }
                        },
                        icon: Icon(
                          isLast
                              ? Icons.check_circle_outline
                              : Icons.arrow_forward_rounded,
                        ),
                        label: Text(
                          isLast ? context.t('getStarted') : context.t('next'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextButton.icon(
                    onPressed: () {
                      final scope = LocaleScope.of(context);
                      scope.setLanguage(
                        scope.language == AppLanguage.en
                            ? AppLanguage.sw
                            : AppLanguage.en,
                      );
                    },
                    icon: const Icon(Icons.language, color: Colors.white70),
                    label: Text(
                      context.appLanguage == AppLanguage.en
                          ? 'Kiswahili'
                          : 'English',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingItem {
  const _OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;
}
