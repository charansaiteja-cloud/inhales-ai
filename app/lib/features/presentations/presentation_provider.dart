import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../../ai/engine/ai_engine.dart';

class Slide {
  final int number;
  final String title;
  final String content;
  final String? speakerNotes;

  const Slide({
    required this.number,
    required this.title,
    required this.content,
    this.speakerNotes,
  });
}

class PresentationState {
  final List<PresentationMeta> presentations;
  final List<Slide>? currentPresentation;
  final bool isGenerating;
  final String? error;

  const PresentationState({
    this.presentations = const [],
    this.currentPresentation,
    this.isGenerating = false,
    this.error,
  });
}

class PresentationMeta {
  final String id;
  final String title;
  final int slideCount;
  final DateTime createdAt;

  const PresentationMeta({
    required this.id,
    required this.title,
    required this.slideCount,
    required this.createdAt,
  });
}

final presentationProvider =
    StateNotifierProvider<PresentationNotifier, PresentationState>(
      (ref) => PresentationNotifier(ref.watch(aiEngineProvider)),
    );

class PresentationNotifier extends StateNotifier<PresentationState> {
  final AIEngine _aiEngine;

  PresentationNotifier(this._aiEngine) : super(const PresentationState());

  Future<void> generatePresentation(String topic, {int slides = 5}) async {
    if (topic.trim().isEmpty) {
      state = state.copyWith(error: 'Enter a topic');
      return;
    }

    state = state.copyWith(isGenerating: true, error: null);

    try {
      final prompt = _buildPrompt(topic, slides);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 2048,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final generatedSlides = _parseSlides(buffer.toString(), slides);

      final now = DateTime.now();
      final meta = PresentationMeta(
        id: now.millisecondsSinceEpoch.toString(),
        title: topic,
        slideCount: generatedSlides.length,
        createdAt: now,
      );

      state = state.copyWith(
        presentations: [meta, ...state.presentations],
        currentPresentation: generatedSlides,
        isGenerating: false,
      );
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
    }
  }

  void openPresentation(int index) {
    // In real app, load from persistence
  }

  String _buildPrompt(String topic, int slideCount) {
    return '''
<<SYS>>
You are a presentation generator. Create a $slideCount-slide presentation about the given topic.
Format each slide as:
Slide N: [title]
Content: [bullet points or paragraphs]
Notes: [optional speaker notes]

---
<</SYS>>

<<USER>>
Topic: $topic
Slides: $slideCount
</USER>>

<<ASSISTANT>>
''';
  }

  List<Slide> _parseSlides(String response, int expectedCount) {
    final slides = <Slide>[];
    final slideBlocks = response.split(RegExp(r'Slide \d+:'));

    for (
      int i = 1;
      i < slideBlocks.length && slides.length < expectedCount;
      i++
    ) {
      final block = slideBlocks[i].trim();
      final lines = block.split('\n');
      if (lines.isEmpty) continue;

      final title = lines[0].trim();
      final contentBuffer = StringBuffer();
      String? notes;

      for (final line in lines.skip(1)) {
        if (line.startsWith('Notes:')) {
          notes = line.substring('Notes:'.length).trim();
        } else if (line.startsWith('Content:')) {
          contentBuffer.write(line.substring('Content:'.length).trim());
          contentBuffer.write('\n');
        } else if (contentBuffer.isNotEmpty || line.isNotEmpty) {
          contentBuffer.write(line);
          contentBuffer.write('\n');
        }
      }
      final content = contentBuffer.toString().trim();

      slides.add(
        Slide(number: i, title: title, content: content, speakerNotes: notes),
      );
    }

    // Fallback
    if (slides.isEmpty) {
      for (int i = 1; i <= expectedCount; i++) {
        slides.add(
          Slide(
            number: i,
            title: 'Slide $i',
            content: 'Content for slide $i about the topic.',
          ),
        );
      }
    }

    return slides;
  }
}

extension on PresentationState {
  PresentationState copyWith({
    List<PresentationMeta>? presentations,
    List<Slide>? currentPresentation,
    bool? isGenerating,
    String? error,
  }) => PresentationState(
    presentations: presentations ?? this.presentations,
    currentPresentation: currentPresentation ?? this.currentPresentation,
    isGenerating: isGenerating ?? this.isGenerating,
    error: error ?? this.error,
  );
}
