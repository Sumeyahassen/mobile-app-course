import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:ramadan_nasheed_app/services/audio_player_service.dart';
import '../models/nasheed_model.dart';
import '../services/audio_player_service.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nasheeds = Provider.of<List<Nasheed>>(context);
    return StreamBuilder<SequenceState?>(
      stream: AudioService.player.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) return const SizedBox();
        final currentNasheed = nasheeds[state!.currentIndex];

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade900, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<Duration?>(
                stream: AudioService.player.positionStream,
                builder: (context, posSnapshot) {
                  final position = posSnapshot.data ?? Duration.zero;
                  final duration = AudioService.player.duration ?? Duration.zero;
                  return SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                      onChanged: (value) => AudioService.player.seek(Duration(seconds: value.toInt())),
                      activeColor: Colors.amber,
                      inactiveColor: Colors.green.shade700,
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.amber, size: 32),
                    onPressed: AudioService.previous,
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: StreamBuilder<bool>(
                      stream: AudioService.player.playingStream,
                      builder: (context, snapshot) {
                        final playing = snapshot.data ?? false;
                        return Icon(playing ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            color: Colors.amber);
                      },
                    ),
                    onPressed: AudioService.togglePlayPause,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.amber, size: 32),
                    onPressed: AudioService.next,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${currentNasheed.title} • ${currentNasheed.artist}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}