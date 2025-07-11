import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_mk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('mk')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bugify'**
  String get appTitle;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Insect Identification'**
  String get splashSubtitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Insect Identification'**
  String get homeTitle;

  /// No description provided for @recognizeInsect.
  ///
  /// In en, this message translates to:
  /// **'Recognize Insect'**
  String get recognizeInsect;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'Insect History'**
  String get history;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get about;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No recognition history found'**
  String get noHistory;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{insectName}\"?'**
  String deleteConfirmation(Object insectName);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by: Andreja Dimkovski, Darko Simov\nFINKI, 2025'**
  String get developedBy;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version: 1.0.0'**
  String get version;

  /// No description provided for @notThisInsect.
  ///
  /// In en, this message translates to:
  /// **'Not this insect? Scan again'**
  String get notThisInsect;

  /// No description provided for @fromCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get fromCamera;

  /// No description provided for @fromGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get fromGallery;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @recognitionError.
  ///
  /// In en, this message translates to:
  /// **'Error recognizing the insect'**
  String get recognitionError;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'DETAILS'**
  String get details;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get region;

  /// No description provided for @activePeriod.
  ///
  /// In en, this message translates to:
  /// **'Active Period'**
  String get activePeriod;

  /// No description provided for @flowerPreference.
  ///
  /// In en, this message translates to:
  /// **'Preferred Plants'**
  String get flowerPreference;

  /// No description provided for @diet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get diet;

  /// No description provided for @dangerous.
  ///
  /// In en, this message translates to:
  /// **'Dangerous'**
  String get dangerous;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @lifespan.
  ///
  /// In en, this message translates to:
  /// **'Lifespan'**
  String get lifespan;

  /// No description provided for @backToMenu.
  ///
  /// In en, this message translates to:
  /// **'Back to Main Menu'**
  String get backToMenu;

  /// No description provided for @aboutAppTitle.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutAppTitle;

  /// No description provided for @aboutAppDescription1.
  ///
  /// In en, this message translates to:
  /// **'Bugify is a mobile application that uses artificial intelligence to recognize insects from images.'**
  String get aboutAppDescription1;

  /// No description provided for @aboutAppDescription2.
  ///
  /// In en, this message translates to:
  /// **'With this app you can:\n\n• Scan insects via camera or gallery\n• View detailed information\n• Browse scanning history\n• Learn more about the insects around you'**
  String get aboutAppDescription2;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutTitle;

  /// No description provided for @aboutIntro.
  ///
  /// In en, this message translates to:
  /// **'Bugify is a mobile application that uses artificial intelligence to recognize insects from images.'**
  String get aboutIntro;

  /// No description provided for @aboutFeatures.
  ///
  /// In en, this message translates to:
  /// **'With this app you can:\n\n• Scan insects via camera or gallery\n• View detailed information\n• Browse scan history\n• Learn more about local insects'**
  String get aboutFeatures;

  /// No description provided for @aboutCredits.
  ///
  /// In en, this message translates to:
  /// **'Developed by: Andreja Dimkovski, Darko Simov\nFINKI, 2025'**
  String get aboutCredits;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get confirmDelete;

  /// No description provided for @seenOn.
  ///
  /// In en, this message translates to:
  /// **'Seen on: {dateTime}'**
  String seenOn(Object dateTime);

  /// No description provided for @scanInsect.
  ///
  /// In en, this message translates to:
  /// **'Scan Insect'**
  String get scanInsect;

  /// No description provided for @retryScan.
  ///
  /// In en, this message translates to:
  /// **'Not this insect? Scan again'**
  String get retryScan;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'mk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'mk': return AppLocalizationsMk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
