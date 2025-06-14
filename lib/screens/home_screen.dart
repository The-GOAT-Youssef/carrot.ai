import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carrot_ai/screens/code_view_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  final Color carrotYellow = const Color.fromARGB(255, 194, 190, 5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF232526),
                  const Color(0xFF414345),
                  carrotYellow.withOpacity(0.08),
                ]
              : [
                  carrotYellow.withOpacity(0.08),
                  const Color(0xFFF7F7E8),
                  Colors.white,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(24)),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.background.withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark ? Colors.black26 : Colors.grey.withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
                backgroundBlendMode: BlendMode.overlay,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Carrot.ai',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.3,
                      color: carrotYellow,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Remove background here, now handled by parent Container
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Animated carrot icon with glow
                    Center(
                      child: AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: carrotYellow
                                      .withOpacity(0.6 * _glowAnimation.value),
                                  blurRadius: 31 * _glowAnimation.value,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: child,
                          );
                        },
                        child: FaIcon(
                          FontAwesomeIcons.carrot,
                          size: 125,
                          color: carrotYellow,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Text(
                        'Build Flutter apps with AI',
                        style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: carrotYellow,
                            letterSpacing: 1.5,
                            fontSize: 39),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Glowing start button
                    Center(
                      child: AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: carrotYellow
                                      .withOpacity(0.45 * _glowAnimation.value),
                                  blurRadius: 24 * _glowAnimation.value,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: child,
                          );
                        },
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: carrotYellow,
                            foregroundColor:
                                isDark ? Colors.black : Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CodeViewScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Get Started',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.black : Colors.white,
                              letterSpacing: 1.1,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    // Horizontal feature cards for Preview Instantly, Export Anytime, and two new features
                    SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, i) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, i) {
                          final List<Map<String, dynamic>> smallFeatures = [
                            {
                              'icon': Icons.mobile_friendly,
                              'title': 'Preview Instantly',
                              'desc': 'See your app before exporting.',
                            },
                            {
                              'icon': Icons.developer_mode,
                              'title': 'Export Anytime',
                              'desc': 'Download production-ready Flutter code.',
                            },
                            {
                              'icon': Icons.security,
                              'title': 'Secure by Default',
                              'desc':
                                  'Your code and data are always protected.',
                            },
                            {
                              'icon': Icons.support_agent,
                              'title': '24/7 Support',
                              'desc':
                                  'Get help from our AI or human team anytime.',
                            },
                            {
                              'icon': Icons.devices,
                              'title': 'Multi-Platform',
                              'desc': 'Build for mobile, web, and desktop.',
                            },
                          ];
                          final feature = smallFeatures[i];
                          return Container(
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: theme.cardColor.withOpacity(0.93),
                              border: Border.all(
                                color: carrotYellow.withOpacity(0.25),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: carrotYellow.withOpacity(0.10),
                                  blurRadius: 7,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      height: 10), // Drop the icon down
                                  Icon(
                                    feature['icon'],
                                    color: carrotYellow,
                                    size: 28,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    feature['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onBackground,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Expanded(
                                    child: Text(
                                      feature['desc'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onBackground
                                            .withOpacity(0.7),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Replace with a Column of big feature cards
                    Column(
                      children: [
                        _BigFeatureCard(
                          icon: Icons.code,
                          title: 'Instant Code',
                          description: 'Generate Flutter code in seconds.',
                          color: carrotYellow,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 20),
                        _BigFeatureCard(
                          icon: Icons.design_services,
                          title: 'Modern UI',
                          description: 'Beautiful, ready-to-use designs.',
                          color: carrotYellow,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 20),
                        _BigFeatureCard(
                          icon: Icons.psychology_alt,
                          title: 'AI-Powered Creativity',
                          description:
                              'Carrot.ai uses advanced AI to help you design, code, and preview Flutter apps instantly. Get smart suggestions, beautiful UIs, and production-ready code in seconds.',
                          color: carrotYellow,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 20),
                        _BigFeatureCard(
                          icon: Icons.auto_awesome,
                          title: 'Your App, Your Way',
                          description:
                              'Describe your app idea and let Carrot.ai turn it into reality. Preview, edit, and export your app with ease. No coding experience required!',
                          color: carrotYellow,
                          isDark: isDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Divider(
                      color: Colors.grey.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Powered by Carrot.Ai 1.0',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color.fromARGB(255, 194, 190, 5),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isDark;
  const _BigFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isDark,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: isDark ? color.withOpacity(0.10) : color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.18), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 40),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark
                        ? Colors.white.withOpacity(0.85)
                        : Colors.black.withOpacity(0.85),
                    fontSize: 16,
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
