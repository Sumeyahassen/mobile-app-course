import 'package:just_audio/just_audio.dart';
import 'package:ramadan_nasheed_app/models/nasheed_model.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();
  static ConcatenatingAudioSource? _playlist;

  static AudioPlayer get player => _player;

  static Future<void> initPlaylist(List<Nasheed> nasheeds) async {
    _playlist = ConcatenatingAudioSource(
      children: nasheeds
          .map((n) => AudioSource.asset('assets/audio/${n.file}'))
          .toList(),
    );
    await _player.setAudioSource(_playlist!);
  }

  static void playIndex(int index) {
    _player.seek(Duration.zero, index: index);
    _player.play();
  }

  static void togglePlayPause() {
    _player.playing ? _player.pause() : _player.play();
  }

  static void next() => _player.seekToNext();
  static void previous() => _player.seekToPrevious();
}