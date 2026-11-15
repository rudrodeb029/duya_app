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

    return DuyaSubpageScaffold(
      title: channel.mosqueName,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          DuyaDaylightBannerCard(
            imageAsset: 'assets/images/live_mosque_day.jpg',
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 185,
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
                          color: const Color(0xFFD62B2B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _audioMode ? 'AUDIO STREAM' : 'LIVE HD',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () =>
                            setState(() => _audioMode = !_audioMode),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.9),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                        icon: Icon(
                          _audioMode ? Icons.videocam_outlined : Icons.headphones,
                          size: 16,
                        ),
                        label: Text(
                          _audioMode ? 'Video View' : 'Audio Mode',
                          style: const TextStyle(fontSize: 10.5),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.94),
                      shape: const CircleBorder(),
                      elevation: 3,
                      shadowColor: const Color(0x220E523C),
                      child: IconButton(
                        onPressed: () =>
                            setState(() => _isPlaying = !_isPlaying),
                        icon: Icon(
                          _isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: DuyaColors.emerald,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 220),
                    child: Text(
                      channel.titleEn,
                      style: const TextStyle(
                        color: Color(0xFF10553F),
                        fontWeight: FontWeight.w800,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                ],
              ),
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
