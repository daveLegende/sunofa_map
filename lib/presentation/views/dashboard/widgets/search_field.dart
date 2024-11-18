import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppTheme.primaryColor,
      decoration: InputDecoration(
        hintText: "Recherche.....",
        hintStyle: AppTheme().stylish1(15, AppTheme.black),
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppTheme.primaryColor)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
      ),
    );
  }
}
