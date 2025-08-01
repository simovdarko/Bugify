import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import 'recognition_screen.dart';
import 'history_screen.dart';
import 'about_screen.dart';
import 'fun_facts_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const HomeScreen({super.key, required this.onLocaleChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username') ?? '';
    setState(() {
      _username = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: Text(
                local.welcomeUser(_username),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _buildLanguageAndLogoutMenu(context, local),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: NetworkImage(
              'https://i.pinimg.com/564x/25/d0/5c/25d05c5abceb0d29b11e1bdd0793c11d.jpg',
            ),
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                                builder: (_) => InsectRecognitionScreen(
                                  onLocaleChange: widget.onLocaleChange,
                                ),
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
                                builder: (_) => HistoryScreen(
                                  onLocaleChange: widget.onLocaleChange,
                                ),
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
                              MaterialPageRoute(
                                builder: (_) => const AboutScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                        _buildActionCard(
                          context,
                          icon: Icons.lightbulb_outline,
                          label: local.funFacts,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FunFactsScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
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

  Widget _buildActionCard(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onPressed}) {
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

  Widget _buildLanguageAndLogoutMenu(BuildContext context, AppLocalizations local) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white),
      onSelected: (value) async {
        final prefs = await SharedPreferences.getInstance();
        if (value == 'mk') {
          widget.onLocaleChange(const Locale('mk'));
        } else if (value == 'en') {
          widget.onLocaleChange(const Locale('en'));
        } else if (value == 'logout') {
          await prefs.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => LoginScreen(onLocaleChange: widget.onLocaleChange),
            ),
                (route) => false,
          );
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
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              const Icon(Icons.logout, size: 20),
              const SizedBox(width: 8),
              Text(local.logout),
            ],
          ),
        ),
      ],
    );
  }
}
