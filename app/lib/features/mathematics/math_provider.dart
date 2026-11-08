import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  const MathState({
    this.input = '',
    this.output = '',
    this.steps = '',
    this.isComputing = false,
    this.history = const [],
  });
}

final mathProvider = StateNotifierProvider<MathNotifier, MathState>(
  (ref) => MathNotifier(),
);

class MathNotifier extends StateNotifier<MathState> {
  MathNotifier() : super(const MathState());

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
    state = MathState(
      input: state.input,
      output: '',
      steps: '',
      isComputing: true,
      history: state.history,
    );

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
        steps = 'Expression: ${input}\nResult: $result';
      } else {
        result = 'Use AI model for complex math.';
        steps = 'Expression: ${input}\nInstall a model for detailed solutions.';
      }
    } catch (_) {
      result = 'Could not evaluate: $input';
      steps = 'Expression: $input\nThe expression may need AI analysis.';
    }

    final mathResult = MathResult(
      expression: input,
      result: result,
      steps: steps,
    );

    state = MathState(
      input: state.input,
      output: result,
      steps: steps,
      isComputing: false,
      history: [mathResult, ...state.history],
    );
  }

  double? _tryEvaluate(String expr) {
    try {
      final clean = expr
          .replaceAll(' ', '')
          .replaceAll('x', '*')
          .replaceAll('X', '*');
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
        if (op == '*')
          result *= right;
        else if (op == '/')
          result /= right;
        else
          result = right % (result.abs());
      }
      return result;
    };

    parseExpr = () {
      double result = parseTerm();
      while (pos < tokens.length &&
          (tokens[pos] == '+' || tokens[pos] == '-')) {
        final op = tokens[pos++];
        final right = parseTerm();
        result = op == '+' ? result + right : result - right;
      }
      return result;
    };

    return parseExpr();
  }
}
