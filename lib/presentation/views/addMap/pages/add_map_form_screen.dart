// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_state.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/Image_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/first_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/third_form.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/level_register.dart';

class AddMapFormScreen extends StatefulWidget {
  const AddMapFormScreen({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  State<AddMapFormScreen> createState() => _AddMapFormScreenState();
}

class _AddMapFormScreenState extends State<AddMapFormScreen> {
  final pseudo = TextEditingController();
  final adressName = TextEditingController();
  final city = TextEditingController();
  final info = TextEditingController();
  final pin = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  int? selectedLocationOption;
  bool isLoading = false;
  int? protegerPin = 2;
  int current = 1;
  double? latitude, longitude;
  //
  StepByStep currentStep = StepByStep.STEP_1;
  OpenSection openSection = OpenSection.OPEN_0;
  //

  List<File> selectedImages = [];
  List<File> selectedVideos = [];
  List<File> selectedAudios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(),
        title: Text(
          "Ajouter une adresse",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Container(
        width: context.width,
        height: context.height,
        color: AppTheme.lightGray,
        child: BlocListener<CreateAdresseCubit, CreateAdresseState>(
          listener: (context, state) {
            if (state is CreateAdresseSuccessState) {
              Helpers().mySnackbar(
                context: context,
                message: state.message,
              );
              setState(() {
                isLoading = false;
              });
            } else if (state is CreateAdresseFailedState) {
              Helpers().mySnackbar(
                context: context,
                message: state.message,
              );
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 20,
                  right: 40,
                  left: 40,
                  bottom: 40,
                ),
                child: Row(
                  children: [
                    NumberStepContainer(
                      text: '1',
                      onTap: () {
                        setState(() {
                          currentStep = StepByStep.STEP_1;
                        });
                      },
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 5),
                    TraitLineStep(
                      color: currentStep != StepByStep.STEP_1
                          ? AppTheme.primaryColor
                          : mgrey[300]!,
                    ),
                    const SizedBox(width: 5),
                    NumberStepContainer(
                      text: '2',
                      onTap: () {
                        if (openSection == OpenSection.OPEN_1 ||
                            openSection == OpenSection.OPEN_2) {
                          setState(() {
                            currentStep = StepByStep.STEP_2;
                          });
                        }
                      },
                      color: currentStep != StepByStep.STEP_1
                          ? AppTheme.primaryColor
                          : mgrey[300]!,
                    ),
                    const SizedBox(width: 5),
                    TraitLineStep(
                      color: currentStep != StepByStep.STEP_1 &&
                              currentStep != StepByStep.STEP_2
                          ? AppTheme.primaryColor
                          : mgrey[300]!,
                    ),
                    const SizedBox(width: 5),
                    NumberStepContainer(
                      text: '3',
                      onTap: () {
                        if (openSection == OpenSection.OPEN_2) {
                          setState(() {
                            currentStep = StepByStep.STEP_3;
                          });
                        }
                      },
                      color: (currentStep != StepByStep.STEP_1 &&
                              currentStep != StepByStep.STEP_2)
                          ? AppTheme.primaryColor
                          : mgrey[300]!,
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       StepItem(
              //         icon: Icons.arrow_back_ios_new,
              //         iColor: current == 1 ? mblack : mwhite,
              //         cColor: current == 1
              //             ? AppTheme.lightPrimary
              //             : AppTheme.primaryColor,
              //         onTap: () {
              //           if (currentStep == StepByStep.STEP_3) {
              //             setState(() {
              //               currentStep = StepByStep.STEP_2;
              //             });
              //           } else if (currentStep == StepByStep.STEP_2) {
              //             setState(() {
              //               currentStep = StepByStep.STEP_1;
              //             });
              //           }
              //         },
              //       ),
              //       const SizedBox(width: 20),
              //       StepItem(
              //         icon: Icons.arrow_forward_ios,
              //         iColor: current == 3 ? mblack : mwhite,
              //         cColor: current == 3
              //             ? AppTheme.lightPrimary
              //             : AppTheme.primaryColor,
              //         onTap: () {
              //           if (current == 1) {
              //             setState(() {
              //               current = 2;
              //             });
              //           } else if (current == 2) {
              //             setState(() {
              //               current = 3;
              //             });
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: currentStep == StepByStep.STEP_1
                      ? FirstForm(
                          formKey: formKey1,
                          user: widget.user!,
                          pseudo: pseudo,
                          adressName: adressName,
                          city: city,
                          info: info,
                          selectedLocationOption: selectedLocationOption,
                          onSelectionChanged: (value) async {
                            setState(() {
                              selectedLocationOption = value;
                            });
                            try {
                              Position position = await getPositionActuel();

                              latitude = position.latitude;
                              longitude = position.longitude;
                            } catch (e) {
                              Helpers().mySnackbar(
                                context: context,
                                message: e.toString(),
                                color: Colors.red,
                              );
                            }
                          },
                          onTap: () {
                            if (formKey1.currentState!.validate() &&
                                (selectedLocationOption == 1 ||
                                    selectedLocationOption == 2)) {
                              setState(() {
                                currentStep = StepByStep.STEP_2;
                                openSection = OpenSection.OPEN_1;
                              });
                            }
                          },
                        )
                      : currentStep == StepByStep.STEP_2
                          ? ImageForm(
                              selectedImages: selectedImages,
                              selectedVideos: selectedVideos,
                              selectedAudios: selectedAudios,
                              onContinue: () {
                                // setState(() {
                                //   current = 3;
                                // });
                                setState(() {
                                  currentStep = StepByStep.STEP_3;
                                  openSection = OpenSection.OPEN_2;
                                });
                              },
                            )
                          : ThirdForm(
                              formKey: formKey2,
                              pin: pin,
                              isLoading: isLoading,
                              protegerPin: protegerPin!,
                              onSelectionChanged: (value) {
                                setState(() {
                                  protegerPin = value;
                                });
                              },
                              onTap: () {
                                if (formKey2.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  //   if (protegerPin == 2) {
                                  //     if (selectedLocationOption == 1) {
                                  context
                                      .read<CreateAdresseCubit>()
                                      .createAdresse(
                                        AdresseDTO(
                                          pseudo: pseudo.text.trim(),
                                          adressName: adressName.text.trim(),
                                          city: city.text.trim(),
                                          info: info.text.trim(),
                                          longitude: longitude!,
                                          latitude: latitude!,
                                          codePin: pin.text.trim().isEmpty ? 0 : int.parse(pin.text.trim()),
                                          isFavorited: false,
                                          user_id: widget.user!.id!.toString(),
                                        ),
                                      );
                                  //       setState(() {
                                  //         isLoading = false;
                                  //       });
                                  //     } else if (selectedLocationOption == 2) {
                                  //       context
                                  //           .read<CreateAdresseCubit>()
                                  //           .createAdresse(
                                  //             AdresseDTO(
                                  //               pseudo: pseudo.text.trim(),
                                  //               adressName: adressName.text.trim(),
                                  //               city: city.text.trim(),
                                  //               googleAddress: "",
                                  //               info: info.text.trim(),
                                  //               codePin: int.parse(pin.text.trim()),
                                  //               isFavorited: false,
                                  //               user_id: widget.user!.id!,
                                  //             ),
                                  //           );
                                  //       setState(() {
                                  //         isLoading = false;
                                  //       });
                                  //     } else {
                                  //       setState(() {
                                  //         isLoading = false;
                                  //       });
                                  //     }
                                  //   } else {
                                  //     setState(() {
                                  //       isLoading = false;
                                  //     });
                                  //   }
                                  setState(() {
                                    currentStep = StepByStep.STEP_3;
                                  });
                                }
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> getPositionActuel() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    // Vérifier les permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Les permissions de localisation ont été refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Les permissions de localisation sont définitivement refusées.',
      );
    }

    // Obtenir la position actuelle
    return await Geolocator.getCurrentPosition();
  }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.icon,
    required this.iColor,
    required this.cColor,
    this.onTap,
  });
  final IconData icon;
  final Color iColor, cColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: cColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Icon(
            icon,
            color: iColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}

// ENUM
enum StepByStep {
  STEP_1,
  STEP_2,
  STEP_3,
}

enum OpenSection {
  OPEN_0,
  OPEN_1,
  OPEN_2,
}
