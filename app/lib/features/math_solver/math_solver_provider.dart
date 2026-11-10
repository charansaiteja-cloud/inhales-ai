import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../di/di.dart';
import '../../ai/engine/ai_engine.dart';

class MathSolverState {
  final File? image;
  final Uint8List? imageBytes;
  final String? recognizedExpression;
  final String? solution;
  final List<String> steps;
  final String? answer;
  final bool isProcessing;
  final String? error;
  final List<MathSolverHistoryEntry> history;

  const MathSolverState({
    this.image,
    this.imageBytes,
    this.recognizedExpression,
    this.solution,
    this.steps = const [],
    this.answer,
    this.isProcessing = false,
    this.error,
    this.history = const [],
  });

  MathSolverState copyWith({
    File? image,
    Uint8List? imageBytes,
    String? recognizedExpression,
    String? solution,
    List<String>? steps,
    String? answer,
    bool? isProcessing,
    String? error,
    List<MathSolverHistoryEntry>? history,
  }) =>
      MathSolverState(
        image: image ?? this.image,
        imageBytes: imageBytes ?? this.imageBytes,
        recognizedExpression: recognizedExpression ?? this.recognizedExpression,
        solution: solution ?? this.solution,
        steps: steps ?? this.steps,
        answer: answer ?? this.answer,
        isProcessing: isProcessing ?? this.isProcessing,
        error: error ?? this.error,
        history: history ?? this.history,
      );
}

class MathSolverHistoryEntry {
  final String expression;
  final String answer;
  final List<String> steps;
  final DateTime timestamp;
  final File? originalImage;

  const MathSolverHistoryEntry({
    required this.expression,
    required this.answer,
    required this.steps,
    required this.timestamp,
    this.originalImage,
  });
}

final mathSolverProvider =
    StateNotifierProvider<MathSolverNotifier, MathSolverState>(
  (ref) => MathSolverNotifier(ref.watch(aiEngineProvider)),
);

class MathSolverNotifier extends StateNotifier<MathSolverState> {
  final AIEngine _aiEngine;

  MathSolverNotifier(this._aiEngine) : super(const MathSolverState());

  /// Pick an image from the device gallery or file system
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;

    final filePath = result.files.first.path;
    if (filePath == null) {
      state = state.copyWith(error: 'Could not access the selected image');
      return;
    }

    final file = File(filePath);
    final bytes = await file.readAsBytes();

