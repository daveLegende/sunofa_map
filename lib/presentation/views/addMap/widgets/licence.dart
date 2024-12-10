import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class LicenceAgreement extends StatelessWidget {
  const LicenceAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: false,
              onChanged: (value) {},
            ),
            Text(
              'I accept',
              style: AppTheme().stylish1(15, AppTheme.black),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            style: AppTheme().stylish1(15, AppTheme.black),
            children: [
              TextSpan(
                text: 'By clicking "I accept", you agree to the ',
                style: AppTheme().stylish1(15, AppTheme.black),
              ),
              TextSpan(
                text: 'Privacy Policies',
                style: AppTheme().stylish1(15, AppTheme.primaryColor),
              ),
              TextSpan(
                text: ' and the ',
                style: AppTheme().stylish1(15, AppTheme.black),
              ),
              TextSpan(
                text: 'Terms of Use',
                style: AppTheme().stylish1(15, AppTheme.primaryColor),
              ),
              const TextSpan(text: ' de SunofaMap.'),
            ],
          ),
        ),
      ],
    );
  }
}
