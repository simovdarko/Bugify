import 'dart:io';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/insect_model.dart';

class InsectDescriptionScreen extends StatelessWidget {
  final InsectModel insect;
  final bool showRetryButton;

  const InsectDescriptionScreen({
    Key? key,
    required this.insect,
    this.showRetryButton = true,
  }) : super(key: key);

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
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: insect.imageUrl.isNotEmpty && File(insect.imageUrl).existsSync()
                            ? Image.file(File(insect.imageUrl), fit: BoxFit.cover)
                            : Center(
                          child: Icon(Icons.bug_report, size: 100, color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: ListView(
                      children: [
                        Center(
                          child: Text(
                            insect.name.toUpperCase(),
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          insect.description,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(local.details,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildDetailCard(Icons.public, local.region, insect.regions),
                            _buildDetailCard(Icons.access_time, local.activePeriod, insect.activeTime),
                            _buildDetailCard(Icons.nature, local.flowerPreference, insect.flowerPreference),
                            _buildDetailCard(Icons.restaurant, local.diet, insect.diet),
                            _buildDetailCard(Icons.warning, local.dangerous, insect.dangerous ? local.yes : local.no),
                            _buildDetailCard(Icons.category, local.type, insect.insectType),
                            _buildDetailCard(Icons.height, local.size, "${insect.size} см"),
                            _buildDetailCard(Icons.calendar_today, local.lifespan, insect.lifespan),
                          ],
                        ),
                        const SizedBox(height: 28),
                        if (showRetryButton)
                          ElevatedButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.replay, color: Colors.white),
                            label: Text(local.retryScan),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox();

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160, maxWidth: 160, minHeight: 150),
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, size: 22, color: Colors.black87),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87), textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 12, color: Colors.black87), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
