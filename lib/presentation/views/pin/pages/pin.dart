import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final formKey = GlobalKey<FormState>();
  final oldPin = TextEditingController();
  final newPin = TextEditingController();
  final confPin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(),
        title: Text(
          "Gestion code PIN",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Container(
        color: AppTheme.lightGray,
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Voulez-vous modifier votre code PIN ?",
                    style: AppTheme().stylish1(16, mblack),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: context.height * .5,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: mwhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomFormField(
                          controller: oldPin,
                          hint: "Ancien code PIN",
                          text: "Ancien code PIN",
                          // validator: (p0) {
                          //   if (p0!.isEmpty) {
                          //     return "Ancien PIN incorrecte";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        // if (oldPin.text.trim().isEmpty)
                        //   const Text(
                        //     "Ancien PIN incorrecte",
                        //     style: TextStyle(
                        //       color: mred,
                        //     ),
                        //   ),
                        CustomFormField(
                          controller: newPin,
                          hint: "Nouveau code PIN",
                          text: "Nouveau code PIN",
                          // validator: (p0) {
                          //   if (p0!.isEmpty) {
                          //     return "Entrez un PIN Valide";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        // if (newPin.text.trim().isEmpty)
                        //   const Text(
                        //     "Entrez un PIN Valide",
                        //     style: TextStyle(
                        //       color: mred,
                        //     ),
                        //   ),
                        CustomFormField(
                          controller: confPin,
                          text: "Confirmer le nouveau code PIN",
                          hint: "Confirmer code PIN",
                          // validator: (p0) {
                          //   if (p0!.trim() != newPin.text.trim()) {
                          //     return "Code PIN incorrecte";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        // if (confPin.text.trim() != newPin.text.trim())
                        //   const Text(
                        //     "Code PIN incorrecte",
                        //     style: TextStyle(
                        //       color: mred,
                        //     ),
                        //   ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 2,
                              child: SubmitButton(
                                text: "Soumettre",
                                onTap: () {
                                  if (formKey.currentState!.validate()) {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.text,
    required this.hint,
    required this.controller,
    this.validator,
  });
  final String text, hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTheme().stylish1(15, mgrey),
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor,
            ),
          ),
          child: Center(
            child: TextFormField(
              controller: controller,
              cursorColor: mblack,
              keyboardType: TextInputType.number,
              inputFormatters: inputFormaters,
              style: AppTheme().stylish1(15, mblack),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTheme().stylish1(14, mgrey),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}
