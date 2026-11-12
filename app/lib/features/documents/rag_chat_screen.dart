import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/di.dart';
import '../../core/theme/inhale_colors.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_chat_bubble.dart';
import '../../widgets/glass_button.dart';
import '../../ai/rag/rag_service.dart';

class RagChatScreen extends ConsumerStatefulWidget {
  final int documentId;
  final String documentTitle;

  const RagChatScreen({
    super.key,
    required this.documentId,
    required this.documentTitle,
  });

  @override
  ConsumerState<RagChatScreen> createState() => _RagChatScreenState();
}

class _RagChatScreenState extends ConsumerState<RagChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isAsking = false;
  String _currentAnswer = '';
  List<CitationRef> _citations = [];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _askQuestion() async {
    final question = _controller.text.trim();
    if (question.isEmpty || _isAsking) return;

    setState(() {
      _isAsking = true;
      _currentAnswer = '';
      _citations = [];
    });

    _controller.clear();

    try {
      final ragService = ref.read(ragServiceProvider);
      final aiEngine = ref.read(aiEngineProvider);

      final result = await ragService.answerWithCitations(
        question,
        documentId: widget.documentId.toString(),
        limit: 5,
        generationEngine: aiEngine,
      );

      setState(() {
        _currentAnswer = result.answer;
        _citations = result.citations;
        _isAsking = false;
      });
    } catch (e) {
      setState(() {
        _currentAnswer = 'Error: $e';
        _isAsking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Ask about ${widget.documentTitle}',
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showCitations(context, isDark),
            tooltip: 'View citations',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                if (_currentAnswer.isNotEmpty) ...[
                  GlassChatBubble(
                    message: _currentAnswer,
                    isUser: false,
                    timestamp: DateTime.now().toString(),
                    isStreaming: _isAsking,
                  ),
                  const SizedBox(height: 16),
                  if (_citations.isNotEmpty) _buildCitations(isDark),
                ] else if (_isAsking) ...[
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Analyzing document...'),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  _buildWelcomeCard(isDark),
                ],
              ],
            ),
          ),
          _buildInputArea(isDark),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(bool isDark) {
    return Card(
      color: isDark
          ? InhaleColors.glassGrey
          : InhaleColors.frostWhite.withValues(alpha: 0.8),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.auto_awesome, size: 48, color: InhaleColors.blue),
            SizedBox(height: 16),
            Text(
              'Ask anything about this document',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'I\'ll find relevant information and cite the source pages.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Try asking:\n• What are the main topics?\n• Summarize section 2\n• Explain the key concepts',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitations(bool isDark) {
    return Card(
      color: isDark
          ? InhaleColors.deepNavy.withValues(alpha: 0.3)
          : InhaleColors.blue.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sources',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ..._citations.map(
              (cite) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: InhaleColors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${cite.index}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cite.citation,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            cite.preview,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? InhaleColors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GlassTextField(
              controller: _controller,
              hintText: 'Ask a question...',
              onSubmitted: (_) => _askQuestion(),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 12),
          GlassButton(
            onTap: _isAsking ? null : _askQuestion,
            child: Icon(
              _isAsking ? Icons.hourglass_empty : Icons.send,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _showCitations(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? InhaleColors.darkCharcoal : Colors.white,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Citations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_citations.isEmpty)
              const Text('No citations yet. Ask a question first.')
            else
              ..._citations.map(
                (cite) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: InhaleColors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${cite.index}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              cite.citation,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cite.preview,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
