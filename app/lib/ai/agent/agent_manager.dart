/// Agent Manager — tool-use agent loop for complex tasks.
library;

import 'dart:async';

import '../engine/ai_engine.dart';

/// Tool definition for agent capabilities.
class Tool {
  final String name;
  final String description;
  final Map<String, dynamic> parameters;
  final Future<String> Function(Map<String, dynamic> args) execute;

  const Tool({
    required this.name,
    required this.description,
    required this.parameters,
    required this.execute,
  });
}

/// Agent step result.
class AgentStep {
  final String thought;
  final String? toolName;
  final Map<String, dynamic>? toolArgs;
  final String? toolResult;
  final bool isFinal;

  const AgentStep({
    required this.thought,
    this.toolName,
    this.toolArgs,
    this.toolResult,
    this.isFinal = false,
  });
}

/// Agent Manager for tool-use loops.
class AgentManager {
  final AIEngine _engine;
  final List<Tool> _tools = [];

  AgentManager(this._engine);

  /// Register a tool.
  void registerTool(Tool tool) {
    _tools.add(tool);
  }

  /// Get available tools.
  List<Tool> get tools => List.unmodifiable(_tools);

  /// Run agent loop to completion.
  Stream<AgentStep> run({
    required String task,
    required List<ChatMessage> history,
    int maxSteps = 10,
  }) async* {
    var stepCount = 0;
    var currentHistory = [...history];
    currentHistory.add(
      ChatMessage(role: 'user', content: task, timestamp: DateTime.now()),
    );

    while (stepCount < maxSteps) {
      stepCount++;

      // Generate thought
      final prompt = _buildAgentPrompt(currentHistory);
      final response = await _generateResponse(prompt);

      final step = _parseResponse(response);
      yield step;

      if (step.isFinal) break;

      // Execute tool if needed
      if (step.toolName != null && step.toolArgs != null) {
        final tool = _tools.firstWhere(
          (t) => t.name == step.toolName,
          orElse: () => throw Exception('Tool not found: ${step.toolName}'),
        );

        final result = await tool.execute(step.toolArgs!);

        yield AgentStep(
          thought: 'Tool ${step.toolName} returned result.',
          toolName: step.toolName,
          toolArgs: step.toolArgs,
          toolResult: result,
        );

        // Add tool result to history
        currentHistory.add(
          ChatMessage(
            role: 'tool',
            content: 'Tool ${step.toolName} result: $result',
            timestamp: DateTime.now(),
          ),
        );
      } else if (step.toolName == null && !step.isFinal) {
        // Just a thought, continue
        currentHistory.add(
          ChatMessage(
            role: 'assistant',
            content: step.thought,
            timestamp: DateTime.now(),
          ),
        );
      }
    }
  }

  /// Build agent prompt with tool definitions.
  String _buildAgentPrompt(List<ChatMessage> history) {
    final buffer = StringBuffer();

    buffer.writeln('<<SYS>>');
    buffer.writeln(
      'You are InhaleSkill AI, an agent that can use tools to solve tasks.',
    );
    buffer.writeln('Available tools:');

    for (final tool in _tools) {
      buffer.writeln('- ${tool.name}: ${tool.description}');
      buffer.writeln('  Parameters: ${tool.parameters}');
    }

    buffer.writeln();
    buffer.writeln('Format your response as:');
    buffer.writeln('THOUGHT: <your reasoning>');
    buffer.writeln('TOOL: <tool_name> | <JSON_args>');
    buffer.writeln('OR');
    buffer.writeln('THOUGHT: <your reasoning>');
    buffer.writeln('FINAL: <final answer>');
    buffer.writeln('<</SYS>>');
    buffer.writeln();

    for (final msg in history) {
      if (msg.role == 'user') {
        buffer.writeln('<<USER>>');
        buffer.writeln(msg.content);
        buffer.writeln('</USER>>');
      } else if (msg.role == 'assistant') {
        buffer.writeln('<<ASSISTANT>>');
        buffer.writeln(msg.content);
        buffer.writeln('</ASSISTANT>>');
      } else if (msg.role == 'tool') {
        buffer.writeln('<<TOOL_RESULT>>');
        buffer.writeln(msg.content);
        buffer.writeln('</TOOL_RESULT>>');
      }
    }

    buffer.writeln('<<ASSISTANT>>');

    return buffer.toString();
  }

  Future<String> _generateResponse(String prompt) async {
    final chunks = <String>[];
    await for (final chunk in _engine.generate(
      prompt: prompt,
      history: [],
      maxTokens: 512,
      temperature: 0.3,
    )) {
      chunks.add(chunk);
    }
    return chunks.join();
  }

  AgentStep _parseResponse(String response) {
    final lines = response.split('\n');
    String thought = '';
    String? toolName;
    Map<String, dynamic>? toolArgs;
    bool isFinal = false;
    String? finalAnswer;

    for (final line in lines) {
      if (line.startsWith('THOUGHT:')) {
        thought = line.substring(8).trim();
      } else if (line.startsWith('TOOL:')) {
        final parts = line.substring(5).split('|');
        toolName = parts[0].trim();
        if (parts.length > 1) {
          try {
            toolArgs = _parseJson(parts[1].trim());
          } catch (_) {
            toolArgs = {};
          }
        }
      } else if (line.startsWith('FINAL:')) {
        isFinal = true;
        finalAnswer = line.substring(6).trim();
      }
    }

    return AgentStep(
      thought: thought,
      toolName: toolName,
      toolArgs: toolArgs,
      toolResult: finalAnswer,
      isFinal: isFinal,
    );
  }

  Map<String, dynamic> _parseJson(String json) {
    // Simple JSON parser for basic cases
    // In production, use dart:convert
    final map = <String, dynamic>{};
    final trimmed = json.trim();
    if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return map;

    final content = trimmed.substring(1, trimmed.length - 1);
    final pairs = content.split(',');

    for (final pair in pairs) {
      final kv = pair.split(':');
      if (kv.length == 2) {
        final key = kv[0].trim().replaceAll('"', '');
        final value = kv[1].trim().replaceAll('"', '');
        map[key] = value;
      }
    }

    return map;
  }
}
