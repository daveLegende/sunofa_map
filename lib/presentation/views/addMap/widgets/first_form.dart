import 'package:flutter/material.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class FirstForm extends StatefulWidget {
  const FirstForm({super.key});

  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  int? _selectedLocationOption;
  // int? _selectedPrivacyOption;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabelWithAsterisk('Créer un identifiant'),
        const SizedBox(height: 8),
        AppHelpers.buildTextFormField(
          hint: 'ex: KGB2',
        ),
        SizedBox(
          height: context.heightPercent(2),
        ),
        buildLabelWithAsterisk("Nom de l'adresse"),
        const SizedBox(height: 8),
        AppHelpers.buildTextFormField(
          hint: 'Maison IDAH',
        ),
        SizedBox(
          height: context.heightPercent(2),
        ),
        buildLabelWithAsterisk('Pays, ville, quartier ou rue'),
        const SizedBox(height: 8),
        AppHelpers.buildTextFormField(
          hint: 'Pays, ville...',
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
              groupValue: _selectedLocationOption,
              onChanged: (value) {
                setState(() {
                  _selectedLocationOption = value;
                });
              },
              title: Text(
                'Mon adresse google',
                style: AppTheme().stylish1(15, AppTheme.black),
              ),
            ),
            RadioListTile<int>(
              value: 2,
              groupValue: _selectedLocationOption,
              onChanged: (value) {
                setState(() {
                  _selectedLocationOption = value;
                });
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
          hint: 'Longez tout droit vers ...',
          maxLines: 3,
        ),
        SizedBox(
          height: context.heightPercent(5),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: context.widthPercent(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel',
                          style: AppTheme().stylish1(
                            15,
                            AppTheme.white,
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: context.widthPercent(3),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: context.widthPercent(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppTheme.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: AppTheme().stylish1(
                            15,
                            AppTheme.white,
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.heightPercent(2),
        ),
      ],
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
}
