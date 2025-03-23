import 'package:flutter/material.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/presentation/views/viewImage/view_image.dart';
import 'package:sunofa_map/presentation/views/viewImage/view_video.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:http/http.dart' as http;

class VocalAdresse extends StatelessWidget {
  const VocalAdresse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        // vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.play_arrow,
            size: 30,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Slider(
              activeColor: AppTheme.primaryColor,
              inactiveColor: Colors.grey[600],
              value: 0,
              onChanged: (value) {},
              min: 0.0,
              max: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}

class AdresseImage extends StatefulWidget {
  const AdresseImage({
    super.key,
    required this.image,
    this.upload,
    required this.size,
    required this.isEdit,
  });

  final VoidCallback? upload;
  final String image;
  final Size size;
  final bool isEdit;

  @override
  State<AdresseImage> createState() => _AdresseImageState();
}

class _AdresseImageState extends State<AdresseImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isEdit
            ? showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ModalEditContainer(
                    size: widget.size,
                    seeFile: "Voir l'image",
                    uploadFile: "Modifier l'image",
                    onView: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewImage(
                              image: widget.image,
                            );
                          },
                        ),
                      );
                    },
                    onUpload: widget.upload,
                  );
                },
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ViewImage(
                      image: widget.image,
                    );
                  },
                ),
              );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Hero(
          tag: widget.image,
          child: Image.network(
            widget.image,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ModalEditContainer extends StatelessWidget {
  const ModalEditContainer({
    super.key,
    required this.size,
    required this.seeFile,
    required this.uploadFile,
    this.onView,
    this.onUpload,
  });

  final Size size;
  final String seeFile, uploadFile;
  final VoidCallback? onView, onUpload;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: size.width * .4,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: mwhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: onView,
                    title: Text(
                      seeFile,
                      style: AppTheme().stylish1(
                        15,
                        mblack,
                        isBold: true,
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  ListTile(
                    onTap: onUpload,
                    title: Text(
                      uploadFile,
                      style: AppTheme().stylish1(
                        15,
                        mblack,
                        isBold: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class AdresseImage extends StatefulWidget {
//   const AdresseImage({
//     super.key,
//     required this.image,
//     this.onTap,
//     this.onImageLoaded, // Nouveau paramètre pour envoyer l'URL complète
//   });

//   final VoidCallback? onTap;
//   final String image;
//   final ValueChanged<String>? onImageLoaded; // Ajout du callback

//   @override
//   State<AdresseImage> createState() => _AdresseImageState();
// }

// class _AdresseImageState extends State<AdresseImage> {
//   String? imageUrl;

//   @override
//   void initState() {
//     super.initState();
//     _loadImageUrl();
//   }

//   Future<void> _loadImageUrl() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cachedUrl = prefs.getString(widget.image);

//     if (cachedUrl != null) {
//       setState(() {
//         imageUrl = cachedUrl;
//       });
//       widget.onImageLoaded?.call(cachedUrl); // Envoi de l'URL
//     } else {
//       await _fetchAndCacheImageUrl();
//     }
//   }

//   Future<void> _fetchAndCacheImageUrl() async {
//     try {
//       final token = await PreferenceServices().getToken();
//       final response = await http.get(
//         Uri.parse(APIURL.fileUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': "Bearer $token",
//         },
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final fullUrl = "${APIURL.fileUrl}/${widget.image}";

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString(widget.image, fullUrl);

//         setState(() {
//           imageUrl = fullUrl;
//         });
//         widget.onImageLoaded?.call(fullUrl); // Envoi de l'URL
//       } else {
//         throw Exception("Erreur lors de la récupération de l'image");
//       }
//     } catch (e) {
//       setState(() {
//         imageUrl = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (imageUrl == null) {
//       return const LoadingCircle();
//     }

//     return GestureDetector(
//       onTap: widget.onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Hero(
//           tag: widget.image,
//           child: Image.network(
//             imageUrl!,
//             height: 100,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

class AdresseVideo extends StatefulWidget {
  const AdresseVideo({
    super.key,
    required this.video,
    this.upload,
    required this.size,
    required this.isEdit,
  });

  final String video;
  final Size size;
  final bool isEdit;
  final VoidCallback? upload;

  @override
  _AdresseVideoState createState() => _AdresseVideoState();
}

class _AdresseVideoState extends State<AdresseVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller =
          VideoPlayerController.network("${APIURL.fileUrl}/${widget.video}")
            ..initialize()
            ..setLooping(true);
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onDoubleTap: () {
            widget.isEdit
                ? showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModalEditContainer(
                        size: widget.size,
                        seeFile: "Visionner la vidéo",
                        uploadFile: "Modifier la vidéo",
                        onView: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewVideo(
                                  video: widget.video,
                                );
                              },
                            ),
                          );
                        },
                        onUpload: widget.upload,
                      );
                    },
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewVideo(
                          video: widget.video,
                        );
                      },
                    ),
                  );
          },
          child: Container(
            height: 200,
            width: double.infinity, // Permet d'étirer la vidéo
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.lightPrimary, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            height: 200,
            width: (context.width - 70) / 2,
            child: Center(
              child: IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AdresseAudio extends StatefulWidget {
  const AdresseAudio({super.key, required this.audio});

  final String audio;

  @override
  _AdresseAudioState createState() => _AdresseAudioState();
}

class _AdresseAudioState extends State<AdresseAudio> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = true;
  String? _audioUrl;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  void _initializeAudio() async {
    try {
      // Simuler une initialisation asynchrone (par exemple, récupérer l'URL depuis une API)
      await Future.delayed(Duration(seconds: 1)); // Simule un délai de chargement
      setState(() {
        _audioUrl = widget.audio; // Initialiser _audioUrl avec l'audio passé via widget.audio
        _isLoading = false;
      });
    } catch (e) {
      print("Erreur lors de l'initialisation de l'audio : $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _togglePlayPause() async {
    if (_audioUrl == null) {
      print("L'URL de l'audio est null");
      return;
    }

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(_audioUrl!));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isLoading)
          const LoadingCircle()
        else
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: mblack,
            ),
            onPressed: _togglePlayPause,
          ),
        const Text("Lecture audio", style: TextStyle(color: mblack)),
      ],
    );
  }
}
