// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get appTitle => 'Bugify';

  @override
  String get splashSubtitle => 'Идентификација на инсекти';

  @override
  String get homeTitle => 'Главно мени';

  @override
  String get recognizeInsect => 'Препознај инсект';

  @override
  String get history => 'Историја на инсекти';

  @override
  String get about => 'За апликацијата';

  @override
  String get back => 'Назад';

  @override
  String get noHistory => 'Нема историја на препознавања';

  @override
  String deleteConfirmation(Object insectName) {
    return 'Дали сте сигурни дека сакате да го избришете \"$insectName\"?';
  }

  @override
  String get cancel => 'Откажи';

  @override
  String get delete => 'Избриши';

  @override
  String get developedBy => 'Развиено од: Андреја Димковски, Дарко Симов\nФИНКИ, 2025 година';

  @override
  String get version => 'Верзија: 1.0.0';

  @override
  String get notThisInsect => 'Не е овој инсект? Скенирај повторно';

  @override
  String get fromCamera => 'Камера';

  @override
  String get fromGallery => 'Галерија';

  @override
  String get noImageSelected => 'Нема избрано слика';

  @override
  String get recognitionError => 'Грешка при препознавање на инсектот';

  @override
  String get details => 'ДЕТАЛИ';

  @override
  String get region => 'Региони';

  @override
  String get activePeriod => 'Активен период';

  @override
  String get flowerPreference => 'Преферирани растенија';

  @override
  String get diet => 'Исхрана';

  @override
  String get dangerous => 'Опасен';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Не';

  @override
  String get type => 'Тип';

  @override
  String get size => 'Големина';

  @override
  String get lifespan => 'Животен век';

  @override
  String get backToMenu => 'Назад кон главното мени';

  @override
  String get aboutAppTitle => 'За апликацијата';

  @override
  String get aboutAppDescription1 => 'Bugify е мобилна апликација која користи вештачка интелигенција за препознавање на инсекти преку слика.';

  @override
  String get aboutAppDescription2 => 'Со оваа апликација можете:\n\n• Да скенирате инсекти преку камера или галерија\n• Да ги видите деталните информации\n• Да прегледате историја на скенирања\n• Да научите повеќе за инсектите околу вас';

  @override
  String get aboutTitle => 'За апликацијата';

  @override
  String get aboutIntro => 'Bugify е мобилна апликација која користи вештачка интелигенција за препознавање на инсекти преку слика.';

  @override
  String get aboutFeatures => 'Со оваа апликација можете:\n\n• Да скенирате инсекти преку камера или галерија\n• Да ги видите деталните информации\n• Да прегледате историја на скенирања\n• Да научите повеќе за инсектите околу вас';

  @override
  String get aboutCredits => 'Развиено од: Андреја Димковски, Дарко Симов\nФИНКИ, 2025 година';

  @override
  String get confirmDelete => 'Дали сте сигурни дека сакате да го избришете?';

  @override
  String seenOn(Object dateTime) {
    return 'Видено на: $dateTime';
  }

  @override
  String get scanInsect => 'Препознај Инсект';

  @override
  String get retryScan => 'Не е овој инсект? Скенирај повторно';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерија';

  @override
  String get showAnotherFact => 'Покажи друг факт';

  @override
  String get funFactTitle => 'Интересен факт за инсекти';

  @override
  String get funFacts => 'Интересни факти';

  @override
  String welcomeUser(Object username) {
    return 'Добредојде, $username';
  }

  @override
  String get logout => 'Одјава';
}
