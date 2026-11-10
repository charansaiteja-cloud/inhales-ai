/// Tool Registry — manages available tools with permissions and execution.
library;

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../engine/ai_engine.dart';
import '../rag/rag_service.dart';
import '../../database/database.dart';

/// Tool permission level.
enum ToolPermission {
  none, // Tool not available
  read, // Read-only operations
  write, // Write operations allowed
  execute, // Execution allowed (code, commands)
  admin, // Full access
}

/// Tool definition with permissions.
class Tool {
  final String name;
  final String description;
  final Map<String, dynamic> parameters; // JSON schema
  final ToolPermission requiredPermission;
  final Future<String> Function(Map<String, dynamic> args, ToolContext context)
  execute;

  const Tool({
    required this.name,
    required this.description,
    required this.parameters,
    this.requiredPermission = ToolPermission.read,
    required this.execute,
  });

  /// Check if tool can be used with given permission.
  bool canUse(ToolPermission userPermission) {
    final levels = ToolPermission.values;
    return levels.indexOf(userPermission) >= levels.indexOf(requiredPermission);
  }
}

/// Context passed to tool executions.
class ToolContext {
  final int? conversationId;
  final AIEngine? engine;
  final RAGService? ragService;
  final AppDatabase? database;
  final Map<String, dynamic> metadata;

  const ToolContext({
    this.conversationId,
    this.engine,
    this.ragService,
    this.database,
    this.metadata = const {},
  });
}

/// Result of tool execution.
class ToolResult {
  final bool success;
  final String output;
  final Map<String, dynamic>? data;
  final String? error;

  const ToolResult({
    required this.success,
    required this.output,
    this.data,
    this.error,
  });

  factory ToolResult.success(String output, {Map<String, dynamic>? data}) =>
      ToolResult(success: true, output: output, data: data);

  factory ToolResult.failure(String error, {String output = ''}) =>
      ToolResult(success: false, output: output, error: error);
}

/// Tool Registry — central tool management.
class ToolRegistry {
  final Map<String, Tool> _tools = {};
  ToolPermission _userPermission = ToolPermission.read;
  ToolContext? _context;

  /// Set user permission level.
  void setPermission(ToolPermission permission) {
    _userPermission = permission;
  }

  /// Set execution context.
  void setContext(ToolContext context) {
    _context = context;
  }

  /// Register a tool.
  void register(Tool tool) {
    _tools[tool.name] = tool;
  }

  /// Register multiple tools.
  void registerAll(Iterable<Tool> tools) {
    for (final tool in tools) {
      register(tool);
    }
  }

  /// Get a tool by name.
  Tool? get(String name) => _tools[name];

  /// Get all available tools (filtered by permission).
  List<Tool> get availableTools {
    return _tools.values.where((t) => t.canUse(_userPermission)).toList();
  }

  /// Get all tool definitions for prompt.
  List<Tool> get allTools => _tools.values.toList();

  /// Execute a tool by name.
  Future<ToolResult> execute(String name, Map<String, dynamic> args) async {
    final tool = _tools[name];
    if (tool == null) {
      return ToolResult.failure('Tool not found: $name');
    }

    if (!tool.canUse(_userPermission)) {
      return ToolResult.failure(
        'Permission denied for tool: $name (requires ${tool.requiredPermission})',
      );
    }

    final context = _context ?? const ToolContext();

    try {
      final result = await tool.execute(args, context);
      return ToolResult.success(result);
    } catch (e, stack) {
      return ToolResult.failure('$e', output: stack.toString());
    }
  }

  /// Build tool descriptions for system prompt.
  String buildToolDescriptions() {
    final buffer = StringBuffer();
    for (final tool in availableTools) {
      buffer.writeln('- ${tool.name}: ${tool.description}');
      final params = tool.parameters['properties'] as Map<String, dynamic>?;
      if (params != null) {
        buffer.write('  Parameters: ');
        final paramList = params.entries
            .map((e) => '${e.key} (${e.value['type']})')
            .join(', ');
        buffer.writeln(paramList);
      }
    }
    return buffer.toString();
  }
}

/// Pre-built tool implementations.
class ToolImplementations {
  /// Create standard tool set for InhaleSkill AI.
  static List<Tool> standardTools({ToolContext? context}) {
    return [
      _webSearchTool(),
      _fileReadTool(),
      _fileWriteTool(),
      _fileListTool(),
      _codeExecutionTool(),
      _calculatorTool(),
      _documentSearchTool(context),
      _systemInfoTool(),
      _currentTimeTool(),
    ];
  }

