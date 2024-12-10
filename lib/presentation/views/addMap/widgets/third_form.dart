import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ThirdForm extends StatefulWidget {
  const ThirdForm({super.key});

  @override
  State<ThirdForm> createState() => _ThirdFormState();
}

class _ThirdFormState extends State<ThirdForm> {
  int? protegerPin = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vous aimerez protéger votre adresse ?',
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
              groupValue: protegerPin,
              onChanged: (value) {
                setState(() {
                  protegerPin = value;
                });
              },
              title: Text(
                'Public',
                style: AppTheme().stylish1(15, AppTheme.black),
              ),
            ),
            RadioListTile<int>(
              value: 2,
              groupValue: protegerPin,
              onChanged: (value) {
                setState(() {
                  protegerPin = value;
                });
              },
              title: Text(
                'Privée',
                style: AppTheme().stylish1(15, AppTheme.black),
              ),
            ),
          ],
        ),
        protegerPin == 2
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Créer un code PIN',
                    style:
                        AppTheme().stylish1(15, AppTheme.black, isBold: true),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Ce code sera utilisé par votre correspondant afin de vous retrouver dans Sunofa Map",
                    style: AppTheme().stylish1(13, mgrey),
                  ),
                  const SizedBox(height: 8),
                  AppHelpers.buildTextFormField(
                    hint: 'Code PIN',
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(height: context.heightPercent(5)),
        SubmitButton(
          text: protegerPin == 2 ? "Proteger mon adresse" : "Continuer",
          onTap: () {},
        ),
      ],
    );
  }
}
