import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'recognition_screen.dart';
import 'history_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  const HomeScreen({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          _buildLanguageMenu(context),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: NetworkImage('https://i.pinimg.com/564x/25/d0/5c/25d05c5abceb0d29b11e1bdd0793c11d.jpg'),
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.3)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    local.homeTitle,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionCard(
                        context,
                        icon: Icons.bug_report,
                        label: local.scanInsect,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => InsectRecognitionScreen(onLocaleChange: onLocaleChange),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      _buildActionCard(
                        context,
                        icon: Icons.history,
                        label: local.history,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HistoryScreen(onLocaleChange: onLocaleChange),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      _buildActionCard(
                        context,
                        icon: Icons.info_outline,
                        label: local.about,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AboutScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: const Color(0xFF004E32)),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004E32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white),
      onSelected: (value) {
        if (value == 'mk') {
          onLocaleChange(const Locale('mk'));
        } else if (value == 'en') {
          onLocaleChange(const Locale('en'));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'mk',
          child: Row(
            children: [
              Image.asset('assets/flags/mk.png', width: 24, height: 24),
              const SizedBox(width: 8),
              const Text('Македонски'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              Image.asset('assets/flags/en.png', width: 24, height: 24),
              const SizedBox(width: 8),
              const Text('English'),
            ],
          ),
        ),
      ],
    );
  }
}
