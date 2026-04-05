import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LiveMapScreen extends StatelessWidget {
  const LiveMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final size = MediaQuery.of(context).size;
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          // Map gradient background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xFF142032), Color(0xFF071325)],
                  radius: 1.5,
                ),
              ),
            ),
          ),

          // Map satellite image
          Positioned.fill(
            child: IgnorePointer(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuA3xiTmrHLF_-t68ZtN_DUtkNUXbo1t1q3VtVtVjxZZ9MQ3Jxwu69SS1NARTUlU0F8Bc1VZj1YFqI-F-HScZyfOOIihxZZitebYk2BinFvxBaeNl6RA5UcFdXLK9RoAnNl1eaMmLOOfHUS6FqPlN7Bd_qP3wqqLRgisiC4gYmnVGRg7uZX1aCzxR4aybBPu0Z8kAnTswSDx5ukaDUUnUi2RkHMdzATGGGjW5dIAjmP7TA-bdvAr4Tb4_ZvTGzzgcqUk3ffPYK3Vxlij',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.4),
                color: Colors.white24,
                colorBlendMode: BlendMode.luminosity,
              ),
            ),
          ),

          // Target pin
          Positioned(
            top: size.height * 0.4,
            left: size.width * 0.65,
            child: const Icon(
              Icons.location_on,
              color: Color(0xFF00E676),
              size: 48,
              shadows: [Shadow(color: Color(0xCC00E676), blurRadius: 10)],
            ),
          ),

          // Distant pin (dimmed)
          Positioned(
            top: size.height * 0.25,
            left: size.width * 0.3,
            child: const Opacity(
              opacity: 0.4,
              child: Icon(Icons.location_on, color: Color(0xFF00E676), size: 36),
            ),
          ),

          // Animated truck icon
          const Center(child: _AnimatedPulseRing()),

          // Top header
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              color: const Color(0xFF071325),
              padding: EdgeInsets.only(top: topPad, bottom: 16, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.navigation, color: Color(0xFF00E676)),
                      SizedBox(width: 12),
                      Text(
                        'ECO TRACK',
                        style: TextStyle(color: Color(0xFF00E676), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 3),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 8, height: 8,
                        child: DecoratedBox(decoration: BoxDecoration(color: Color(0xFF00E676), shape: BoxShape.circle)),
                      ),
                      const SizedBox(width: 8),
                      const Text('ONLINE', style: TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(width: 16),
                      Material(
                        color: const Color(0x801F2A3D),
                        shape: const CircleBorder(),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(28),
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                          child: const SizedBox(
                            width: 56, height: 56,
                            child: Icon(Icons.account_circle, color: Color(0xFF00E676), size: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom bar
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              height: 48,
              color: const Color(0xFF071325),
              alignment: Alignment.center,
              child: Container(
                width: 96, height: 4,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedPulseRing extends StatefulWidget {
  const _AnimatedPulseRing();

  @override
  State<_AnimatedPulseRing> createState() => _AnimatedPulseRingState();
}

class _AnimatedPulseRingState extends State<_AnimatedPulseRing> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final glow = (1 - _ctrl.value) * 0.7;
        return Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 230, 118, glow),
                blurRadius: _ctrl.value * 20,
                spreadRadius: _ctrl.value * 15,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFF00E676), shape: BoxShape.circle),
            child: const Icon(Icons.local_shipping, color: Color(0xFF003918), size: 32),
          ),
        );
      },
    );
  }
}
