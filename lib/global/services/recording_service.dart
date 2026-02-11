import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class RecordingService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final StreamController<Duration> _recordingController =
      StreamController<Duration>.broadcast();

  Stream<Duration> get recordingStream => _recordingController.stream;
  Timer? _timer;
  Duration _duration = Duration.zero;
  String? _recordingPath;

  Future<String?> startRecording() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        throw Exception(
          'Microphone permission is permanently denied. Please enable it from settings.',
        );
      }
      throw Exception('Microphone permission denied');
    }

    final directory = await getApplicationDocumentsDirectory();

    late final AudioEncoder encoder;
    late final String fileExtension;

    if (Platform.isIOS) {
      encoder = AudioEncoder.aacLc;
      fileExtension = 'm4a';
    } else {
      encoder = AudioEncoder.aacLc;
      fileExtension = 'm4a';
    }

    _recordingPath =
        '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

    await _audioRecorder.start(
      RecordConfig(encoder: encoder, bitRate: 128000, sampleRate: 44100),
      path: _recordingPath!,
    );

    // start duration timer
    _duration = Duration.zero;
    _recordingController.add(_duration);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _duration = Duration(seconds: timer.tick);
      _recordingController.add(_duration);
    });

    return _recordingPath;
  }

  Future<String?> stopRecording() async {
    _timer?.cancel();
    _timer = null;
    final path = await _audioRecorder.stop();
    _duration = Duration.zero;
    _recordingController.add(_duration);
    return path;
  }

  Future<void> cancelRecording() async {
    _timer?.cancel();
    _timer = null;
    await _audioRecorder.stop();
    _duration = Duration.zero;
    _recordingController.add(_duration);
    _recordingPath = null;
  }
}
