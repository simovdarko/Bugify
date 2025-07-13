// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bugify';

  @override
  String get splashSubtitle => 'Insect Identification';

  @override
  String get homeTitle => 'Main menu';

  @override
  String get recognizeInsect => 'Recognize Insect';

  @override
  String get history => 'Insect History';

  @override
  String get about => 'About App';

  @override
  String get back => 'Back';

  @override
  String get noHistory => 'No recognition history found';

  @override
  String deleteConfirmation(Object insectName) {
    return 'Are you sure you want to delete \"$insectName\"?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get developedBy => 'Developed by: Andreja Dimkovski, Darko Simov\nFINKI, 2025';

  @override
  String get version => 'Version: 1.0.0';

  @override
  String get notThisInsect => 'Not this insect? Scan again';

  @override
  String get fromCamera => 'Camera';

  @override
  String get fromGallery => 'Gallery';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get recognitionError => 'Error recognizing the insect';

  @override
  String get details => 'DETAILS';

  @override
  String get region => 'Regions';

  @override
  String get activePeriod => 'Active Period';

  @override
  String get flowerPreference => 'Preferred Plants';

  @override
  String get diet => 'Diet';

  @override
  String get dangerous => 'Dangerous';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get type => 'Type';

  @override
  String get size => 'Size';

  @override
  String get lifespan => 'Lifespan';

  @override
  String get backToMenu => 'Back to Main Menu';

  @override
  String get aboutAppTitle => 'About the App';

  @override
  String get aboutAppDescription1 => 'Bugify is a mobile application that uses artificial intelligence to recognize insects from images.';

  @override
  String get aboutAppDescription2 => 'With this app you can:\n\n• Scan insects via camera or gallery\n• View detailed information\n• Browse scanning history\n• Learn more about the insects around you';

  @override
  String get aboutTitle => 'About the App';

  @override
  String get aboutIntro => 'Bugify is a mobile application that uses artificial intelligence to recognize insects from images.';

  @override
  String get aboutFeatures => 'With this app you can:\n\n• Scan insects via camera or gallery\n• View detailed information\n• Browse scan history\n• Learn more about local insects';

  @override
  String get aboutCredits => 'Developed by: Andreja Dimkovski, Darko Simov\nFINKI, 2025';

  @override
  String get confirmDelete => 'Are you sure you want to delete?';

  @override
  String seenOn(Object dateTime) {
    return 'Seen on: $dateTime';
  }

  @override
  String get scanInsect => 'Scan Insect';

  @override
  String get retryScan => 'Not this insect? Scan again';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get showAnotherFact => 'Show Another Fact';

  @override
  String get funFactTitle => 'Fun Insect Fact';

  @override
  String get funFacts => 'Fun Facts';
}
