import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_icon_button.dart';
import '../../widgets/glass_chat_bubble.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/ai_orb.dart';
import 'chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _scrollTimer;

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    ref.read(chatProvider.notifier).sendMessage(text);
    _scheduleScrollToBottom();
  }

  void _scheduleScrollToBottom() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'AI Chat',
        actions: [
          if (chatState.activeSession != null)
            Padding(
              padding: const EdgeInsets.only(right: InhaleSpacing.md),
              child: _ModelBadge(
                mode: chatState.activeSession!.mode,
                isGenerating: chatState.isGenerating,
              ),
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (chatState.activeSession != null) ...[
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      vertical: InhaleSpacing.md,
                    ),
                    itemCount: chatState.activeSession!.messages.length,
                    itemBuilder: (context, index) {
                      final msg = chatState.activeSession!.messages[index];
                      return GlassChatBubble(
                        message: msg.content,
                        isUser: msg.isUser,
                        timestamp: _formatTime(msg.timestamp),
                        isStreaming: msg.isStreaming,
                        isLast:
                            index ==
                            chatState.activeSession!.messages.length - 1,
                      );
                    },
                  ),
                ),
                if (chatState.isGenerating) _buildTypingIndicator(isDark),
              ] else ...[
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(InhaleSpacing.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 100,
                            height: 100,
                            child: AIOrb(size: 100, isActive: true),
                          ),
                          const SizedBox(height: InhaleSpacing.lg),
                          Text(
                            'Start a Conversation',
                            style: InhaleTypography.headlineMedium.copyWith(
                              color:
                                  isDark
                                      ? InhaleColors.textPrimary
                                      : InhaleColors.lightNavyText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: InhaleSpacing.sm),
                          Text(
                            'Ask questions, brainstorm ideas,\nor just chat.',
                            style: InhaleTypography.bodyMedium.copyWith(
                              color:
                                  isDark
                                      ? InhaleColors.textSecondary
                                      : InhaleColors.lightTextSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: InhaleSpacing.lg),
                          GlassButton(
                            label: 'New Conversation',
                            onTap:
                                () =>
                                    ref
                                        .read(chatProvider.notifier)
                                        .newSession(),
                            width: 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              _buildComposer(context, chatState.isGenerating, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: InhaleSpacing.lg,
        vertical: InhaleSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              gradient: InhaleColors.gradientPrimary,
              borderRadius: BorderRadius.circular(InhaleRadius.xs),
            ),
            child: const Center(
              child: Icon(
                Icons.smart_toy_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: InhaleSpacing.sm),
          const _AnimatedDots(),
        ],
      ),
    );
  }

  Widget _buildComposer(BuildContext context, bool isGenerating, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      decoration: BoxDecoration(
        color:
            isDark
                ? InhaleColors.midnight.withValues(alpha: 0.8)
                : InhaleColors.pureWhite.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color:
                isDark
                    ? InhaleColors.glassBorderSubtle
                    : InhaleColors.lightGlassBorderSubtle,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GlassTextField(
              controller: _inputController,
              hintText:
                  isGenerating ? 'AI is thinking...' : 'Type a message...',
              onSubmitted: (_) => _sendMessage(),
              maxLines: null,
              minLines: 1,
              enabled: !isGenerating,
              prefixIcon:
                  isGenerating
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : null,
            ),
          ),
          const SizedBox(width: InhaleSpacing.sm),
          GlassIconButton(
            onTap:
                isGenerating
                    ? () => ref.read(chatProvider.notifier).stopGeneration()
                    : _sendMessage,
            icon: isGenerating ? Icons.stop_rounded : Icons.send_rounded,
            color:
                isGenerating
                    ? InhaleColors.error
                    : (isDark
                        ? InhaleColors.electricBlue
                        : InhaleColors.lightPrimaryBlue),
            size: 48,
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _ModelBadge extends StatelessWidget {
  final String mode;
  final bool isGenerating;

  const _ModelBadge({required this.mode, required this.isGenerating});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color:
            isGenerating
                ? (isDark
                    ? InhaleColors.electricBlue.withValues(alpha: 0.2)
                    : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.15))
                : (isDark
                    ? InhaleColors.glassSurfaceMedium
                    : InhaleColors.lightGlassSurface),
        borderRadius: BorderRadius.circular(InhaleRadius.pill),
        border: Border.all(
          color:
              isGenerating
                  ? (isDark
                      ? InhaleColors.electricBlue.withValues(alpha: 0.4)
                      : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.3))
                  : (isDark
                      ? InhaleColors.glassBorderSubtle
                      : InhaleColors.lightGlassBorderSubtle),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color:
                  isGenerating
                      ? (isDark
                          ? InhaleColors.electricBlue
                          : InhaleColors.lightPrimaryBlue)
                      : (isDark ? InhaleColors.success : InhaleColors.success),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            mode.toUpperCase(),
            style: InhaleTypography.labelSmall.copyWith(
              color:
                  isDark
                      ? InhaleColors.textSecondary
                      : InhaleColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedDots extends StatefulWidget {
  const _AnimatedDots();

  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          children: List.generate(3, (index) {
            final delay = index * 0.15;
            final value = (_controller.value - delay).clamp(0.0, 1.0);
            final scale = 0.5 + 0.5 * (1 - (value - 0.5).abs() * 2);
            final opacity = 0.3 + 0.7 * (1 - (value - 0.5).abs() * 2);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: (isDark
                            ? InhaleColors.electricBlue
                            : InhaleColors.lightPrimaryBlue)
                        .withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
