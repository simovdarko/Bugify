import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../l10n/app_localizations.dart';
import '../services/azure_vision_service.dart';
import '../screens/insect_description_screen.dart';
import '../screens/home_screen.dart';

class InsectRecognitionScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  const InsectRecognitionScreen({Key? key, required this.onLocaleChange}) : super(key: key);
  @override
  _InsectRecognitionScreenState createState() => _InsectRecognitionScreenState();
}

class _InsectRecognitionScreenState extends State<InsectRecognitionScreen> {
  final AzureVisionService _azureVisionService = AzureVisionService();
  final ImagePicker _picker = ImagePicker();

  Future<void> _recognizeInsect(String imagePath) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );

    try {
      final insect = await _azureVisionService.processInsectImage(imagePath,context);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InsectDescriptionScreen(insect: insect),
        ),
      );
    } catch (_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.recognitionError)),
      );
    }
  }

  Future<void> _getImage(bool fromCamera) async {
    final picked = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
    );
    if (picked != null) {
      await _recognizeInsect(picked.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.noImageSelected)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    loc.recognizeInsect,
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
                      _buildMainButton(
                        icon: Icons.camera_alt,
                        label: loc.camera,
                        onTap: () => _getImage(true),
                      ),
                      const SizedBox(height: 40),
                      _buildMainButton(
                        icon: Icons.photo,
                        label: loc.gallery,
                        onTap: () => _getImage(false),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen(onLocaleChange: widget.onLocaleChange)),
                  ),
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          loc.back,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
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

  Widget _buildMainButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 28),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Icon(icon, size: 60, color: const Color(0xFF004E32)),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004E32),
              ),
            )
          ],
        ),
      ),
    );
  }
}
