import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class PoliticScreen extends StatelessWidget {
  const PoliticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Politic',
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const HeroIcon(
            HeroIcons.arrowLeftCircle,
            color: AppTheme.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width / 2,
                height: context.width / 2,
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Text(
                'Privacy Policy',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "SunofaMaps is committed to protecting the privacy of its users' personal data in accordance with applicable regulations, including the GDPR.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Data Collection',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "We collect only the necessary information to respond to user requests and provide our services, via forms such as the contact form. The collected data is minimized and does not include sensitive personal data. Sunofa Maps collects personal information (name, email address, phone number) to create and manage user accounts. The app also collects location and connection data to provide its location services.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Data Processing',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "The collected information is only used for request processing. No data is shared with third parties or used for purposes not specified at the time of collection. The collected data is used to: Provide location and address-sharing services. Improve app functionality. Communicate with users about updates or changes to services.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Data Retention Period',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "Data is retained for a maximum of one year, unless a longer retention period is required by law or necessary for service execution..",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Data Sharing',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "Personal data is not sold or shared with third parties, except with the user's explicit consent or as required by law. Sunofa Maps does not sell users' personal data to third parties. Data may be shared with trusted partners only to improve the service. Any legal request for data disclosure will be complied with in accordance with applicable laws.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Consent',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "By submitting your information, you consent to its use as specified. You may withdraw your consent at any time by contacting us through the information provided on our website.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Security',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "We implement security measures to protect personal data, including data encryption and regular updates to our CMS and servers. Sunofa Maps uses encryption technologies and security measures to protect personal data against unauthorized access. However, no transmission or storage method is completely secure.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Exercise of Rights',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "You have the right to request the correction, deletion, or portability of your data. For any request, please use the “Exercise Your Rights” page on our site or contact us by mail at the address provided. Users have the right to access, correct, delete, or restrict the use of their personal data. They can also withdraw their consent for data processing at any time.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Privacy Policy Changes',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "Sunofa Maps may change this privacy policy at any time. Users will be informed of significant changes via email or an in-app notification.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Terms of Use',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "By using SunofaMaps, you agree to the following terms : \n * Acceptance of Terms : By accessing and using Sunofa Maps, you accept these terms of use. If you do not agree with these terms, please stop using the app..\n* Access and Use : You may access the site for personal use. Any commercial use requires our prior authorization..\n* Use of Services :Users agree to use Sunofa Maps only for lawful purposes and in compliance with these terms. Any misuse, such as unauthorized access to others' accounts or using the app for illegal purposes, is prohibited..\n* User Account : Users must provide accurate and up-to-date information when creating their account. They are responsible for the security of their password and for all activities conducted from their account..\n* Intellectual Property : The site content is protected by intellectual property laws. Any reproduction without our consent is prohibited. All content, trademarks, and logos on Sunofa Maps are the exclusive property of the app and are protected by intellectual property laws. Any unauthorized reproduction or distribution is prohibited.\n* Responsibility : SunofaMaps is not responsible for indirect damages related to the use of our site. Sunofa Maps does not guarantee the accuracy of location information and disclaims any liability for direct or indirect damages related to the use of services. The app is provided as is and as available.\n* Edit : We reserve the right to modify these terms at any time. Changes will be posted on this page..",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              Text(
                'Governance',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "These terms are governed by the laws of your country. For any questions, contact us at the address provided in the *Contact section..*",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
