import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/image_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/import_or_doing_widget.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/dashboard/bloc/all_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_state.dart';
import 'package:sunofa_map/presentation/views/viewImage/view_image.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:sunofa_map/common/api/api.dart';

import '../widgets/edit_adresse_sheet.dart';

class EditAdresseScreen extends StatefulWidget {
  EditAdresseScreen({
    super.key,
    this.adresse,
    this.onTabSelected,
    required this.isAdresseHome,
  });
  AdressesEntity? adresse;
  final bool isAdresseHome;
  final void Function(int)? onTabSelected;

  @override
  State<EditAdresseScreen> createState() => _EditAdresseScreenState();
}

class _EditAdresseScreenState extends State<EditAdresseScreen> {
  late TextEditingController pseudo;
  late TextEditingController adressName;
  late TextEditingController ville;
  late TextEditingController googleAdresse;
  late TextEditingController codePin;
  late TextEditingController info;
  String? photo1, photo2, video1, video2;
  bool isLoading = false;
  bool obscureText = false;

  // List<File> selectedImages = [];
  // List<File> selectedVideos = [];
  // List<File> selectedAudios = [];

  // Future<void> selectFile(String type) async {
  //   try {
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

  //     if (result != null && result.files.single.path != null) {
  //       setState(() {
  //         File file = File(result.files.single.path!);
  //         print("Path: ${file.path}");
  //         if (type == 'image') {
  //           selectedImages.add(file);
  //         } else if (type == 'audio') {
  //           selectedAudios.add(file);
  //         } else if (type == 'video') {
  //           selectedVideos.add(file);
  //         }
  //       });
  //     } else {
  //       print('Aucun fichier sélectionné.');
  //     }
  //   } catch (e, stacktrace) {
  //     print("Erreur lors de la sélection du fichier: $e");
  //     print(stacktrace);
  //   }
  // }

  // Future<void> _takePhotoOrVideo(String type) async {
  //   final ImagePicker picker = ImagePicker();
  //   XFile? pickedFile;
  //   if (type == 'image') {
  //     pickedFile = await picker.pickImage(source: ImageSource.camera);
  //   } else if (type == 'video') {
  //     pickedFile = await picker.pickVideo(source: ImageSource.camera);
  //   }

