// import 'package:flutter/material.dart';

// class VideoForm extends StatefulWidget {
//   const VideoForm({super.key});

//   @override
//   State<VideoForm> createState() => _VideoFormState();
// }

// class _VideoFormState extends State<VideoForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class VideoPreview extends StatefulWidget {
  final File file;
  final VoidCallback onDelete;

  const VideoPreview({
    Key? key,
    required this.file,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = _controller.value.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: _togglePlayPause,
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ],
    );
  }
}



class AudioPreview extends StatefulWidget {
  @override
  _AudioPreviewState createState() => _AudioPreviewState();
}

class _AudioPreviewState extends State<AudioPreview> {
  FlutterSoundRecorder? _recorder;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _audioPath;
  bool _isRecorderInitialized = false; // ✅ Ajout de cette variable

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _recorder!.openRecorder();
      _isRecorderInitialized = true; // ✅ On marque le recorder comme initialisé
    } else {
      print("Permission microphone refusée");
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) {
      print("L'enregistreur n'est pas encore initialisé !");
      return;
    }

    Directory tempDir = await getTemporaryDirectory();
    _audioPath = "${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";

    await _recorder!.startRecorder(toFile: _audioPath, codec: Codec.aacADTS);

    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized) return; // ✅ Vérification de l'initialisation

    String? path = await _recorder!.stopRecorder();
    if (path != null) {
      setState(() {
        _isRecording = false;
        _audioPath = path; // ✅ On récupère bien le chemin
      });
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath != null) {
      await _audioPlayer.play(DeviceFileSource(_audioPath!));
      setState(() => _isPlaying = true);

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() => _isPlaying = false);
      });
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() => _isPlaying = false);
  }

  void _deleteAudio() {
    if (_audioPath != null) {
      File(_audioPath!).deleteSync();
      setState(() => _audioPath = null);
    }
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _isRecording ? _stopRecording : _startRecording,
          child: CircleAvatar(
            backgroundColor: _isRecording ? Colors.red : Colors.blue,
            child: Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.white),
          ),
        ),
        if (_audioPath != null) ...[
          GestureDetector(
            onTap: _isPlaying ? _pauseAudio : _playAudio,
            child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 35, color: Colors.green),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteAudio,
          ),
        ],
      ],
    );
  }
}