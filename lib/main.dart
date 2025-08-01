import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final locale = await _getSavedLocale();
  runApp(MyApp(initialLocale: locale));
}

Future<Locale> _getSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('locale') ?? 'mk';
  return Locale(languageCode);
}

Future<void> _saveLocale(Locale locale) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('locale', locale.languageCode);
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    _saveLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bugify',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('mk'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SplashScreen(onLocaleChange: setLocale),
      routes: {
        '/login': (context) => LoginScreen(onLocaleChange: setLocale),
        '/register': (context) => RegisterScreen(onLocaleChange: setLocale),
        '/home': (context) => HomeScreen(onLocaleChange: setLocale),
      },
    );
  }
}
