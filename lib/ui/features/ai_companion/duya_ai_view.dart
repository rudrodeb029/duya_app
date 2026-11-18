import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/ai_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Conversational Duya AI Companion screen with quick-prompt chips and deep route links.
class DuyaAiView extends StatefulWidget {
  const DuyaAiView({super.key});

  @override
  State<DuyaAiView> createState() => _DuyaAiViewState();
}

class _DuyaAiViewState extends State<DuyaAiView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send([String? preset]) {
    final text = preset ?? _controller.text;
    if (text.trim().isEmpty) return;
    context.read<AiRepository>().sendMessage(text);
    if (preset == null) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AiRepository>();

    return DuyaSubpageScaffold(
      title: 'Duya AI',
      subtitle: 'Ask about Umrah, Duas & daily worship',
      body: Column(
        children: [
          SizedBox(
            height: 46,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: AiRepository.quickPrompts.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final prompt = AiRepository.quickPrompts[i];
                return ActionChip(
                  backgroundColor: Colors.white,
                  label: Text(prompt, style: const TextStyle(fontSize: 10.5)),
                  onPressed: () => _send(prompt),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: repo.messages.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final msg = repo.messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.82,
                    ),
                    child: DuyaCard(
                      color: msg.isUser ? DuyaColors.emerald : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isUser ? Colors.white : null,
                            ),
                          ),
                          if (msg.actionLinks.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: msg.actionLinks
                                  .map(
                                    (link) => OutlinedButton(
                                      onPressed: () => context.push(link.route),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                      ),
                                      child: Text(
                                        '${link.label} →',
                                        style: const TextStyle(fontSize: 10.5),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ask about Umrah, Duas, Makkah...',
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: DuyaColors.emerald,
                    child: IconButton(
                      onPressed: () => _send(),
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
