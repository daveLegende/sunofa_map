import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/others.dart';
import '../widgets/preference_widget.dart';
import '../widgets/profil_card.dart';

class ParamScreen extends StatelessWidget {
  const ParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
          routeNamed: Routes.home2,
        ),
        title: Text(
          "Paramètres",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Container(
        width: context.width,
        height: context.height,
        color: AppTheme.lightGray,
        child: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingProfilCard(),
              SizedBox(height: 15),
              SettingPreference(),
              SizedBox(height: 15),
              SettingOthers(),
            ],
          ),
        ),
      ),
    );
  }
}

