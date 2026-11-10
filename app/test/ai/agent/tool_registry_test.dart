/// ToolRegistry unit tests
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:inhaleskill_ai/ai/agent/tool_registry.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ToolRegistry', () {
    late ToolRegistry registry;

    setUp(() {
      registry = ToolRegistry();
    });

    test('registers and retrieves a tool', () {
      final tool = Tool(
        name: 'test_tool',
        description: 'A test tool',
        parameters: {},
        execute: (args, ctx) async => 'ok',
      );

      registry.register(tool);
      final retrieved = registry.get('test_tool');
      expect(retrieved, isNotNull);
      expect(retrieved!.name, 'test_tool');
    });

    test('returns null for unregistered tool', () {
      expect(registry.get('nonexistent'), isNull);
    });

    test('executes a registered tool', () async {
      registry.register(
        Tool(
          name: 'echo',
          description: 'Echoes input',
          parameters: {
            'properties': {
              'msg': {'type': 'string'},
            },
          },
          execute: (args, ctx) async => args['msg'] as String,
        ),
      );

      final result = await registry.execute('echo', {'msg': 'hello'});
      expect(result.success, true);
      expect(result.output, 'hello');
    });

    test('returns failure for unregistered tool execution', () async {
      final result = await registry.execute('nonexistent', {});
      expect(result.success, false);
      expect(result.error, contains('not found'));
    });

    test('permission filtering hides restricted tools', () {
      registry.register(
        Tool(
          name: 'read_tool',
          description: 'Read',
          parameters: {},
          requiredPermission: ToolPermission.read,
          execute: (args, ctx) async => 'read',
        ),
      );
      registry.register(
        Tool(
          name: 'exec_tool',
          description: 'Execute',
          parameters: {},
          requiredPermission: ToolPermission.execute,
          execute: (args, ctx) async => 'exec',
        ),
      );

      registry.setPermission(ToolPermission.read);
      expect(registry.availableTools.length, 1);
      expect(registry.availableTools.first.name, 'read_tool');

      registry.setPermission(ToolPermission.execute);
      expect(registry.availableTools.length, 2);
    });

    test('deny permission when tool requires higher level', () async {
      registry.setPermission(ToolPermission.read);
      registry.register(
        Tool(
          name: 'write_tool',
          description: 'Write',
          parameters: {},
          requiredPermission: ToolPermission.write,
          execute: (args, ctx) async => 'written',
        ),
      );

      final result = await registry.execute('write_tool', {});
      expect(result.success, false);
      expect(result.error, contains('Permission denied'));
    });

    test('buildToolDescriptions produces readable text', () {
      registry.setPermission(ToolPermission.read);
      registry.register(
        Tool(
          name: 'search',
          description: 'Search documents',
          parameters: {
            'properties': {
              'query': {'type': 'string'},
            },
          },
          execute: (args, ctx) async => 'results',
        ),
      );

      final desc = registry.buildToolDescriptions();
      expect(desc, contains('search'));
      expect(desc, contains('Search documents'));
      expect(desc, contains('query'));
    });

    test('catches tool execution errors', () async {
      registry.register(
        Tool(
          name: 'failing_tool',
          description: 'Always fails',
          parameters: {},
          execute: (args, ctx) async => throw Exception('boom'),
        ),
      );

      final result = await registry.execute('failing_tool', {});
      expect(result.success, false);
      expect(result.error, contains('boom'));
    });

    group('standardTools', () {
      late List<Tool> tools;

      setUp(() {
        tools = ToolImplementations.standardTools();
      });

      test('includes all standard tools', () {
        final names = tools.map((t) => t.name).toList();
        expect(names, contains('web_search'));
        expect(names, contains('file_read'));
        expect(names, contains('file_write'));
        expect(names, contains('file_list'));
        expect(names, contains('code_exec'));
        expect(names, contains('calculator'));
        expect(names, contains('document_search'));
        expect(names, contains('system_info'));
        expect(names, contains('current_time'));
      });

      test('calculator evaluates simple number', () async {
        final calc = tools.firstWhere((t) => t.name == 'calculator');
        final result = await calc.execute({
          'expression': '42',
        }, const ToolContext());
        expect(result, contains('42'));
      });

      test('current_time returns current time', () async {
        final timeTool = tools.firstWhere((t) => t.name == 'current_time');
        final result = await timeTool.execute({}, const ToolContext());
        expect(result, contains('-')); // date contains dashes
      });

      test('system_info returns platform info', () async {
        final infoTool = tools.firstWhere((t) => t.name == 'system_info');
        final result = await infoTool.execute({}, const ToolContext());
        expect(result, contains('Platform:'));
      });

      test('file_read fails for nonexistent file', () async {
        final readTool = tools.firstWhere((t) => t.name == 'file_read');
        try {
          await readTool.execute({
            'path': 'does_not_exist.txt',
          }, const ToolContext());
          fail('Expected exception');
        } catch (e) {
          // File read throws either FileSystemException or MissingPluginException in tests
          expect(
            e.toString(),
            anyOf(contains('not found'), contains('MissingPluginException')),
          );
        }
      });
    });
  });

  group('ToolResult', () {
    test('success factory', () {
      final result = ToolResult.success('ok', data: {'key': 'value'});
      expect(result.success, true);
      expect(result.output, 'ok');
      expect(result.data, {'key': 'value'});
      expect(result.error, isNull);
    });

    test('failure factory', () {
      final result = ToolResult.failure('oops', output: 'partial');
      expect(result.success, false);
      expect(result.output, 'partial');
      expect(result.error, 'oops');
    });
  });

  group('Tool.canUse', () {
    test('admin can use any tool', () {
      final tool = Tool(
        name: 't',
        description: '',
        parameters: {},
        requiredPermission: ToolPermission.execute,
        execute: (args, ctx) async => 'x',
      );
      expect(tool.canUse(ToolPermission.admin), true);
    });

    test('read cannot use execute tool', () {
      final tool = Tool(
        name: 't',
        description: '',
        parameters: {},
        requiredPermission: ToolPermission.execute,
        execute: (args, ctx) async => 'x',
      );
      expect(tool.canUse(ToolPermission.read), false);
    });
  });
}
