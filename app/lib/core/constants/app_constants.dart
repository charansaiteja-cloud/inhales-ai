/// Application-wide constants for InhaleSkill AI.
class AppConstants {
  static const String appName = 'InhaleSkill AI';
  static const String tagline = 'Learn Anything. Build Skills. Anywhere.';
  static const String appVersion = '1.0.0';
  static const String appPackage = 'com.inhaleskill.ai.app';

  // Database
  static const String dbName = 'inhaleskill_ai.db';
  static const int dbVersion = 3;

  // Storage
  static const String appStorageDir = 'inhaleskill_ai';
  static const String modelsDir = 'models';
  static const String documentsDir = 'documents';
  static const String notesDir = 'notes';
  static const String tempDir = 'temp';

  // AI defaults
  static const int defaultContextLength = 2048;
  static const int defaultCpuThreads = 4;
  static const int maxContextLength = 8192;
  static const int minContextLength = 512;

  // Memory thresholds (MB)
  static const int lowMemoryThreshold = 2048;
  static const int midMemoryThreshold = 4096;
  static const int highMemoryThreshold = 8192;

  // Supported languages
  static const List<String> supportedLanguages = [
    'en', // English
    'hi', // Hindi
    'te', // Telugu
  ];

  static const Map<String, String> languageNames = {
    'en': 'English',
    'hi': 'Hindi',
    'te': 'Telugu',
  };

  // Chat modes
  static const List<String> responseModes = [
    'Short',
    'Detailed',
    'Step-by-step',
  ];
  static const int defaultResponseModeIndex = 1;

  // Schools
  static const List<int> schoolClasses = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  static const List<String> schoolSubjects = [
    'Mathematics',
    'Science',
    'English',
    'Grammar',
    'Social Studies',
    'History',
    'Geography',
    'General Knowledge',
    'Regional Languages',
  ];

  static const List<String> collegeSubjects = [
    'Engineering',
    'Computer Science',
    'Programming',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'Commerce',
    'Accounting',
    'Economics',
    'Business Management',
    'Statistics',
    'Humanities',
    'Arts',
    'Literature',
    'Law',
  ];
}
