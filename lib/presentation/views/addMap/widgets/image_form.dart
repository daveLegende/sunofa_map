// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:heroicons/heroicons.dart';
// import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
// import 'package:sunofa_map/core/utils/index.dart';
// import 'package:sunofa_map/themes/app_themes.dart';

// import 'audio_player_widget.dart';

// class ImageForm extends StatefulWidget {
//   const ImageForm({super.key});

//   @override
//   State<ImageForm> createState() => _ImageFormState();
// }

// class _ImageFormState extends State<ImageForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Ajouter des images',
//               style: AppTheme().stylish1(
//                 15,
//                 AppTheme.black,
//                 isBold: true,
//               ),
//             ),
//             SizedBox(
//               height: context.heightPercent(2),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 2, left: 2),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ImageContainer(
//                       onTap: () {
//                         selectFile("image");
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ImageContainer(
//                       onTap: () {
//                         selectFile("image");
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ImageContainer(
//                       onTap: () {
//                         selectFile("image");
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: context.heightPercent(2),
//             ),
//             //
//             Text(
//               'Reference audio',
//               style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
//             ),
//             SizedBox(
//               height: context.heightPercent(2),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: AppTheme.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     const AudioPlayerWidget(
//                       label: 'official language',
//                     ),
//                     SizedBox(
//                       height: context.heightPercent(2),
//                     ),
//                     const AudioPlayerWidget(
//                       label: 'standard language',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: context.heightPercent(2),
//             ),
//             Text(
//               'Reference video',
//               style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
//             ),
//             SizedBox(
//               height: context.heightPercent(2),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 2, left: 2),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () => selectFile('video'),
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: AppTheme.primaryColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.red.withOpacity(0.3),
//                               child: Text(
//                                 'Rec •',
//                                 style: AppTheme()
//                                     .stylish1(15, Colors.red, isBold: true),
//                               ),
//                             ),
//                             SizedBox(
//                               height: context.heightPercent(1),
//                             ),
//                             Text(
//                               'Select a video',
//                               style: AppTheme()
//                                   .stylish1(15, AppTheme.black, isBold: true),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: context.widthPercent(5),
//                   ),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () => selectFile('video'),
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: AppTheme.primaryColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.red.withOpacity(0.3),
//                               child: Text(
//                                 'Rec •',
//                                 style: AppTheme()
//                                     .stylish1(15, Colors.red, isBold: true),
//                               ),
//                             ),
//                             SizedBox(
//                               height: context.heightPercent(1),
//                             ),
//                             Text(
//                               'Select a video',
//                               style: AppTheme()
//                                   .stylish1(15, AppTheme.black, isBold: true),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: context.heightPercent(5),
//             ),
//             SubmitButton(
//               text: "Continuer",
//               onTap: () {},
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Future<void> selectFile(String type) async {
//     FileType fileType;
//     switch (type) {
//       case 'image':
//         fileType = FileType.image;
//         break;
//       case 'audio':
//         fileType = FileType.audio;
//         break;
//       case 'video':
//         fileType = FileType.video;
//         break;
//       default:
//         fileType = FileType.any;
//     }

//     FilePickerResult? result =
//         await FilePicker.platform.pickFiles(type: fileType);
//     if (result != null) {
//       // Gérer le fichier sélectionné
//       print('Fichier sélectionné : ${result.files.single.name}');
//     } else {
//       // L'utilisateur a annulé la sélection
//       print('Aucun fichier sélectionné.');
//     }
//   }
// }

// class ImageContainer extends StatelessWidget {
//   const ImageContainer({
//     super.key,
//     this.onTap,
//   });
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: AppTheme.lightPrimary,
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: const Center(
//           child: HeroIcon(
//             HeroIcons.plus,
//             size: 40,
//             style: HeroIconStyle.micro,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ImageForm extends StatefulWidget {
  const ImageForm({
    super.key,
    this.onContinue,
  });
  final VoidCallback? onContinue;

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  // Listes pour stocker les fichiers sélectionnés
  List<File> selectedImages = [];
  List<File> selectedVideos = [];
  List<File> selectedAudios = [];

  @override
  Widget build(BuildContext context) {
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
                ...selectedImages.map(
                  (image) => ImagePreview(
                    file: image,
                    onDelete: () {
                      setState(() {
                        selectedImages.remove(image);
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

            // Section pour les audios
            Text(
              'Référence audio',
              style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
            ),
            SizedBox(height: context.heightPercent(2)),
            Column(
              children: [
                ...selectedAudios.map((audio) {
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
                              selectedAudios.remove(audio);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
                AddFileButton(
                  onTap: () => selectFile("audio"),
                  label: 'Audio',
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
                ...selectedVideos.map(
                  (video) => VideoPreview(
                    file: video,
                    onDelete: () {
                      setState(() {
                        selectedVideos.remove(video);
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
          selectedImages.add(file);
        } else if (type == 'audio') {
          selectedAudios.add(file);
        } else if (type == 'video') {
          selectedVideos.add(file);
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
