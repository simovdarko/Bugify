import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/azure_vision_service.dart';

class FunFactsScreen extends StatefulWidget {
  const FunFactsScreen({super.key});

  @override
  _FunFactsScreenState createState() => _FunFactsScreenState();
}

class _FunFactsScreenState extends State<FunFactsScreen> {
  List<String> _facts = [];
  bool _isLoading = true;
  late String _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context).languageCode;
    _generateFacts();
  }

  Future<void> _generateFacts() async {
    setState(() {
      _isLoading = true;
      _facts.clear();
    });

    try {
      final facts = await AzureVisionService().getMultipleFunFacts(_locale);
      setState(() {
        _facts = facts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _facts = [
          _locale == 'mk'
              ? 'Не можевме да вчитаме факти.'
              : 'Failed to load fun facts.'
        ];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/564x/25/d0/5c/25d05c5abceb0d29b11e1bdd0793c11d.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  local.funFacts,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _isLoading
                      ? const Center(
                      child: CircularProgressIndicator(color: Colors.green))
                      : Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _facts.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _facts[index],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _generateFacts,
                  icon: const Icon(Icons.refresh),
                  label: Text(local.showAnotherFact),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: Text(
                    local.backToMenu,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
