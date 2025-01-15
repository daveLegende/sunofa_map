import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ThirdForm extends StatefulWidget {
  const ThirdForm({
    super.key,
    this.onTap,
    required this.pin,
    required this.protegerPin,
    required this.onSelectionChanged,
    required this.isLoading,
    required this.formKey,
  });
  final int protegerPin;
  final bool isLoading;
  final VoidCallback? onTap;
  final TextEditingController pin;
  final GlobalKey<FormState> formKey;
  final ValueChanged<int?> onSelectionChanged;

  @override
  State<ThirdForm> createState() => _ThirdFormState();
}

class _ThirdFormState extends State<ThirdForm> {
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
        Form(
          key: widget.formKey,
          child: Column(
            children: [
              RadioListTile<int>(
                value: 1,
                groupValue: widget.protegerPin,
                onChanged: widget.onSelectionChanged,
                title: Text(
                  'Public',
                  style: AppTheme().stylish1(15, AppTheme.black),
                ),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: widget.protegerPin,
                onChanged: widget.onSelectionChanged,
                title: Text(
                  'Privée',
                  style: AppTheme().stylish1(15, AppTheme.black),
                ),
              ),
            ],
          ),
        ),
        widget.protegerPin == 2
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
                    controller: widget.pin,
                    inputFormatters: inputFormaters,
                    keyboardType: TextInputType.number,
                    hint: 'Code PIN',
                    validator: (value) {
                      if (value!.length < 5) {
                        return "Le code pin doit comporté 5 chiffres";
                      } else if (value.isEmpty) {
                        return "Veuillez un code pin";
                      }
                      return null;
                    },
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(height: context.heightPercent(5)),
        widget.isLoading
            ? const LoadingCircle()
            : SubmitButton(
                text: "Créer l'adresse",
                onTap: widget.onTap,
              ),
      ],
    );
  }
}
