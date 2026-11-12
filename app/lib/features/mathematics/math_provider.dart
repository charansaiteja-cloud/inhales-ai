import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../di/di.dart';
import '../../ai/engine/ai_engine.dart';

class MathResult {
  final String expression;
  final String result;
  final String steps;

  const MathResult({
    required this.expression,
    required this.result,
    required this.steps,
  });
}

class MathState {
  final String input;
  final String output;
  final String steps;
  final bool isComputing;
  final List<MathResult> history;
  final String? error;

  const MathState({
    this.input = '',
    this.output = '',
    this.steps = '',
    this.isComputing = false,
    this.history = const [],
    this.error,
  });
}

final mathProvider = StateNotifierProvider<MathNotifier, MathState>(
  (ref) => MathNotifier(ref.watch(aiEngineProvider)),
);

class MathNotifier extends StateNotifier<MathState> {
  final AIEngine _aiEngine;

  MathNotifier(this._aiEngine) : super(const MathState());

  Future<void> setInput(String input) async {
    state = MathState(
      input: input,
      output: state.output,
      steps: state.steps,
      isComputing: state.isComputing,
      history: state.history,
    );
  }

  Future<void> compute() async {
    if (state.input.trim().isEmpty) return;
    state = state.copyWith(isComputing: true, error: null);

    final input = state.input.trim();
    String result;
    String steps;

    try {
      final numeric = _tryEvaluate(input);
      if (numeric != null) {
        result = numeric
            .toStringAsFixed(6)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
        steps = 'Expression: $input\nResult: $result';
      } else {
        // Fallback to AIEngine for complex math
        final prompt = _buildPrompt(input);
        final buffer = StringBuffer();

        await for (final chunk in _aiEngine.generate(
          prompt: prompt,
          history: [],
          maxTokens: 512,
          temperature: 0.3,
          topP: 0.9,
        )) {
          buffer.write(chunk);
        }

        final aiResponse = buffer.toString().trim();
        result = aiResponse;
        steps = 'AI-generated solution for: $input\n\n$aiResponse';
      }
    } catch (e) {
      result = 'Could not evaluate: $input';
      steps = 'Expression: $input\nError: ${e.toString()}';
    }

    final mathResult = MathResult(
      expression: input,
      result: result,
      steps: steps,
    );

    state = state.copyWith(
      input: state.input,
      output: result,
      steps: steps,
      isComputing: false,
      history: [mathResult, ...state.history],
    );
  }

  double? _tryEvaluate(String expr) {
    try {
      final clean =
          expr.replaceAll(' ', '').replaceAll('x', '*').replaceAll('X', '*');
      if (RegExp(r'^[\d\+\-\*\/\.\(\)\%\s]+$').hasMatch(clean)) {
        final tokens = _tokenize(clean);
        return _parseExpression(tokens);
      }
    } catch (_) {}
    return null;
  }

  List<String> _tokenize(String expr) {
    final tokens = <String>[];
    var i = 0;
    while (i < expr.length) {
      if ('+-*/%()'.contains(expr[i])) {
        tokens.add(expr[i]);
        i++;
      } else if (expr[i].codeUnitAt(0) >= 48 && expr[i].codeUnitAt(0) <= 57) {
        var num = '';
        while (i < expr.length &&
            ((expr[i].codeUnitAt(0) >= 48 && expr[i].codeUnitAt(0) <= 57) ||
                expr[i] == '.')) {
          num += expr[i];
          i++;
        }
        tokens.add(num);
      } else {
        i++;
      }
    }
    return tokens;
  }

  double _parseExpression(List<String> tokens) {
    int pos = 0;

    double Function() parseExpr = () => 0.0;
    double Function() parseTerm = () => 0.0;
    double Function() parseFactor = () => 0.0;

    parseFactor = () {
      if (pos < tokens.length && tokens[pos] == '(') {
        pos++;
        final result = parseExpr();
        if (pos < tokens.length && tokens[pos] == ')') pos++;
        return result;
      }
      if (pos < tokens.length) {
        return double.parse(tokens[pos++]);
      }
      return 0.0;
    };

    parseTerm = () {
      double result = parseFactor();
      while (pos < tokens.length &&
          (tokens[pos] == '*' || tokens[pos] == '/' || tokens[pos] == '%')) {
        final op = tokens[pos++];
        final right = parseFactor();
        if (op == '*') {
          result *= right;
        } else if (op == '/') {
          result /= right;
        } else {
          result = result % right;
        }
      }
      return result;
    };

    parseExpr = () {
      double result = parseTerm();
      while (
          pos < tokens.length && (tokens[pos] == '+' || tokens[pos] == '-')) {
        final op = tokens[pos++];
        final right = parseTerm();
        result = op == '+' ? result + right : result - right;
      }
      return result;
    };

    return parseExpr();
  }

  String _buildPrompt(String input) {
    return '''
<<SYS>>
You are a math tutor. Solve the given problem step by step. Show your work clearly.
<</SYS>>

<<USER>>
Problem: $input
</USER>>

<<ASSISTANT>>
''';
  }
}

extension on MathState {
  MathState copyWith({
    String? input,
    String? output,
    String? steps,
    bool? isComputing,
    List<MathResult>? history,
    String? error,
  }) =>
      MathState(
        input: input ?? this.input,
        output: output ?? this.output,
        steps: steps ?? this.steps,
        isComputing: isComputing ?? this.isComputing,
        history: history ?? this.history,
        error: error ?? this.error,
      );
}