  /// Web search tool (requires internet permission).
  static Tool _webSearchTool() => Tool(
    name: 'web_search',
    description:
        'Search the web for current information. Returns top results with snippets.',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'query': {'type': 'string', 'description': 'Search query'},
        'maxResults': {
          'type': 'integer',
          'description': 'Max results (default 5)',
          'default': 5,
        },
      },
      'required': ['query'],
    },
    execute: (args, context) async {
      final query = args['query'] as String;
      final maxResults = args['maxResults'] as int? ?? 5;

      // This would integrate with a search API
      // For now, return a placeholder
      return 'Web search for "$query" (max $maxResults results) - requires API integration';
    },
  );

  /// File read tool.
  static Tool _fileReadTool() => Tool(
    name: 'file_read',
    description: 'Read contents of a file from the app\'s documents directory.',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'path': {'type': 'string', 'description': 'Relative path to file'},
      },
      'required': ['path'],
    },
    execute: (args, context) async {
      final path = args['path'] as String;
      final appDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(appDir.path, path));

      if (!await file.exists()) {
        throw FileSystemException('File not found: $path');
      }

      final content = await file.readAsString();
      return content.length > 10000
          ? '${content.substring(0, 10000)}\n... (truncated)'
          : content;
    },
  );

  /// File write tool.
  static Tool _fileWriteTool() => Tool(
    name: 'file_write',
    description: 'Write content to a file in the app\'s documents directory.',
    requiredPermission: ToolPermission.write,
    parameters: {
      'type': 'object',
      'properties': {
        'path': {'type': 'string', 'description': 'Relative path to file'},
        'content': {'type': 'string', 'description': 'Content to write'},
        'append': {
          'type': 'boolean',
          'description': 'Append to existing file',
          'default': false,
        },
      },
      'required': ['path', 'content'],
    },
    execute: (args, context) async {
      final path = args['path'] as String;
      final content = args['content'] as String;
      final append = args['append'] as bool? ?? false;

      final appDir = await getApplicationDocumentsDirectory();
      final file = File(p.join(appDir.path, path));

      // Create parent directories if needed
      await file.parent.create(recursive: true);

      await file.writeAsString(
        content,
        mode: append ? FileMode.append : FileMode.write,
      );
      return 'Written ${content.length} characters to $path';
    },
  );

  /// File list tool.
  static Tool _fileListTool() => Tool(
    name: 'file_list',
    description: 'List files in a directory within the app\'s documents.',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'path': {
          'type': 'string',
          'description': 'Directory path (default: root)',
          'default': '',
        },
        'recursive': {
          'type': 'boolean',
          'description': 'List recursively',
          'default': false,
        },
      },
    },
    execute: (args, context) async {
      final path = args['path'] as String? ?? '';
      final recursive = args['recursive'] as bool? ?? false;

      final appDir = await getApplicationDocumentsDirectory();
      final dir = Directory(p.join(appDir.path, path));

      if (!await dir.exists()) {
        throw Exception('Directory not found: $path');
      }

      final entities = await dir.list(recursive: recursive).toList();
      final buffer = StringBuffer();

      for (final entity in entities) {
        final stat = await entity.stat();
        final relative = p.relative(entity.path, from: appDir.path);
        final type = entity is Directory ? 'DIR' : 'FILE';
        final size = entity is File ? ' (${stat.size} bytes)' : '';
        buffer.writeln('$type $relative$size');
      }

      return buffer.toString().isEmpty
          ? 'Directory is empty'
          : buffer.toString();
    },
  );

  /// Code execution tool (sandboxed).
  static Tool _codeExecutionTool() => Tool(
    name: 'code_exec',
    description:
        'Execute Dart/Python/JS code in a sandboxed environment. Returns stdout/stderr.',
    requiredPermission: ToolPermission.execute,
    parameters: {
      'type': 'object',
      'properties': {
        'language': {
          'type': 'string',
          'description': 'Language: dart, python, javascript',
          'enum': ['dart', 'python', 'javascript'],
        },
        'code': {'type': 'string', 'description': 'Code to execute'},
        'timeout': {
          'type': 'integer',
          'description': 'Timeout in seconds',
          'default': 10,
        },
      },
      'required': ['language', 'code'],
    },
    execute: (args, context) async {
      final language = args['language'] as String;
      final code = args['code'] as String;
      args['timeout'] as int? ?? 10;

      // This would run in a secure sandbox
      // For now, return a placeholder
      return 'Code execution ($language) - requires sandbox integration\nCode:\n$code';
    },
  );

  /// Calculator tool.
  static Tool _calculatorTool() => Tool(
    name: 'calculator',
    description: 'Evaluate mathematical expressions safely.',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'expression': {
          'type': 'string',
          'description': 'Mathematical expression to evaluate',
        },
      },
      'required': ['expression'],
    },
    execute: (args, context) async {
      final expression = args['expression'] as String;

      try {
        // Simple safe evaluation - in production use a proper math parser
        final result = _safeEval(expression);
        return 'Result: $result';
      } catch (e) {
        throw Exception('Invalid expression: $e');
      }
    },
  );

  /// Document search tool (uses RAG).
  static Tool _documentSearchTool(ToolContext? context) => Tool(
    name: 'document_search',
    description: 'Search indexed documents for relevant information.',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'query': {'type': 'string', 'description': 'Search query'},
        'limit': {
          'type': 'integer',
          'description': 'Max results',
          'default': 5,
        },
      },
      'required': ['query'],
    },
    execute: (args, context) async {
      final query = args['query'] as String;
      final limit = args['limit'] as int? ?? 5;

      final ragService = context.ragService;
      if (ragService == null) {
        throw Exception('RAG service not available');
      }

      final results = await ragService.search(query, limit: limit);

      if (results.isEmpty) {
        return 'No relevant documents found for: $query';
      }

      final buffer = StringBuffer();
      buffer.writeln('Found ${results.length} relevant chunks:');
      for (var i = 0; i < results.length; i++) {
        final r = results[i];
        buffer.writeln(
          '\n${i + 1}. [Score: ${r.score.toStringAsFixed(2)}] ${r.chunk.content.substring(0, math.min(200, r.chunk.content.length))}...',
        );
      }

      return buffer.toString();
    },
  );

  /// System info tool.
  static Tool _systemInfoTool() => Tool(
    name: 'system_info',
    description: 'Get system information (device, app version, memory, etc.).',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'category': {
          'type': 'string',
          'description': 'Info category: device, app, memory, storage',
          'enum': ['device', 'app', 'memory', 'storage', 'all'],
        },
      },
    },
    execute: (args, context) async {
      final category = args['category'] as String? ?? 'all';

      final buffer = StringBuffer();
      buffer.writeln('System Information:');

      if (category == 'all' || category == 'device') {
        buffer.writeln(
          'Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
        );
        buffer.writeln('Architecture: ${Platform.localHostname}');
      }

      if (category == 'all' || category == 'app') {
        buffer.writeln('App: InhaleSkill AI');
      }

      if (category == 'all' || category == 'memory') {
        final memInfo = ProcessInfo.currentRss;
        buffer.writeln(
          'Memory RSS: ${(memInfo / 1024 / 1024).toStringAsFixed(1)} MB',
        );
      }

      return buffer.toString();
    },
  );

  /// Current time tool.
  static Tool _currentTimeTool() => Tool(
    name: 'current_time',
    description: 'Get current date and time.',
    requiredPermission: ToolPermission.read,
    parameters: {
      'type': 'object',
      'properties': {
        'format': {
          'type': 'string',
          'description': 'Format: iso, readable, timestamp',
          'default': 'readable',
        },
        'timezone': {
          'type': 'string',
          'description': 'Timezone (e.g., UTC, America/New_York)',
          'default': 'local',
        },
      },
    },
    execute: (args, context) async {
      final format = args['format'] as String? ?? 'readable';
      final now = DateTime.now();

      switch (format) {
        case 'iso':
          return now.toIso8601String();
        case 'timestamp':
          return now.millisecondsSinceEpoch.toString();
        default:
          return now.toString().substring(0, 19); // YYYY-MM-DD HH:MM:SS
      }
    },
  );

  /// Safe math expression evaluation (basic).
  static double _safeEval(String expression) {
    // Very basic implementation - in production use expr or math_parser package
    final clean = expression.replaceAll(RegExp(r'[^0-9+\-*/().\s]'), '');
    // This is a placeholder - real implementation would parse and evaluate safely
    return double.tryParse(clean) ?? 0.0;
  }
}
