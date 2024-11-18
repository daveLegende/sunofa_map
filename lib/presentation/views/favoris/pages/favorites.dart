import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          "Mes favoris",
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
      ),
    );
  }
}
