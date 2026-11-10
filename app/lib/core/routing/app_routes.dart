/// Centralized route constants for InhaleSkill AI
/// Use these constants throughout the app for type-safe navigation.
library;

class AppRoutes {
  AppRoutes._();

  // Primary routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';

  // Feature routes
  static const String chat = '/chat';
  static const String chatDetail = '/chat/:id';
  static const String school = '/school';
  static const String college = '/college';
  static const String general = '/general';
  static const String writing = '/writing';
  static const String coding = '/coding';
  static const String math = '/math';
  static const String translation = '/translation';
  static const String vision = '/vision';
  static const String documents = '/documents';
  static const String quizzes = '/quizzes';
  static const String notes = '/notes';
  static const String voice = '/voice';
  static const String presentations = '/presentations';
  static const String models = '/models';
  static const String settings = '/settings';

  // All routes list (for validation)
  static const List<String> all = [
    splash,
    onboarding,
    home,
    chat,
    chatDetail,
    school,
    college,
    general,
    writing,
    coding,
    math,
    translation,
    vision,
    documents,
    quizzes,
    notes,
    voice,
    presentations,
    models,
    settings,
  ];

  // Route names (for GoRouter)
  static const String splashName = 'splash';
  static const String onboardingName = 'onboarding';
  static const String homeName = 'home';
  static const String chatName = 'chat';
  static const String chatDetailName = 'chat-detail';
  static const String schoolName = 'school';
  static const String collegeName = 'college';
  static const String generalName = 'general';
  static const String writingName = 'writing';
  static const String codingName = 'coding';
  static const String mathName = 'math';
  static const String translationName = 'translation';
  static const String visionName = 'vision';
  static const String documentsName = 'documents';
  static const String quizzesName = 'quizzes';
  static const String notesName = 'notes';
  static const String voiceName = 'voice';
  static const String presentationsName = 'presentations';
  static const String modelsName = 'models';
  static const String settingsName = 'settings';

  // Route groups
  static const List<String> learningRoutes = [school, college, general, math];

  static const List<String> productivityRoutes = [
    writing,
    coding,
    translation,
    notes,
  ];

  static const List<String> contentRoutes = [documents, quizzes, presentations];

  static const List<String> aiRoutes = [chat, vision, voice];
}
