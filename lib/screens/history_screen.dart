import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database.dart';
import '../l10n/app_localizations.dart';
import '../models/insect_model.dart';
import 'insect_description_screen.dart';
import 'home_screen.dart';

class HistoryScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  const HistoryScreen({Key? key, required this.onLocaleChange}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<InsectModel>>? insectHistory;
  int? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserAndRefreshHistory();
  }

  Future<void> _loadCurrentUserAndRefreshHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username != null) {
      final user = await DatabaseHelper.instance.getUserByUsername(username);
      if (user != null) {
        setState(() {
          _currentUserId = user.id;
          insectHistory = DatabaseHelper.instance.getInsectsByUser(_currentUserId!);
        });
        return;
      }
    }

    setState(() {
      insectHistory = Future.value([]);
    });
  }

  void _refreshInsectHistory() {
    if (_currentUserId != null) {
      setState(() {
        insectHistory = DatabaseHelper.instance.getInsectsByUser(_currentUserId!);
      });
    }
  }

  void _confirmDelete(BuildContext context, InsectModel insect) {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(local.delete, style: const TextStyle(color: Color(0xFF2E7D32))),
        content: Text('${local.confirmDelete} "${insect.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(local.cancel, style: const TextStyle(color: Color(0xFF2E7D32))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await DatabaseHelper.instance.deleteInsect(insect.id!);
              _refreshInsectHistory();
            },
            child: Text(local.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/564x/25/d0/5c/25d05c5abceb0d29b11e1bdd0793c11d.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                local.history,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<InsectModel>>(
                  future: insectHistory,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          local.noHistory,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    final insects = snapshot.data!;

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 80),
                      itemCount: insects.length,
                      itemBuilder: (context, index) {
                        final insect = insects[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InsectDescriptionScreen(
                                    insect: insect,
                                    showRetryButton: false,
                                  ),
                                ),
                              ).then((_) => _refreshInsectHistory());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green[50],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: insect.imageUrl.isNotEmpty && File(insect.imageUrl).existsSync()
                                          ? Image.file(File(insect.imageUrl), fit: BoxFit.cover)
                                          : const Center(
                                        child: Icon(Icons.bug_report, size: 40, color: Color(0xFF2E7D32)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          insect.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[800],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _confirmDelete(context, insect),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(onLocaleChange: widget.onLocaleChange)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        local.backToMenu,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
