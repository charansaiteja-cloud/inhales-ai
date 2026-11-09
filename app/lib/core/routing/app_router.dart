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
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        name: 'chat-detail',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/school',
        name: 'school',
        builder: (context, state) => const SchoolScreen(),
      ),
      GoRoute(
        path: '/college',
        name: 'college',
        builder: (context, state) => const CollegeScreen(),
      ),
      GoRoute(
        path: '/general',
        name: 'general',
        builder: (context, state) => const GeneralScreen(),
      ),
      GoRoute(
        path: '/writing',
        name: 'writing',
        builder: (context, state) => const WritingScreen(),
      ),
      GoRoute(
        path: '/coding',
        name: 'coding',
        builder: (context, state) => const CodingScreen(),
      ),
      GoRoute(
        path: '/math',
        name: 'math',
        builder: (context, state) => const MathScreen(),
      ),
      GoRoute(
        path: '/translation',
        name: 'translation',
        builder: (context, state) => const TranslationScreen(),
      ),
      GoRoute(
        path: '/vision',
        name: 'vision',
        builder: (context, state) => const VisionScreen(),
      ),
      GoRoute(
        path: '/documents',
        name: 'documents',
        builder: (context, state) => const DocumentsScreen(),
      ),
      GoRoute(
        path: '/quizzes',
        name: 'quizzes',
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        path: '/notes',
        name: 'notes',
        builder: (context, state) => const NotesScreen(),
      ),
      GoRoute(
        path: '/voice',
        name: 'voice',
        builder: (context, state) => const VoiceScreen(),
      ),
      GoRoute(
        path: '/presentations',
        name: 'presentations',
        builder: (context, state) => const PresentationScreen(),
      ),
      GoRoute(
        path: '/models',
        name: 'models',
        builder: (context, state) => const ModelManagerScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
