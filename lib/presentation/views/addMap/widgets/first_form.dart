import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'package:geolocator/geolocator.dart';

class FirstForm extends StatefulWidget {
  const FirstForm({
    super.key,
    required this.user,
    this.onTap,
    required this.pseudo,
    required this.info,
    required this.city,
    required this.adressName,
    this.selectedLocationOption,
    // required this.onSelectionChanged,
    required this.formKey,
    required this.gaController,
    required this.isGoogleAddressSelected,
    required this.isCurrentLocationSelected,
    required this.onGoogleAddressChanged,
    required this.onCurrentLocationChanged,
  });
  final UserEntity user;
  final VoidCallback? onTap;
  final int? selectedLocationOption;
  final GlobalKey<FormState> formKey;
  // final ValueChanged<int?> onSelectionChanged;
  final bool isGoogleAddressSelected;
  final bool isCurrentLocationSelected;
  final ValueChanged<bool> onGoogleAddressChanged;
  final ValueChanged<bool> onCurrentLocationChanged;
  final TextEditingController pseudo, gaController, info, city, adressName;

  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  // final pseudo = TextEditingController();
  // final adressName = TextEditingController();
  // final info = TextEditingController();
  // final city = TextEditingController();
  // int? _selectedPrivacyOption;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAdresseCubit, CreateAdresseState>(
      listener: (context, state) {
        if (state is CreateAdresseSuccessState) {
          Helpers().mySnackbar(
            context: context,
            message: state.message,
          );
        } else if (state is CreateAdresseFailedState) {
          Helpers().mySnackbar(
            context: context,
            color: mred,
            message: state.message,
          );
        }
      },
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabelWithAsterisk("add_address.first.pseudo_label".tr()),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.pseudo,
              hint: 'ex: KGB2',
              validator: (value) {
                if (value!.length < 3) {
                  return "add_address.first.pseudo_error".tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            buildLabelWithAsterisk("add_address.first.name_label".tr()),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.adressName,
              hint: 'Maison IDAH',
              validator: (value) {
                if (value!.length < 3) {
                  return "add_address.first.pseudo_error".tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            buildLabelWithAsterisk("add_address.first.city_label".tr()),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.city,
              hint: 'USA, Los Angelos...',
              validator: (value) {
                if (value!.isEmpty) {
                  return "add_address.first.city_error".tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            Text(
              "add_address.first.position_label".tr(),
              style: AppTheme().stylish1(
                15,
                AppTheme.black,
                isBold: true,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  value: widget.isGoogleAddressSelected,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (value) => widget.onGoogleAddressChanged(value!),
                  title: Text(
                    "add_address.first.google_address".tr(),
                    style: AppTheme().stylish1(
                      15,
                      mblack,
                    ),
                  ),
                ),
                // Affichage du champ de texte si "Mon adresse Google" est sélectionné
                if (widget.isGoogleAddressSelected)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppHelpers.buildTextFormField(
                      controller: widget.gaController,
                      hint: "add_address.first.ga_hint".tr(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "add_address.first.city_error".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                CheckboxListTile(
                  value: widget.isCurrentLocationSelected,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (value) => widget.onCurrentLocationChanged(value!),
                  title: Text(
                    "add_address.first.current_position".tr(),
                    style: AppTheme().stylish1(
                      15,
                      mblack,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            buildLabelWithAsterisk("add_address.first.info_label".tr()),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.info,
              hint: "add_address.first.info_hint".tr(),
              maxLines: 3,
              validator: (value) {
                if (value!.isEmpty) {
                  return "add_address.first.city_error".tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(5),
            ),
            SubmitButton(
              text: "add_address.first.continue".tr(),
              onTap: widget.onTap,
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelWithAsterisk(String label) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: AppTheme().stylish1(15, AppTheme.black, isBold: true),
          ),
          const TextSpan(
            text: '*',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ],
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
