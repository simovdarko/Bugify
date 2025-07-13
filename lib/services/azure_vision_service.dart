import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../database/database.dart';
import '../models/insect_model.dart';

class AzureVisionService {


  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<InsectModel> processInsectImage(String imagePath, BuildContext context) async {
    try {
      final insectName = await recognizeInsect(imagePath);

      if (insectName == 'Unknown insect') {
        throw Exception("Инсектот не е препознаен.");
      }

      final locale = Localizations.localeOf(context).languageCode;
      final insectDetails = await getInsectDetailsFromOpenAI(insectName, locale);

      final insect = InsectModel(
        name: insectDetails['name'] ?? 'Unknown',
        description: insectDetails['description'] ?? '',
        activeTime: insectDetails['activeTime'] ?? '',
        location: insectDetails['location'] ?? '',
        dangerous: insectDetails['dangerous'] ?? false,
        diet: insectDetails['diet'] ?? '',
        scientificName: insectDetails['scientificName'] ?? '',
        imageUrl: imagePath,
        lastSeenTime: DateTime.now(),
        insectType: insectDetails['insectType'] ?? '',
        flowerPreference: insectDetails['flowerPreference'] ?? '',
        lifespan: insectDetails['lifespan'] ?? '',
        frequency: insectDetails['frequency'] ?? '',
        activityPeriod: insectDetails['activityPeriod'] ?? '',
        abilities: _parseAbilities(insectDetails['abilities']),
        size: (insectDetails['size'] as num?)?.toDouble() ?? 0.0,
        regions: _parseRegions(insectDetails['regions']),
      );

      await _dbHelper.addInsect(insect);

      return insect;
    } catch (e) {
      print('Error processing insect image: $e');
      rethrow;
    }
  }

  String _parseAbilities(dynamic abilities) {
    if (abilities is String) return abilities;
    if (abilities is List) return abilities.join(', ');
    return '';
  }

  String _parseRegions(dynamic regions) {
    if (regions is String) return regions;
    if (regions is List) return regions.join(', ');
    return '';
  }

  Future<String> recognizeInsect(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!file.existsSync()) {
        throw Exception("File not found: $imagePath");
      }

      final imageBytes = await file.readAsBytes();

      final uri = Uri.parse(
        "$visionEndpoint/customvision/v3.0/Prediction/$projectId/classify/iterations/$iterationName/image",
      );

      final response = await http.post(
        uri,
        headers: {
          'Prediction-Key': predictionKey,
          'Content-Type': 'application/octet-stream',
        },
        body: imageBytes,
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['predictions'] != null && result['predictions'].isNotEmpty) {
          final insectTag = result['predictions'][0]['tagName'] ?? 'Unknown insect';
          return insectTag;
        } else {
          throw Exception("No predictions found in the response.");
        }
      } else {
        throw Exception("Azure Vision error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print('Error recognizing insect: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getInsectDetailsFromOpenAI(String insectName, String locale) async {
    try {
      final isMacedonian = locale == 'mk';
      final systemPrompt = isMacedonian
          ? '''Ти си експерт по ентомологија. Одговори САМО со валиден JSON (без објаснување), со следниве полиња:
name, description, activeTime, location, dangerous (bool), diet, scientificName,
insectType, flowerPreference, lifespan, frequency, activityPeriod,
abilities (array), size (во сантиметри), regions (array).
СИТЕ вредности треба да бидат на македонски јазик.'''
          : '''You are an entomology expert. Respond ONLY with valid JSON (no explanation) containing the following fields:
name, description, activeTime, location, dangerous (bool), diet, scientificName,
insectType, flowerPreference, lifespan, frequency, activityPeriod,
abilities (array), size (in centimeters), regions (array).
ALL values must be in English. ''';

      final userPrompt = isMacedonian
          ? "Опиши го инсектот: $insectName. Одговорот да е на македонски во JSON формат."
          : "Describe the insect: $insectName. The answer must be in English and in JSON format.";

      final response = await http.post(
        Uri.parse(openAIEndpoint),
        headers: {
          "Content-Type": "application/json",
          "api-key": openAIKey,
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": systemPrompt},
            {"role": "user", "content": userPrompt}
          ],
          "temperature": 0.7,
          "max_tokens": 700,
        }),
      );

      if (response.statusCode == 200) {
        final decodedBody = json.decode(utf8.decode(response.bodyBytes));
        final content = decodedBody['choices'][0]['message']['content'];
        final insectDetails = json.decode(content) as Map<String, dynamic>;
        return insectDetails;
      } else {
        throw Exception("OpenAI API error: ${response.statusCode}");
      }
    } catch (e) {
      print('Error getting insect details from OpenAI: $e');
      return _getDefaultInsectDetails(insectName);
    }
  }

  Map<String, dynamic> _getDefaultInsectDetails(String name) {
    return {
      'name': name,
      'description': 'No description available',
      'activeTime': 'Unknown',
      'location': 'Unknown',
      'dangerous': false,
      'diet': 'Unknown',
      'scientificName': 'Unknown',
      'insectType': 'Unknown',
      'flowerPreference': 'Unknown',
      'lifespan': 'Unknown',
      'frequency': 'Unknown',
      'activityPeriod': 'Unknown',
      'abilities': [],
      'size': 0.0,
      'regions': [],
    };
  }

  Future<List<String>> getMultipleFunFacts(String locale) async {
    final isMacedonian = locale == 'mk';

    try {
      final systemPrompt = isMacedonian
          ? '''Дај ми три различни интересни факти за инсекти. Одговори како нумерирана листа со по еден ред за секој факт, на македонски.'''
          : '''Give me three different fun facts about insects. Respond as a numbered list, one sentence per fact, in English.''';

      final response = await http.post(
        Uri.parse(openAIEndpoint),
        headers: {
          "Content-Type": "application/json",
          "api-key": openAIKey,
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": systemPrompt},
            {"role": "user", "content": "Give me 3 fun facts about insects."}
          ],
          "temperature": 0.7,
          "max_tokens": 250,
        }),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(utf8.decode(response.bodyBytes));
        final content = decoded['choices'][0]['message']['content'] as String;

        // Раздвој по редови и филтрирај празни редови
        final facts = content
            .split(RegExp(r'\n+'))
            .map((line) => line.replaceFirst(RegExp(r'^\d+[).\s-]*'), '').trim())
            .where((line) => line.isNotEmpty)
            .toList();

        return facts.length >= 3 ? facts.sublist(0, 3) : facts;
      } else {
        throw Exception("OpenAI API error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching fun facts: $e");
      return [
        isMacedonian
            ? "Интересен факт не е достапен моментално."
            : "Fun fact is not available at the moment."
      ];
    }
  }



    }
