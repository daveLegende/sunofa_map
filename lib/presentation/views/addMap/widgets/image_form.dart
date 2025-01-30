import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import 'import_or_doing_widget.dart';

class ImageForm extends StatefulWidget {
  const ImageForm({
    super.key,
    this.onContinue,
    required this.selectedImages,
    required this.selectedVideos,
    required this.selectedAudios,
  });
  final VoidCallback? onContinue;
  final List<File> selectedImages;
  final List<File> selectedVideos;
  final List<File> selectedAudios;

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  // audio
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String _recordedFilePath = '';
  Duration _recordedDuration = Duration.zero;
  Timer? _recordingTimer;
  DateTime? _recordingStartTime;

  @override
  void initState() {
    super.initState();
    requestMicrophonePermission();
  }

  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      print('Microphone permission denied');
    }
  }

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/recording.m4a';
  }

  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        String path = await _getFilePath();
        await _audioRecorder.start(
          const RecordConfig(),
          path: path,
        );
        setState(() {
          _isRecording = true;
          _recordedFilePath = path;
          _recordingStartTime = DateTime.now();
          _recordedDuration = Duration.zero;
        });

        // Démarrer un timer pour mettre à jour la durée
        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_recordingStartTime != null) {
            setState(() {
              _recordedDuration =
                  DateTime.now().difference(_recordingStartTime!);
            });
          }
        });
      } else {
        print("Permission refusée");
      }
    } catch (e) {
      print('Erreur lors du démarrage de l\'enregistrement : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _recordedFilePath = path ?? _recordedFilePath;
        _recordingTimer?.cancel();
      });
    } catch (e) {
      print('Erreur lors de l\'arrêt de l\'enregistrement : $e');
    }
  }

  Future<void> playRecording() async {
    if (_recordedFilePath.isNotEmpty && File(_recordedFilePath).existsSync()) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath)).then((r) {
        setState(() {
          _isPlaying = true;
        });
      });
    } else {
      print("Fichier audio introuvable.");
    }
  }

  Future<void> stopPlaying() async {
    await _audioPlayer.stop().then((_) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> deleteAudioRecord() async {
    if (_recordedFilePath.isNotEmpty && File(_recordedFilePath).existsSync()) {
      try {
        await File(_recordedFilePath).delete();
        setState(() {
          _recordedFilePath = "";
          _recordedDuration = Duration.zero;
          _isRecording = false;
          _isPlaying = false;
        });
        print("Fichier audio supprimé avec succès.");
      } catch (e) {
        print("Erreur lors de la suppression du fichier : $e");
      }
    } else {
      print("Aucun fichier à supprimer.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section pour les images
            Text(
              'Ajouter des images',
              style: AppTheme().stylish1(
                15,
                AppTheme.black,
                isBold: true,
              ),
            ),
            SizedBox(height: context.heightPercent(2)),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...widget.selectedImages.map(
                  (image) => ImagePreview(
                    file: image,
                    onDelete: () {
                      setState(() {
                        widget.selectedImages.remove(image);
                      });
                    },
                  ),
                ),
                AddFileButton(
                  onTap: () => selectFile("image"),
                  label: 'Image',
                ),
              ],
            ),
            SizedBox(height: context.heightPercent(2)),

            // Section pour les vidéos
            Text(
              'Référence vidéo',
              style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
            ),
            SizedBox(height: context.heightPercent(2)),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...widget.selectedVideos.map(
                  (video) => VideoPreview(
                    file: video,
                    onDelete: () {
                      setState(() {
                        widget.selectedVideos.remove(video);
                      });
                    },
                  ),
                ),
                AddFileButton(
                  onTap: () => selectFile("video"),
                  label: 'Vidéo',
                ),
              ],
            ),
            SizedBox(height: context.heightPercent(2)),

            // Section pour les audios
            Text(
              'Référence audio',
              style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
            ),
            SizedBox(height: context.heightPercent(2)),
            Column(
              children: [
                ...widget.selectedAudios.map((audio) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.lightPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.audiotrack),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            audio.path.split('/').last,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: AppTheme.complementaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.selectedAudios.remove(audio);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
                AddFileButton(
                  onTap: () {
                    selectFile("audio");
                  },
                  label: 'Audio',
                ),
              ],
            ),
            SizedBox(height: context.heightPercent(2)),
            const Row(
              children: [
                Expanded(child: CustomDivider()),
                Center(
                  child: Text(
                    "Ou",
                    style: TextStyle(color: mred),
                  ),
                ),
                Expanded(child: CustomDivider()),
              ],
            ),
            SizedBox(height: context.heightPercent(2)),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_isRecording) {
                          stopRecording();
                          print("********************${_recordedFilePath}");
                        } else {
                          startRecording();
                          print(
                              "********************${_recordedDuration.inSeconds}");
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _isPlaying ? mgrey[300] : mred,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: HeroIcon(
                          _isRecording ? HeroIcons.stop : HeroIcons.microphone,
                          color: mwhite,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _isPlaying ? stopPlaying : playRecording,
                          child: HeroIcon(
                            _isPlaying ? HeroIcons.pause : HeroIcons.play,
                            size: 35,
                            color: _recordedDuration.inSeconds > 0
                                ? AppTheme.primaryColor
                                : mgrey[300],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: size.width * .35,
                          height: 2,
                          decoration: BoxDecoration(
                            color: _recordedDuration.inSeconds > 0
                                ? AppTheme.primaryColor
                                : mgrey[300],
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Helpers().formatAudioDuration(_recordedDuration),
                          style: AppTheme().stylish1(
                            16,
                            _recordedDuration.inSeconds > 0
                                ? AppTheme.primaryColor
                                : mgrey[300]!,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: deleteAudioRecord,
                      child: HeroIcon(
                        HeroIcons.trash,
                        color:
                            _recordedDuration.inSeconds > 0 ? mred : mgrey[300],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.heightPercent(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_isRecording) {
                          stopRecording();
                          print("********************${_recordedFilePath}");
                        } else {
                          startRecording();
                          print(
                              "********************${_recordedDuration.inSeconds}");
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _isPlaying ? mgrey[300] : mred,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: HeroIcon(
                          _isRecording ? HeroIcons.stop : HeroIcons.microphone,
                          color: mwhite,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _isPlaying ? stopPlaying : playRecording,
                          child: HeroIcon(
                            _isPlaying ? HeroIcons.pause : HeroIcons.play,
                            size: 35,
                            color: _recordedDuration.inSeconds > 0
                                ? AppTheme.primaryColor
                                : mgrey[300],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: size.width * .35,
                          height: 2,
                          decoration: BoxDecoration(
                            color: _recordedDuration.inSeconds > 0
                                ? AppTheme.primaryColor
                                : mgrey[300],
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Helpers().formatAudioDuration(_recordedDuration),
                          style: AppTheme().stylish1(
                            16,
                            _recordedDuration.inSeconds > 0
                                ? AppTheme.primaryColor
                                : mgrey[300]!,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: deleteAudioRecord,
                      child: HeroIcon(
                        HeroIcons.trash,
                        color:
                            _recordedDuration.inSeconds > 0 ? mred : mgrey[300],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.heightPercent(5)),
            // Bouton pour soumettre
            SubmitButton(
              text: "Continuer",
              onTap: widget.onContinue,
            ),
            SizedBox(height: context.heightPercent(2)),
          ],
        ),
      ],
    );
  }

  Future<void> selectFile(String type) async {
    FileType fileType;
    switch (type) {
      case 'image':
        fileType = FileType.image;
        break;
      case 'audio':
        fileType = FileType.audio;
        break;
      case 'video':
        fileType = FileType.video;
        break;
      default:
        fileType = FileType.any;
    }

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      setState(() {
        File file = File(result.files.single.path!);
        if (type == 'image') {
          widget.selectedImages.add(file);
        } else if (type == 'audio') {
          widget.selectedAudios.add(file);
        } else if (type == 'video') {
          widget.selectedVideos.add(file);
        }
      });
    } else {
      print('Aucun fichier sélectionné.');
    }
  }
}

class ImagePreview extends StatelessWidget {
  final File file;
  final VoidCallback onDelete;

  const ImagePreview({super.key, required this.file, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    var width = context.width / 3.5;
    return Stack(
      children: [
        Image.file(
          file,
          height: 100,
          width: width,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: onDelete,
            child: const CancelStackWidget(),
          ),
        ),
      ],
    );
  }
}

class CancelStackWidget extends StatelessWidget {
  const CancelStackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.complementaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.close,
        size: 18,
        color: mwhite,
      ),
    );
  }
}

class VideoPreview extends StatelessWidget {
  final File file;
  final VoidCallback onDelete;

  const VideoPreview({super.key, required this.file, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    var width = context.width / 3.5;
    return Stack(
      children: [
        Container(
          height: 100,
          width: width,
          color: Colors.black12,
          child: const Center(child: Icon(Icons.play_circle_outline, size: 30)),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: onDelete,
            child: const CancelStackWidget(),
          ),
        ),
      ],
    );
  }
}

class AddFileButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const AddFileButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    var width = context.width / 3.5;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeroIcon(HeroIcons.plus, size: 40),
            SizedBox(height: context.heightPercent(1)),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