    state = state.copyWith(
      image: file,
      imageBytes: bytes,
      recognizedExpression: null,
      solution: null,
      steps: [],
      answer: null,
      error: null,
    );
  }

  /// Analyze the image using vision AI to recognize the math expression
  Future<void> analyzeImage() async {
    if (state.imageBytes == null) {
      state = state.copyWith(error: 'No image selected');
      return;
    }

    state = state.copyWith(isProcessing: true, error: null);

    try {
      // Use vision AI to recognize the math expression
      final prompt = '''
<<SYS>>
You are a mathematical expression recognition system. Analyze the provided image and:
1. Identify and extract the mathematical expression or problem shown
2. Write it in clear text format using standard mathematical notation
3. Be precise with numbers, operators, and symbols

Respond with ONLY the recognized expression, nothing else.
<</SYS>>

<<USER>>
[Image containing a mathematical expression]
</USER>>

<<ASSISTANT>>
''';

      // For now, we'll use a placeholder since vision inference isn't fully implemented
      // In production, this would send the image bytes to a vision model
      final recognizedExpression = await _recognizeExpressionFromImage(
        state.imageBytes!,
        prompt,
      );

      state = state.copyWith(
        recognizedExpression: recognizedExpression,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Failed to analyze image: ${e.toString()}',
      );
    }
  }

  /// Solve the recognized expression with step-by-step explanation
  Future<void> solve() async {
    final expression = state.recognizedExpression;
    if (expression == null || expression.trim().isEmpty) {
      state = state.copyWith(error: 'No expression to solve');
      return;
    }

    state = state.copyWith(isProcessing: true, error: null);

    try {
      final prompt = '''
<<SYS>>
You are an expert mathematics tutor. Solve the given problem step by step.
For each step:
1. Explain what you're doing clearly
2. Show the mathematical work
3. Build towards the final answer

Format your response as:
EXPRESSION: [the original expression]
ANSWER: [the final answer]
STEPS:
1. [First step explanation]
2. [Second step explanation]
...
<</SYS>>

<<USER>>
Problem: $expression

Please solve this step by step with clear explanations.
</USER>>

<<ASSISTANT>>
''';

      final buffer = StringBuffer();
      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 1024,
        temperature: 0.3,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final response = buffer.toString().trim();
      final parsed = _parseSolutionResponse(response, expression);

      // Add to history
      final historyEntry = MathSolverHistoryEntry(
        expression: parsed['expression'] ?? expression,
        answer: parsed['answer'] ?? 'See solution',
        steps: parsed['steps'] ?? [],
        timestamp: DateTime.now(),
        originalImage: state.image,
      );

      state = state.copyWith(
        solution: response,
        steps: parsed['steps'] ?? [],
        answer: parsed['answer'],
        isProcessing: false,
        history: [historyEntry, ...state.history],
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Failed to solve: ${e.toString()}',
      );
    }
  }

  /// Clear the current state and start fresh
  Future<void> clear() async {
    state = const MathSolverState();
  }

  /// Clear only the current solution (keep image)
  Future<void> clearSolution() async {
    state = MathSolverState(
      image: state.image,
      imageBytes: state.imageBytes,
      history: state.history,
    );
  }

  /// Load a problem from history
  Future<void> loadFromHistory(MathSolverHistoryEntry entry) async {
    state = state.copyWith(
      recognizedExpression: entry.expression,
      answer: entry.answer,
      steps: entry.steps,
      solution: entry.steps.join('\n'),
    );
  }

  /// Remove an entry from history
  Future<void> removeFromHistory(int index) async {
    if (index >= 0 && index < state.history.length) {
      final newHistory = List<MathSolverHistoryEntry>.from(state.history);
      newHistory.removeAt(index);
      state = state.copyWith(history: newHistory);
    }
  }

  /// Manually set the recognized expression (for editing)
  Future<void> setRecognizedExpression(String expression) async {
    state = state.copyWith(recognizedExpression: expression);
  }

  /// Internal: Recognize expression from image bytes
  /// This is a placeholder - in production would use actual vision model
  Future<String> _recognizeExpressionFromImage(
    Uint8List bytes,
    String prompt,
  ) async {
    // TODO: Implement actual vision inference with a multimodal model
    // For now, return a placeholder that prompts the user
    // This simulates what would happen with a vision-capable model
    
    // In production, this would:
    // 1. Encode the image bytes appropriately
    // 2. Send to a vision model (LLaVA, Qwen2.5-VL, etc.)
    // 3. Parse the model's response for the recognized expression
    
    return 'Please edit this to match the expression in your image';
  }

  /// Parse the AI response to extract structured solution data
  Map<String, dynamic> _parseSolutionResponse(
    String response,
    String originalExpression,
  ) {
    final result = <String, dynamic>{
      'expression': originalExpression,
      'answer': null,
      'steps': <String>[],
    };

    // Try to extract ANSWER: line
    final answerMatch = RegExp(r'ANSWER:\s*(.+)', multiLine: true)
        .firstMatch(response);
    if (answerMatch != null) {
      result['answer'] = answerMatch.group(1)?.trim();
    }

    // Try to extract STEPS section
    final stepsMatch = RegExp(r'STEPS:\s*([\s\S]+?)(?:\n\n|\$|$)', multiLine: true)
        .firstMatch(response);
    if (stepsMatch != null) {
      final stepsText = stepsMatch.group(1)?.trim() ?? '';
      final steps = <String>[];
      
      // Parse numbered steps
      final stepLines = stepsText.split('\n');
      for (var line in stepLines) {
        line = line.trim();
        if (line.isNotEmpty) {
          // Remove leading numbers like "1. " or "1) "
          line = line.replaceFirst(RegExp(r'^\d+[\.\)]\s*'), '');
          steps.add(line);
        }
      }
      
      if (steps.isNotEmpty) {
        result['steps'] = steps;
      }
    }

    // If no structured format found, use the whole response as steps
    if ((result['steps'] as List).isEmpty) {
      result['steps'] = [response];
    }

    return result;
  }
}
