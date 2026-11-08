import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/home/home_screen.dart';
import '../../features/chatbot/chat_screen.dart';
import '../../features/school/school_screen.dart';
import '../../features/college/college_screen.dart';
import '../../features/writing/writing_screen.dart';
import '../../features/coding/coding_screen.dart';
import '../../features/mathematics/math_screen.dart';
import '../../features/translation/translation_screen.dart';
import '../../features/vision/vision_screen.dart';
import '../../features/documents/documents_screen.dart';
import '../../features/quizzes/quiz_screen.dart';
import '../../features/notes/notes_screen.dart';
import '../../features/voice/voice_screen.dart';
import '../../features/model_manager/model_manager_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/general/general_screen.dart';
import '../../features/presentations/presentation_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', name: 'home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/chat', name: 'chat', builder: (_, __) => const ChatScreen()),
      GoRoute(path: '/chat/:id', name: 'chat-detail', builder: (_, __) => const ChatScreen()),
      GoRoute(path: '/school', name: 'school', builder: (_, __) => const SchoolScreen()),
      GoRoute(path: '/college', name: 'college', builder: (_, __) => const CollegeScreen()),
      GoRoute(path: '/general', name: 'general', builder: (_, __) => const GeneralScreen()),
      GoRoute(path: '/writing', name: 'writing', builder: (_, __) => const WritingScreen()),
      GoRoute(path: '/coding', name: 'coding', builder: (_, __) => const CodingScreen()),
      GoRoute(path: '/math', name: 'math', builder: (_, __) => const MathScreen()),
      GoRoute(path: '/translation', name: 'translation', builder: (_, __) => const TranslationScreen()),
      GoRoute(path: '/vision', name: 'vision', builder: (_, __) => const VisionScreen()),
      GoRoute(path: '/documents', name: 'documents', builder: (_, __) => const DocumentsScreen()),
      GoRoute(path: '/quizzes', name: 'quizzes', builder: (_, __) => const QuizScreen()),
      GoRoute(path: '/notes', name: 'notes', builder: (_, __) => const NotesScreen()),
      GoRoute(path: '/voice', name: 'voice', builder: (_, __) => const VoiceScreen()),
      GoRoute(path: '/presentations', name: 'presentations', builder: (_, __) => const PresentationScreen()),
      GoRoute(path: '/models', name: 'models', builder: (_, __) => const ModelManagerScreen()),
      GoRoute(path: '/settings', name: 'settings', builder: (_, __) => const SettingsScreen()),
    ],
  );
});