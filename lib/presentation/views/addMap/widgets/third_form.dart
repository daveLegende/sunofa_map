import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/views/politic/politic.dart';
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
  bool isAccept = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "add_address.third.secure_label".tr(),
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
                  "add_address.third.public".tr(),
                  style: AppTheme().stylish1(15, AppTheme.black),
                ),
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: widget.protegerPin,
                onChanged: widget.onSelectionChanged,
                title: Text(
                  "add_address.third.private".tr(),
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
                    "add_address.third.pin_label".tr(),
                    style:
                        AppTheme().stylish1(15, AppTheme.black, isBold: true),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "add_address.third.pin_desc".tr(),
                    style: AppTheme().stylish1(13, mgrey),
                  ),
                  const SizedBox(height: 8),
                  AppHelpers.buildTextFormField(
                    controller: widget.pin,
                    inputFormatters: inputFormaters,
                    keyboardType: TextInputType.number,
                    hint: "add_address.third.pin_hint".tr(),
                    validator: (value) {
                      if (widget.protegerPin == 2) {
                        // Vérifier si l'option "private" est sélectionnée
                        if (value!.isEmpty) {
                          return "add_address.third.pin_empty"
                              .tr(); // Message si le PIN est vide
                        } else if (value.length < 4) {
                          return "add_address.third.pin_length"
                              .tr(); // Message si le PIN est trop court
                        }
                      }
                      return null; // Valide si aucune des conditions ci-dessus n'est remplie
                    },
                  )
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 20),
        Column(
          children: [
            CheckboxListTile(
              value: isAccept,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  isAccept = !isAccept;
                });
              },
              title: Text(
                "add_address.third.accept".tr(),
                style: AppTheme().stylish1(
                  15,
                  mblack,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              children: [
                Text("add_address.third.accept_desc".tr()),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const PoliticScreen();
                      }),
                    );
                  },
                  child: Text(
                    "add_address.third.politic".tr(),
                    style: AppTheme().stylish1(
                      15,
                      mblack,
                      isBold: true,
                    ),
                  ),
                ),
                Text(" ${"add_address.third.and".tr()}"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const PoliticScreen();
                      }),
                    );
                  },
                  child: Text(
                    "${"add_address.third.condition".tr()} ",
                    style: AppTheme().stylish1(
                      15,
                      mblack,
                      isBold: true,
                    ),
                  ),
                ),
                Text("add_address.third.sunofa".tr()),
              ],
            ),
          ],
        ),
        SizedBox(height: context.heightPercent(5)),
        widget.isLoading
            ? const LoadingCircle()
            : isAccept
                ? SubmitButton(
                    text: "add_address.third.create_ad".tr(),
                    onTap: widget.onTap,
                  )
                : const SizedBox(),
      ],
    );
  }
}
