import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_icon_button.dart';
import '../../widgets/ai_orb.dart';
import 'chat_provider.dart';

/// Chat history sidebar / drawer for conversation management.
class ChatHistorySidebar extends ConsumerWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final bool isDesktop;

  const ChatHistorySidebar({
    super.key,
    required this.isOpen,
    required this.onClose,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!isOpen && !isDesktop) return const SizedBox.shrink();

    final sidebar = AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutCubic,
      left: isOpen || isDesktop ? 0 : -320,
      top: 0,
      bottom: 0,
      width: isDesktop ? 280 : 320,
      child: Semantics(
        label: 'Chat history sidebar',
        child: FocusableActionDetector(
          child: Container(
            decoration: BoxDecoration(
              gradient:
                  isDark
                      ? InhaleColors.gradientBackgroundDark
                      : InhaleColors.gradientBackground,
              border: Border(
                right: BorderSide(
                  color:
                      isDark
                          ? InhaleColors.glassBorderSubtle
                          : InhaleColors.lightGlassBorderSubtle,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildHeader(context, isDark),
                Expanded(
                  child:
                      chatState.sessions.isEmpty
                          ? _buildEmptyState(context, isDark, ref)
                          : _buildSessionList(context, chatState, isDark, ref),
                ),
                _buildFooter(context, isDark, ref),
              ],
            ),
          ),
        ),
      ),
    );

    if (isDesktop) {
      return sidebar;
    }

    return Stack(
      children: [
        if (isOpen)
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        sidebar,
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
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
            child: Text(
              'Conversations',
              style: InhaleTypography.titleLarge.copyWith(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (!isDesktop)
            GlassIconButton(
              onTap: onClose,
              icon: Icons.close_rounded,
              size: 40,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(InhaleSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 80,
              height: 80,
              child: AIOrb(size: 80, isActive: true),
            ),
            const SizedBox(height: InhaleSpacing.lg),
            Text(
              'No conversations yet',
              style: InhaleTypography.titleMedium.copyWith(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Text(
              'Start your first chat to see it here.',
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
              onTap: () => ref.read(chatProvider.notifier).newSession(),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList(
    BuildContext context,
    ChatState chatState,
    bool isDark,
    WidgetRef ref,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: InhaleSpacing.sm),
      itemCount: chatState.sessions.length,
      itemBuilder: (context, index) {
        final session = chatState.sessions[index];
        final isActive = chatState.activeSession?.id == session.id;
        return _SessionTile(
          session: session,
          isActive: isActive,
          onTap: () {
            ref.read(chatProvider.notifier).switchSession(session);
            onClose();
          },
          onRename: () => _showRenameDialog(context, ref, session),
          onDelete: () => _showDeleteDialog(context, ref, session),
          onPin: () => ref.read(chatProvider.notifier).togglePin(session.id),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      decoration: BoxDecoration(
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
      child: GlassButton(
        label: 'New Conversation',
        onTap: () => ref.read(chatProvider.notifier).newSession(),
        width: double.infinity,
      ),
    );
  }

  void _showRenameDialog(
    BuildContext context,
    WidgetRef ref,
    ChatSession session,
  ) {
    final controller = TextEditingController(text: session.title);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Rename Conversation'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Enter new title'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final newTitle = controller.text.trim();
                  if (newTitle.isNotEmpty) {
                    ref
                        .read(chatProvider.notifier)
                        .renameSession(session.id, newTitle);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Rename'),
              ),
            ],
          ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    ChatSession session,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Conversation'),
            content: Text('Delete "${session.title}"? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(chatProvider.notifier).deleteSession(session.id);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}

class _SessionTile extends ConsumerWidget {
  final ChatSession session;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const _SessionTile({
    required this.session,
    required this.isActive,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      label: session.title,
      button: true,
      onTap: onTap,
      child: GlassCard(
        margin: const EdgeInsets.symmetric(
          horizontal: InhaleSpacing.sm,
          vertical: InhaleSpacing.xs,
        ),
        padding: EdgeInsets.zero,
        elevated: isActive,
        glow: isActive,
        onTap: onTap,
        onLongPress: () => _showContextMenu(context),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(InhaleRadius.md),
          child: Padding(
            padding: const EdgeInsets.all(InhaleSpacing.sm),
            child: Row(
              children: [
                if (session.isPinned)
                  Padding(
                    padding: const EdgeInsets.only(right: InhaleSpacing.sm),
                    child: Icon(
                      Icons.push_pin_rounded,
                      size: 18,
                      color:
                          isDark
                              ? InhaleColors.electricBlue
                              : InhaleColors.lightPrimaryBlue,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title,
                        style: InhaleTypography.labelMedium.copyWith(
                          color:
                              isDark
                                  ? InhaleColors.textPrimary
                                  : InhaleColors.lightNavyText,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (session.messages.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          _getLastMessagePreview(session),
                          style: InhaleTypography.labelSmall.copyWith(
                            color:
                                isDark
                                    ? InhaleColors.textMuted
                                    : InhaleColors.lightTextSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (isActive)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? InhaleColors.electricBlue
                              : InhaleColors.lightPrimaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getLastMessagePreview(ChatSession session) {
    final lastMsg = session.messages.last;
    final prefix = lastMsg.isUser ? 'You: ' : 'AI: ';
    return '$prefix${lastMsg.content}';
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _SessionContextMenu(
            session: session,
            onRename: onRename,
            onDelete: onDelete,
            onPin: onPin,
          ),
    );
  }
}

class _SessionContextMenu extends StatelessWidget {
  final ChatSession session;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const _SessionContextMenu({
    required this.session,
    required this.onRename,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      margin: const EdgeInsets.all(InhaleSpacing.md),
      padding: const EdgeInsets.symmetric(vertical: InhaleSpacing.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              session.isPinned
                  ? Icons.push_pin_outlined
                  : Icons.push_pin_rounded,
              color:
                  isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
            ),
            title: Text(
              session.isPinned ? 'Unpin' : 'Pin',
              style: TextStyle(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onPin();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.edit_rounded,
              color:
                  isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
            ),
            title: Text(
              'Rename',
              style: TextStyle(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onRename();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
            title: const Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
