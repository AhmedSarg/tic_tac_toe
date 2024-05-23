import 'package:audioplayers/audioplayers.dart';

const String _baseUrl = "sound/";
const String _winSound = "${_baseUrl}win.mp3";
const String _loseSound = "${_baseUrl}lose.mp3";
const String _moveSound = "${_baseUrl}move.mp3";

const String yosefProfileMp3 = "${_baseUrl}joe.mp3";
const String ahmedProfileMp3 = "${_baseUrl}ahmed.mp3";

final AudioManager _instance = AudioManagerImpl();

abstract class AudioManager {
  Future<void> init();

  Future<void> playWinSound();

  Future<void> playLoseSound();

  Future<void> playMovementSound();

  Future<void> playProfile(String path);

  Future<void> stop();

  static AudioManager get instance => _instance;
}

class AudioManagerImpl extends AudioManager {
  late final AudioPlayer _player;

  @override
  Future<void> init() async {
    _player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    await _player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
  }

  @override
  Future<void> playLoseSound() async {
    await _player.stop();
    await _player.setSource(AssetSource(_loseSound));
    await _player.resume();
  }

  @override
  Future<void> playMovementSound() async {
    await _player.stop();
    await _player.setSource(AssetSource(_moveSound));
    await _player.resume();
  }

  @override
  Future<void> playWinSound() async {
    await _player.stop();
    await _player.setSource(AssetSource(_winSound));
    await _player.resume();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> playProfile(String path) async {
    await _player.stop();
    await _player.setSource(AssetSource(path));
    await _player.resume();
  }
}
