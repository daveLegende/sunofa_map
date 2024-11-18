import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          "Mes Adresses Book",
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
      ),
    );
  }
}
