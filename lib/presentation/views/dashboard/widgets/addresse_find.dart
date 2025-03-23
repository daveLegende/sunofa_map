import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sunofa_map/blocs/notifications/requestPin/request_pin_cubit.dart';
import 'package:sunofa_map/blocs/notifications/requestPin/request_pin_state.dart';
import 'package:sunofa_map/blocs/notifications/validatePin/validate_pin_cubit.dart';
import 'package:sunofa_map/blocs/notifications/validatePin/validate_pin_state.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/button_border_container.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/sources/notifications/notification.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/gestionAdresse/pages/gestion_adresse.dart';
import 'package:sunofa_map/presentation/views/infos/pages/infos.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:http/http.dart' as http;

class AddresseSearch extends StatefulWidget {
  const AddresseSearch({
    super.key,
    required this.adresses,
    this.user,
  });

  final UserEntity? user;

  final List<AdressesEntity> adresses;

  @override
  State<AddresseSearch> createState() => _AddresseSearchState();
}

class _AddresseSearchState extends State<AddresseSearch> {
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String url = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestPinCubit, RequestPinState>(
      listener: (context, state) {
        if (state is RequestPinSuccessState) {
          Helpers().toast(message: state.notification.message);
          customDialog(
            context,
            ThirdDialogContent(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          );
        } else if (state is RequestPinFailedState) {
          Helpers().toast(message: state.message);
        }
      },
      child: Container(
        color: mtransparent,
        height: context.height * .8,
        child: ListView.builder(
          itemCount: widget.adresses.length,
          itemBuilder: (context, index) {
            final ad = widget.adresses[index];
            return BlocListener<ValidatePinCubit, ValidatePinState>(
              listener: (context, state) {
                if (state is ValidatePinSuccessState) {
                  setState(() {
                    pinController.clear();
                    pinController.text = "";
                    isLoading = false;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return InfoAdresseScreen(
                          adresse: ad,
                        );
                      },
                    ),
                  );
                } else if (state is ValidatePinFailedState) {
                  Helpers().toast(
                    message: state.message,
                    color: mred,
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: index == widget.adresses.length - 1 ? 120 : 20,
                ),
                child: GestureDetector(
                  behavior:
                      HitTestBehavior.opaque, // Ajouté pour capter les taps
                  onTap: (ad.codePin == null ||
                              ad.codePin.toString().length < 4) ||
                          widget.user!.id == ad.user.id
                      ? () {
                          // FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GestionAdresseScreen(
                                  user: widget.user,
                                  adresse: ad,
                                );
                              },
                            ),
                          );
                        }
                      : () {
                          // FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                          customDialog(
                            context,
                            FirstDialogContent(
                              onPin: () {
                                Navigator.pop(context);
                                customDialog(
                                  context,
                                  SecondDialogContent(
                                    formKey: formKey,
                                    controller: pinController,
                                    button: isLoading
                                        ? const LoadingCircle()
                                        : ButtonBorderContainer(
                                            width: context.width / 3,
                                            color: AppTheme.primaryColor,
                                            text: "dashboard.valid".tr(),
                                            onTap: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<ValidatePinCubit>()
                                                    .validatePin(
                                                      FullPin(
                                                        id: ad.id!,
                                                        fullPin: int.parse(
                                                          pinController.text
                                                              .trim(),
                                                        ),
                                                      ),
                                                    );
                                              }
                                            },
                                          ),
                                  ),
                                );
                              },
                              onTell: () async {
                                Navigator.pop(context);
                                // await NotifImpl().notifyUser(
                                //   userId: ad.user.id!,
                                //   title: "Demande de Code PIN",
                                //   subtitle:
                                //       "Notification to user ${widget.user!.id}",
                                //   body:
                                //       "L'utilisateur ${widget.user!.name} aimerait accéder à votre adresse ${ad.adressName}",
                                //   // data: ["${ad.codePin}"],
                                // ).then((_) async {
                                //   // Afficher des informations de débogage
                                //   var deviceState =
                                //       await OneSignal.User.pushSubscription.id;
                                //   print(
                                //       "OneSignal Push Subscription ID: $deviceState");

                                //   OneSignal.User.pushSubscription
                                //       .addObserver((state) {
                                //     print(
                                //         "OneSignal Subscription Status: ${state.current.jsonRepresentation()}");
                                //   });

                                //   var status =
                                //       await OneSignal.Notifications.permission;
                                //   print("Permission notifications: $status");
                                //   customDialog(
                                //     context,
                                //     ThirdDialogContent(
                                //       onTap: () {
                                //         Navigator.pop(context);
                                //       },
                                //     ),
                                //   );
                                // });

                                // await OneSignal.login(ad.user.id!);
                                context.read<RequestPinCubit>().requestPin(
                                      IdParms(id: ad.id!),
                                    );
                              },
                            ),
                          );
                        },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: url.isEmpty
                                  ? Container(
                                      width: 60,
                                      height: 60,
                                      color: mgrey[200],
                                    )
                                  : Image(
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        ad.media!.photo1 != null
                                            ? "$url/${ad.media!.photo1!}"
                                            : APIURL.network,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    ad.codePin.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme().stylish1(
                                      18,
                                      mblack,
                                      isBold: true,
                                    ),
                                  ),
                                  Text(
                                    ad.city,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme().stylish1(12, mgrey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: mwhite,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> customDialog(BuildContext context, Widget child) {
    return showDialog(
      context: context,
      builder: (_) {
        return Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: context.width * .8,
                height: context.width * .6,
                padding: const EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  color: mwhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  // Future<String> _fetchImageUrl() async {
  //   try {
  //     final token = await PreferenceServices().getToken();
  //     final response = await http.get(
  //       Uri.parse(APIURL.fileUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': "Bearer $token",
  //       },
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // print("${response.body}");
  //       // Si la réponse est correcte, retourne l'URL de l'image
  //       setState(() {
  //         url = APIURL.fileUrl;
  //       });
  //       return APIURL.fileUrl;
  //     } else if (response.statusCode == 404) {
  //       // Si l'image n'est pas trouvée
  //       // print("${response.body}");
  //       throw Exception("Image non trouvée (404)");
  //     } else if (response.statusCode == 403) {
  //       // Si l'accès est interdit
  //       throw Exception("Accès interdit (403)");
  //     } else {
  //       // Autres erreurs
  //       throw Exception("Erreur ${response.statusCode}: ${response.body}");
  //     }
  //   } catch (e) {
  //     // En cas d'erreur
  //     throw Exception(
  //       "Une erreur s'est produite lors de la récupération de l'image: $e",
  //     );
  //   }
  // }
}

class FirstDialogContent extends StatelessWidget {
  const FirstDialogContent({
    super.key,
    this.onPin,
    this.onTell,
  });
  final VoidCallback? onPin, onTell;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "dashboard.first_title".tr(),
          textAlign: TextAlign.center,
          style: AppTheme().stylish1(15, mblack),
        ),
        ButtonBorderContainer(
          width: context.width / 2,
          color: AppTheme.primaryColor,
          text: "dashboard.first_write".tr(),
          onTap: onPin,
        ),
        ButtonBorderContainer(
          width: context.width / 2,
          color: AppTheme.complementaryColor,
          text: "dashboard.first_ask".tr(),
          onTap: onTell,
        ),
      ],
    );
  }
}

class SecondDialogContent extends StatelessWidget {
  const SecondDialogContent({
    super.key,
    this.onTap,
    required this.controller,
    required this.formKey,
    required this.button,
  });
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Widget button;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "dashboard.second_title".tr(),
                  textAlign: TextAlign.center,
                  style: AppTheme().stylish1(15, mblack),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: TextFormField(
                      controller: controller,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      cursorColor: AppTheme.primaryColor,
                      decoration: InputDecoration(
                        hintText: "dashboard.pin_hint".tr(),
                        hintStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(
                          Icons.pin,
                          color: AppTheme.primaryColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 4) {
                          return "dashboard.pin_length".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                button,
              ],
            ),
          );
        },
      ),
    );
  }
}

class ThirdDialogContent extends StatelessWidget {
  const ThirdDialogContent({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "dashboard.third_title".tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.check_circle_outline,
          size: 40,
          color: mColor8,
        ),
        Text(
          "dashboard.third_desc".tr(),
          textAlign: TextAlign.center,
          style: AppTheme().stylish1(13, mgrey),
        ),
        ButtonBorderContainer(
          width: context.width / 3.5,
          color: AppTheme.primaryColor,
          text: "dashboard.ok".tr(),
          onTap: onTap,
        ),
      ],
    );
  }
}
