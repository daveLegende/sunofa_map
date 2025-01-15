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
    required this.onSelectionChanged,
    required this.formKey,
  });
  final UserEntity user;
  final VoidCallback? onTap;
  final int? selectedLocationOption;
  final GlobalKey<FormState> formKey;
  final ValueChanged<int?> onSelectionChanged;
  final TextEditingController pseudo, info, city, adressName;

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
            message: "Adresse ajoutée avec succès",
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
            buildLabelWithAsterisk('Créer un identifiant'),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.pseudo,
              hint: 'ex: KGB2',
              validator: (value) {
                if (value!.length < 3) {
                  return "Minimum 3 lettres";
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            buildLabelWithAsterisk("Nom de l'adresse"),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.adressName,
              hint: 'Maison IDAH',
              validator: (value) {
                if (value!.length < 3) {
                  return "Minimum 3 lettres";
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            buildLabelWithAsterisk('Pays, ville, quartier ou rue'),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.city,
              hint: 'Pays, ville...',
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ce champ ne peut être vide";
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            Text(
              'Position',
              style: AppTheme().stylish1(
                15,
                AppTheme.black,
                isBold: true,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                RadioListTile<int>(
                  value: 1,
                  groupValue: widget.selectedLocationOption,
                  onChanged: widget.onSelectionChanged,
                  title: Text(
                    'Mon adresse google',
                    style: AppTheme().stylish1(15, AppTheme.black),
                  ),
                ),
                RadioListTile<int>(
                  value: 2,
                  groupValue: widget.selectedLocationOption,
                  onChanged: (value) {
                    widget.onSelectionChanged(value);
                  },
                  title: Text(
                    'Ma position actuelle',
                    style: AppTheme().stylish1(15, AppTheme.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.heightPercent(2),
            ),
            buildLabelWithAsterisk("Information concernant l'adresse"),
            const SizedBox(height: 8),
            AppHelpers.buildTextFormField(
              controller: widget.info,
              hint: 'Longez tout droit vers ...',
              maxLines: 3,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ce champ ne peut être vide";
                }
                return null;
              },
            ),
            SizedBox(
              height: context.heightPercent(5),
            ),
            SubmitButton(
              text: "Continuer",
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
