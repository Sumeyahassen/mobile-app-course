import 'package:flutter/material.dart';
import 'package:ramadan_nasheed_app/services/audio_player_service.dart';
import '../models/nasheed_model.dart';
import '../services/audio_player_service.dart';

class NasheedListItem extends StatelessWidget {
  final Nasheed nasheed;
  final int index;
  final bool isPlaying;

  const NasheedListItem({
    Key? key,
    required this.nasheed,
    required this.index,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isPlaying ? Colors.green.shade800 : Colors.green.shade900,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          nasheed.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${nasheed.artist} • ${nasheed.language}',
          style: const TextStyle(color: Colors.amber),
        ),
        trailing: Icon(
          isPlaying ? Icons.volume_up : Icons.play_arrow,
          color: Colors.amber,
        ),
        onTap: () => AudioService.playIndex(index),
      ),
    );
  }
}