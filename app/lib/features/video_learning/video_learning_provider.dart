import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ai/engine/ai_engine.dart';
import '../../database/database.dart';
import '../../di/di.dart';

class VideoLearningState {
  final bool isLoading;
  final String? videoUrl;
  final String? transcript;
  final String? summary;
  final List<String> keyTopics;
  final String? error;

  const VideoLearningState({
    this.isLoading = false,
    this.videoUrl,
    this.transcript,
    this.summary,
    this.keyTopics = const [],
    this.error,
  });

  VideoLearningState copyWith({
    bool? isLoading,
    String? videoUrl,
    String? transcript,
    String? summary,
    List<String>? keyTopics,
    String? error,
  }) =>
      VideoLearningState(
        isLoading: isLoading ?? this.isLoading,
        videoUrl: videoUrl ?? this.videoUrl,
        transcript: transcript ?? this.transcript,
        summary: summary ?? this.summary,
        keyTopics: keyTopics ?? this.keyTopics,
        error: error ?? this.error,
      );
}

final videoLearningProvider =
    StateNotifierProvider<VideoLearningNotifier, VideoLearningState>((ref) {
  return VideoLearningNotifier(ref);
});

class VideoLearningNotifier extends StateNotifier<VideoLearningState> {
  final Ref ref;

  VideoLearningNotifier(this.ref) : super(const VideoLearningState());

  /// Process a video URL to extract transcript and generate study materials.
  /// Phase 11: Video Learning Assistant
  Future<void> processVideo(String videoUrl) async {
    state = state.copyWith(isLoading: true, error: null, videoUrl: videoUrl);

    try {
      final aiEngine = ref.read(aiEngineProvider);
      final database = ref.read(databaseProvider);

      // Extract transcript from video (placeholder - implement with actual video processing)
      final transcript = await _extractTranscript(videoUrl);

      // Generate summary and key topics using AI engine
      final summaryResult = await _generateSummary(aiEngine, transcript);

      // Store in database
      await _saveVideoTranscript(database, videoUrl, transcript, summaryResult);

      state = state.copyWith(
        isLoading: false,
        transcript: transcript,
        summary: summaryResult.summary,
        keyTopics: summaryResult.keyTopics,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to process video: $e',
      );
    }
  }

  Future<String> _extractTranscript(String videoUrl) async {
    // TODO: Implement actual video transcript extraction
    // Options:
    // 1. Use youtube_transcript_api for YouTube videos
    // 2. Use ffmpeg to extract audio + whisper.cpp for transcription
    // 3. Use cloud API (Google Speech-to-Text, AWS Transcribe)
    return 'Transcript extraction placeholder for: $videoUrl';
  }

  Future<({String summary, List<String> keyTopics})> _generateSummary(
    AIEngine aiEngine,
    String transcript,
  ) async {
    final prompt = '''
Analyze this video transcript and provide:
1. A concise summary (2-3 sentences)
2. Key topics covered (as a list)

Transcript:
$transcript

Format response as:
SUMMARY: <summary here>
TOPICS: <topic1>, <topic2>, <topic3>
''';

    final response = aiEngine.generate(prompt: prompt, history: const []);

    String fullResponse = '';
    await for (final chunk in response) {
      fullResponse += chunk;
    }

    // Parse response
    final summaryMatch = RegExp(
      r'SUMMARY:\s*(.+)',
      multiLine: true,
    ).firstMatch(fullResponse);
    final topicsMatch = RegExp(
      r'TOPICS:\s*(.+)',
      multiLine: true,
    ).firstMatch(fullResponse);

    return (
      summary: summaryMatch?.group(1)?.trim() ?? 'Summary not available',
      keyTopics: topicsMatch
              ?.group(1)
              ?.split(',')
              .map((t) => t.trim())
              .where((t) => t.isNotEmpty)
              .toList() ??
          [],
    );
  }

  Future<void> _saveVideoTranscript(
    AppDatabase database,
    String videoUrl,
    String transcript,
    ({String summary, List<String> keyTopics}) result,
  ) async {
    // TODO: Create video_transcripts table and save
    // For now, store in documents table as a placeholder
    // await database.insertVideoTranscript(
    //   url: videoUrl,
    //   transcript: transcript,
    //   summary: result.summary,
    //   topics: result.keyTopics.join(', '),
    // );
  }

  /// Ask a question about the processed video content.
  Future<String> askQuestion(String question) async {
    if (state.transcript == null) {
      throw Exception('No video processed yet');
    }

    final aiEngine = ref.read(aiEngineProvider);
    final prompt = '''
Based on this video transcript, answer the following question:

Transcript:
${state.transcript}

Question: $question

Provide a clear, educational answer grounded in the transcript content.
''';

    final response = aiEngine.generate(prompt: prompt, history: const []);

    String answer = '';
    await for (final chunk in response) {
      answer += chunk;
    }

    return answer;
  }

  void clear() {
    state = const VideoLearningState();
  }
}