  //   if (pickedFile != null) {
  //     setState(() {
  //       File file = File(pickedFile!.path);
  //       if (type == 'image') {
  //         selectedImages.add(file);
  //       } else if (type == 'video') {
  //         selectedVideos.add(file);
  //       }
  //     });
  //   } else {
  //     print('Aucun fichier sélectionné.');
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // Initialisation des contrôleurs avec les données existantes
    pseudo = TextEditingController(text: widget.adresse!.pseudo);
    adressName = TextEditingController(text: widget.adresse!.adressName);
    ville = TextEditingController(text: widget.adresse!.city);
    googleAdresse =
        TextEditingController(text: widget.adresse!.googleAddress ?? "");
    codePin =
        TextEditingController(text: widget.adresse!.codePin.toString() ?? "");
    info = TextEditingController(text: widget.adresse!.info);
  }

  @override
  void dispose() {
    // Nettoyer les contrôleurs pour éviter les fuites de mémoire
    pseudo.dispose();
    adressName.dispose();
    ville.dispose();
    googleAdresse.dispose();
    codePin.dispose();
    info.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final adresse = widget.adresse!;
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mwhite,
          appBar: AppBar(
            backgroundColor: mwhite,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: const BackArrow(
              routeNamed: Routes.home2,
            ),
            title: Text(
              "edit_ad.appbar".tr(),
              style:
                  AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              children: [
                BlocListener<EditAdresseCubit, EditAdresseState>(
                  listener: (context, state) {
                    if (state is EditAdresseSuccessState) {
                      Helpers().mySnackbar(
                        context: context,
                        message: state.message,
                      );
                      context.read<AdresseCubit>().getAdresses();
                      context.read<AllAdresseCubit>().getAllAdresses();
                      widget.onTabSelected!(1);
                      Navigator.pop(context);
                      widget.isAdresseHome ? null : Navigator.pop(context);
                    } else if (state is EditAdresseFailedState) {
                      Helpers().mySnackbar(
                        context: context,
                        color: mred,
                        message: state.message,
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileCustom(
                        title: "Pseudo/Identifiant",
                        subtitle: "Sadath01",
                        controller: pseudo,
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "edit_ad.name_label".tr(),
                        subtitle: "Maison IDAH",
                        controller: adressName,
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "edit_ad.city_label".tr(),
                        subtitle: "USA, Los Angelos...",
                        controller: ville,
                      ),
                      const SizedBox(height: 20),
                      adresse.googleAddress == null ||
                              adresse.googleAddress!.isEmpty
                          ? ListTileCustom(
                              title: "edit_ad.ga_label".tr(),
                              subtitle: "edit_ad.click".tr(),
                              controller: googleAdresse,
                            )
                          : ListTileCustom(
                              title: "edit_ad.ga".tr(),
                              subtitle: "",
                              controller: googleAdresse,
                            ),
                      const SizedBox(height: 20),
                      adresse.codePin == null ||
                              adresse.codePin!.toString().isEmpty ||
                              adresse.codePin!.toString() == "null"
                          // ?
                          ? const SizedBox()
                          : ListTileCustom(
                              title: "edit_ad.pin_label".tr(),
                              subtitle: "",
                              controller: codePin,
                              keyboardType: TextInputType.number,
                              obscureText: obscureText,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                child: HeroIcon(
                                  obscureText
                                      ? HeroIcons.eye
                                      : HeroIcons.eyeSlash,
                                  color: mgrey,
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "edit_ad.info_label".tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: TextField(
                              controller: info,
                              maxLines: 3,
                              style: AppTheme().stylish1(15, mblack),
                              cursorColor: mblack,
                              decoration: InputDecoration(
                                hintText: "Info...",
                                hintStyle: AppTheme().stylish1(
                                  15,
                                  AppTheme.black,
                                  isBold: false,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: AppTheme.primaryColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 12.0,
                                ),
                              ),
                            ),
                            // child: TextField(
                            //   controller: info,
                            //   maxLines: 4,
                            //   textAlign: TextAlign.justify,
                            //   style: AppTheme().stylish1(
                            //     13,
                            //     mgrey[400]!,
                            //   ),
                            //   decoration: const InputDecoration(
                            //     focusedBorder: OutlineInputBorder(
                            //       borderSide: BorderSide.none,
                            //     ),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide.none,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      adresse.media!.photo1 == null ||
                              adresse.media!.photo2 == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${"add_address.second.image_label".tr()} ?",
                                  style: AppTheme().stylish1(
                                    15,
                                    AppTheme.black,
                                    isBold: true,
                                  ),
                                ),
                                SizedBox(height: context.heightPercent(2)),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    photo1 == null || photo1!.isEmpty
                                        ? AddFileButton(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return ImportOrDoingWidget(
                                                    importText:
                                                        "add_address.second.import_image"
                                                            .tr(),
                                                    doingText:
                                                        "add_address.second.do_image"
                                                            .tr(),
                                                    onImport: () =>
                                                        _replaceMedia("photo1"),
                                                    // onRecord: () =>
                                                    //     _takePhotoOrVideo(
                                                    //         "image"),
                                                  );
                                                },
                                              );
                                            },
                                            label: 'Image',
                                          )
                                        : ImagePreview(
                                            file: File(photo1!),
                                            onDelete: () {
                                              onDeleteMedia("photo1");
                                            },
                                          ),
                                    photo2 == null || photo2!.isEmpty
                                        ? AddFileButton(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return ImportOrDoingWidget(
                                                    importText:
                                                        "add_address.second.import_image"
                                                            .tr(),
                                                    doingText:
                                                        "add_address.second.do_image"
                                                            .tr(),
                                                    onImport: () =>
                                                        _replaceMedia("photo2"),
                                                    // onRecord: () =>
                                                    //     _takePhotoOrVideo(
                                                    //         "image"),
                                                  );
                                                },
                                              );
                                            },
                                            label: 'Image',
                                          )
                                        : ImagePreview(
                                            file: File(photo2!),
                                            onDelete: () {
                                              onDeleteMedia("photo2");
                                            },
                                          ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "edit_ad.images".tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: photo1 == null
                                          ? AdresseImage(
                                              key: ValueKey(
                                                adresse.media!.photo1,
                                              ),
                                              image:
                                                  "${APIURL.fileUrl}/${adresse.media!.photo1!}",
                                              size: size,
                                              isEdit: true,
                                              upload: () {
                                                Navigator.pop(context);
                                                _replaceMedia("photo1");
                                              },
                                            )
                                          : ImagePreview(
                                              file: File(
                                                photo1!,
                                              ),
                                              onDelete: () {
                                                onDeleteMedia("photo1");
                                              },
                                            ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: photo2 == null
                                          ? AdresseImage(
                                              key: ValueKey(
                                                adresse.media!.photo2,
                                              ),
                                              image:
                                                  "${APIURL.fileUrl}/${adresse.media!.photo2!}",
                                              isEdit: true,
                                              size: size,
                                              upload: () {
                                                Navigator.pop(context);
                                                _replaceMedia("photo2");
                                              },
                                            )
                                          : ImagePreview(
                                              file: File(
                                                photo2!,
                                              ),
                                              onDelete: () {
                                                onDeleteMedia("photo2");
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      const SizedBox(height: 20),
                      adresse.media!.audio1 == null &&
                              adresse.media!.audio2 == null
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "edit_ad.audios".tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                AdresseAudio(
                                  audio:
                                      "${APIURL.fileUrl}/${adresse.media!.audio1!}",
                                )
                              ],
                            ),
                      const SizedBox(height: 20),
                      adresse.media!.video1 == null ||
                              adresse.media!.video2 == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "add_address.second.video_label_tag".tr(),
                                  style: AppTheme().stylish1(
                                    15,
                                    AppTheme.black,
                                    isBold: true,
                                  ),
                                ),
                                SizedBox(height: context.heightPercent(2)),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    video1 == null || video1!.isEmpty
                                        ? AddFileButton(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return ImportOrDoingWidget(
                                                    importText:
                                                        "add_address.second.import_video"
                                                            .tr(),
                                                    doingText:
                                                        "add_address.second.do_video"
                                                            .tr(),
                                                    onImport: () =>
                                                        _replaceMedia("video1"),
                                                    // onRecord: () =>
                                                    //     _takePhotoOrVideo(
                                                    //         "video"),
                                                  );
                                                },
                                              );
                                            },
                                            label: 'Video',
                                          )
                                        : VideoPreview(
                                            file: File(video1!),
                                            onDelete: () {
                                              onDeleteMedia("video1");
                                            },
                                          ),
                                    video2 == null || video2!.isEmpty
                                        ? AddFileButton(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return ImportOrDoingWidget(
                                                    importText:
                                                        "add_address.second.import_video"
                                                            .tr(),
                                                    doingText:
                                                        "add_address.second.do_video"
                                                            .tr(),
                                                    onImport: () =>
                                                        _replaceMedia("video2"),
                                                    // onRecord: () =>
                                                    //     _takePhotoOrVideo(
                                                    //         "video"),
                                                  );
                                                },
                                              );
                                            },
                                            label: 'Video',
                                          )
                                        : VideoPreview(
                                            file: File(video2!),
                                            onDelete: () {
                                              onDeleteMedia("video2");
                                            },
                                          ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "edit_ad.videos".tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: video1 == null
                                          ? AdresseVideo(
                                              key: ValueKey(
                                                  adresse.media!.video1),
                                              video: adresse.media!.video1!,
                                              upload: () {
                                                Navigator.pop(context);
                                                _replaceMedia("video1");
                                              },
                                              size: size,
                                              isEdit: true,
                                            )
                                          : VideoPreview(
                                              file: File(
                                                video1!,
                                              ),
                                              onDelete: () {
                                                onDeleteMedia("video1");
                                              },
                                            ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: video2 == null
                                          ? AdresseVideo(
                                              key: ValueKey(
                                                  adresse.media!.video2),
                                              video: adresse.media!.video2!,
                                              upload: () {
                                                Navigator.pop(context);
                                                _replaceMedia("video2");
                                              },
                                              size: size,
                                              isEdit: true,
                                            )
                                          : VideoPreview(
                                              file: File(
                                                video2!,
                                              ),
                                              onDelete: () {
                                                onDeleteMedia("video2");
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                isKeyboardVisible
                    ? const SizedBox(height: 0)
                    : const SizedBox(height: 90),
              ],
            ),
          ),
          bottomSheet: isKeyboardVisible
              ? const SizedBox()
              : EditAdresseSheet(
                  button: isLoading
                      ? const LoadingCircle()
                      : SubmitButton(
                          text: "edit_ad.save".tr(),
                          onTap: () {
                            print(
                                "---------------------------${widget.adresse!.id}");
                            print("---------------------------${codePin.text}");
                            setState(() {
                              isLoading = true;
                              widget.adresse = widget.adresse!.copyWith(
                                media: widget.adresse!.media!.copyWith(
                                  photo1:
                                      photo1 ?? widget.adresse!.media!.photo1,
                                  photo2:
                                      photo2 ?? widget.adresse!.media!.photo2,
                                  video1:
                                      video1 ?? widget.adresse!.media!.video1,
                                  video2:
                                      video2 ?? widget.adresse!.media!.video2,
                                ),
                              );
                            });
                            // codePin.text.trim().isNotEmpty
                            //     ? context
                            //         .read<EditAdresseCubit>()
                            //         .editAdresse(
                            //           AdresseDTO(
                            //             id: adresse.id,
                            //             pseudo: pseudo.text.trim(),
                            //             adressName: adressName.text.trim(),
                            //             city: ville.text.trim(),
                            //             info: info.text.trim(),
                            //             user_id: adresse.user.id!,
                            //             latitude: adresse.latitude ?? null,
                            //             longitude: adresse.longitude ?? null,
                            //             codePin: codePin.text.trim().isEmpty
                            //                 ? null
                            //                 : codePin.text.trim(),
                            //             googleAddress:
                            //                 googleAdresse.text.trim(),
                            //             media: widget.adresse!.media!,
                            //           ),
                            //         )
                            //         .then((value) {
                            //         setState(() {
                            //           isLoading = false;
                            //         });
                            //       })
                            //     :
                            context
                                .read<EditAdresseCubit>()
                                .editAdresse(
                                  AdresseDTO(
                                    id: adresse.id,
                                    pseudo: pseudo.text.trim(),
                                    adressName: adressName.text.trim(),
                                    city: ville.text.trim(),
                                    info: info.text.trim(),
                                    user_id: adresse.user.id!,
                                    latitude: adresse.latitude ?? null,
                                    longitude: adresse.longitude ?? null,
                                    googleAddress: googleAdresse.text.trim(),
                                    media: widget.adresse!.media!,
                                  ),
                                )
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                        ),
                ),
        );
      },
    );
  }

  onDeleteMedia(String mediaType) {
    setState(() {
      if (mediaType == "photo1") {
        photo1 = null;
      } else if (mediaType == "photo2") {
        photo2 = null;
      } else if (mediaType == "video1") {
        video1 = null;
      } else if (mediaType == "video2") {
        video2 = null;
      }
    });
  }

  // Future<void> _replaceMedia(String mediaType) async {
  //   try {
  //     // Demander à l'utilisateur de choisir une nouvelle image ou vidéo
  //     final ImagePicker picker = ImagePicker();
  //     XFile? pickedFile;

  //     if (mediaType.startsWith('photo')) {
  //       pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //     } else if (mediaType.startsWith('video')) {
  //       pickedFile = await picker.pickVideo(source: ImageSource.gallery);
  //     }

  //     if (pickedFile != null) {
  //       setState(() {
  //         File file = File(pickedFile!.path);

  //         // Mettre à jour l'état en fonction du type de média
  //         if (mediaType == 'photo1') {
  //           photo1 = file.path; // Mettre à jour photo1
  //         } else if (mediaType == 'photo2') {
  //           photo2 = file.path; // Mettre à jour photo2
  //         } else if (mediaType == 'video1') {
  //           video1 = file.path; // Mettre à jour video1
  //         } else if (mediaType == 'video2') {
  //           video2 = file.path; // Mettre à jour video2
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     print("Erreur lors du remplacement du média: $e");
  //   }
  // }

  Future<void> _replaceMedia(String mediaType) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile;

      if (mediaType.startsWith('photo')) {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      } else if (mediaType.startsWith('video')) {
        pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      }

      if (pickedFile != null) {
        setState(() {
          String newPath = pickedFile!.path;

          // Mettre à jour `ad.media`
          // widget.adresse = widget.adresse!.copyWith(
          //   media: widget.adresse!.media!.copyWith(
          //     photo1: mediaType == 'photo1'
          //         ? newPath
          //         : widget.adresse!.media!.photo1,
          //     photo2: mediaType == 'photo2'
          //         ? newPath
          //         : widget.adresse!.media!.photo2,
          //     video1: mediaType == 'video1'
          //         ? newPath
          //         : widget.adresse!.media!.video1,
          //     video2: mediaType == 'video2'
          //         ? newPath
          //         : widget.adresse!.media!.video2,
          //   ),
          // );
          if (mediaType == "photo1") {
            photo1 = newPath;
          } else if (mediaType == "photo2") {
            photo2 = newPath;
          } else if (mediaType == "video1") {
            video1 = newPath;
          } else if (mediaType == "video2") {
            video2 = newPath;
          }
        });

        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {});
        });
      }
    } catch (e) {
      print("Erreur lors du remplacement du média: $e");
    }
  }
}

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    super.key,
    required this.title,
    required this.subtitle,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon = const SizedBox(),
    this.keyboardType,
  });
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme().stylish1(
            15,
            mblack,
            isBold: true,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          style: AppTheme().stylish1(15, mblack),
          cursorColor: mblack,
          decoration: InputDecoration(
            hintText: subtitle,
            hintStyle: AppTheme().stylish1(
              15,
              mgrey,
              isBold: false,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppTheme.primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 12.0,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
