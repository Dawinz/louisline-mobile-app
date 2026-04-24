import 'package:flutter/material.dart';

class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.beginOffset = const Offset(0, 0.08),
  });

  final Widget child;
  final Duration delay;
  final Offset beginOffset;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, widget) {
        return AnimatedOpacity(
          opacity: value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          child: Transform.translate(
            offset: Offset(
              beginOffset.dx * (1 - value) * 100,
              beginOffset.dy * (1 - value) * 100,
            ),
            child: widget,
          ),
        );
      },
      child: FutureBuilder<void>(
        future: Future<void>.delayed(delay),
        builder: (context, snapshot) => child,
      ),
    );
  }
}
