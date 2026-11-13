import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/content_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Resilient Al-Haramain Live Stream & Jumu'ah Khutbah player with
/// automatic audio/transcript fallback mode (no broken video errors).
class LivePlayerView extends StatefulWidget {
  const LivePlayerView({super.key, required this.streamId});

  final String streamId;

  @override
  State<LivePlayerView> createState() => _LivePlayerViewState();
}

class _LivePlayerViewState extends State<LivePlayerView> {
  bool _audioMode = false;
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ContentRepository>();
    final channel = repo.liveChannels.firstWhere(
      (c) => c.id == widget.streamId,
      orElse: () => repo.liveChannels.first,
    );

    return Scaffold(
      appBar: AppBar(title: Text(channel.mosqueName)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 220,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: DuyaColors.celestialHeroGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: DuyaColors.error,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        _audioMode ? 'AUDIO STREAM' : 'LIVE HD',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => setState(() => _audioMode = !_audioMode),
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                      icon: Icon(
                        _audioMode ? Icons.videocam_outlined : Icons.headphones,
                      ),
                      label: Text(_audioMode ? 'Video View' : 'Audio Mode'),
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: IconButton(
                    onPressed: () => setState(() => _isPlaying = !_isPlaying),
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: DuyaColors.desertGold,
                      size: 62,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  channel.titleEn,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          DuyaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khutbah & Broadcast Summary',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text('Delivered by ${channel.reciterOrImam}'),
                const SizedBox(height: 10),
                Text(channel.khutbahSummary),
                const SizedBox(height: 12),
                Chip(
                  avatar: const Icon(Icons.check_circle,
                      color: DuyaColors.emerald, size: 18),
                  label: Text(channel.audioFallbackDuration),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
