import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class VoiceRecordingScreen extends StatefulWidget {
  const VoiceRecordingScreen({super.key});

  @override
  State<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends State<VoiceRecordingScreen> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedFilePath;
  Duration _recordDuration = Duration.zero;
  Duration _playDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء السماح بالوصول إلى الميكروفون')),
      );
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _recorder.hasPermission()) {
        final path = '/storage/emulated/0/Download/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _recorder.start(
          RecordConfig(),
          path: path,
        );
        setState(() {
          _isRecording = true;
          _recordDuration = Duration.zero;
        });

        // تحديث المدة
        while (_isRecording) {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _recordDuration = Duration(seconds: _recordDuration.inSeconds + 1);
          });
        }
      }
    } catch (e) {
      print('Error recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _recorder.stop();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _playRecording() async {
    if (_recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
      setState(() => _isPlaying = true);

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() => _isPlaying = false);
      });
    }
  }

  Future<void> _stopPlaying() async {
    await _audioPlayer.stop();
    setState(() => _isPlaying = false);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _recorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'التسجيل الصوتي'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // دائرة التسجيل
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _isRecording ? Colors.red : AppTheme.goldColor,
                    _isRecording ? Colors.redAccent : AppTheme.goldLight,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (_isRecording ? Colors.red : AppTheme.goldColor).withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _formatDuration(_recordDuration),
                  style: const TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // أزرار التسجيل
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRecording && _recordedFilePath == null)
                  ElevatedButton.icon(
                    onPressed: _startRecording,
                    icon: const Icon(Icons.mic),
                    label: const Text('بدء التسجيل'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                if (_isRecording)
                  ElevatedButton.icon(
                    onPressed: _stopRecording,
                    icon: const Icon(Icons.stop),
                    label: const Text('إيقاف التسجيل'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // إذا كان هناك تسجيل محفوظ
            if (_recordedFilePath != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'التسجيل المحفوظ',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.stop : Icons.play_arrow,
                            color: AppTheme.goldColor,
                            size: 40,
                          ),
                          onPressed: _isPlaying ? _stopPlaying : _playRecording,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red, size: 30),
                          onPressed: () {
                            setState(() {
                              _recordedFilePath = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
