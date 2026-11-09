import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (_a, _b) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (_a, _b) => const ChatScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        name: 'chat-detail',
        builder: (_a, _b) => const ChatScreen(),
      ),
      GoRoute(
        path: '/school',
        name: 'school',
        builder: (_a, _b) => const SchoolScreen(),
      ),
      GoRoute(
        path: '/college',
        name: 'college',
        builder: (_a, _b) => const CollegeScreen(),
      ),
      GoRoute(
        path: '/general',
        name: 'general',
        builder: (_a, _b) => const GeneralScreen(),
      ),
      GoRoute(
        path: '/writing',
        name: 'writing',
        builder: (_a, _b) => const WritingScreen(),
      ),
      GoRoute(
        path: '/coding',
        name: 'coding',
        builder: (_a, _b) => const CodingScreen(),
      ),
      GoRoute(
        path: '/math',
        name: 'math',
        builder: (_a, _b) => const MathScreen(),
      ),
      GoRoute(
        path: '/translation',
        name: 'translation',
        builder: (_a, _b) => const TranslationScreen(),
      ),
      GoRoute(
        path: '/vision',
        name: 'vision',
        builder: (_a, _b) => const VisionScreen(),
      ),
      GoRoute(
        path: '/documents',
        name: 'documents',
        builder: (_a, _b) => const DocumentsScreen(),
      ),
      GoRoute(
        path: '/quizzes',
        name: 'quizzes',
        builder: (_a, _b) => const QuizScreen(),
      ),
      GoRoute(
        path: '/notes',
        name: 'notes',
        builder: (_a, _b) => const NotesScreen(),
      ),
      GoRoute(
        path: '/voice',
        name: 'voice',
        builder: (_a, _b) => const VoiceScreen(),
      ),
      GoRoute(
        path: '/presentations',
        name: 'presentations',
        builder: (_a, _b) => const PresentationScreen(),
      ),
      GoRoute(
        path: '/models',
        name: 'models',
        builder: (_a, _b) => const ModelManagerScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (_a, _b) => const SettingsScreen(),
      ),
    ],
  );
});
