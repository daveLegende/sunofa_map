import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AppHelpers {
  static Widget buildTextFormField({
    required String hint,
    bool isPassword = false,
    TextEditingController? controller,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: AppTheme.black,
      cursorErrorColor: AppTheme.red,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTheme().stylish1(
          15,
          AppTheme.black,
          isBold: false,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }
}
