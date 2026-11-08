import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_icon_button.dart';
import '../../widgets/glass_chat_bubble.dart';
import '../../widgets/glass_app_bar.dart';
import 'chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    ref.read(chatProvider.notifier).sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    return Scaffold(
      appBar: GlassAppBar(title: 'AI Chat'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: Column(
          children: [
            if (chatState.activeSession != null) ...[
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chatState.activeSession!.messages.length,
                  itemBuilder: (context, index) {
                    final msg = chatState.activeSession!.messages[index];
                    return GlassChatBubble(
                      message: msg.content,
                      isUser: msg.isUser,
                      timestamp: msg.timestamp.toString(),
                      isStreaming: msg.isStreaming,
                      isLast:
                          index == chatState.activeSession!.messages.length - 1,
                    );
                  },
                ),
              ),
            ] else ...[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.smart_toy_rounded,
                      size: 64,
                      color: InhaleColors.primaryBlue,
                    ),
                    const SizedBox(height: InhaleSpacing.md),
                    Text(
                      'Start a Conversation',
                      style: InhaleTypography.headlineMedium,
                    ),
                    const SizedBox(height: InhaleSpacing.md),
                    GlassButton(
                      label: 'New Conversation',
                      onTap: () => ref.read(chatProvider.notifier).newSession(),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: EdgeInsets.all(InhaleSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: GlassTextField(
                      controller: _inputController,
                      hintText: 'Type a message...',
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  GlassIconButton(
                    onTap:
                        chatState.isGenerating
                            ? () =>
                                ref.read(chatProvider.notifier).stopGeneration()
                            : _sendMessage,
                    icon: Icon(
                      chatState.isGenerating
                          ? Icons.stop_rounded
                          : Icons.send_rounded,
                      color:
                          chatState.isGenerating
                              ? InhaleColors.error
                              : InhaleColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
