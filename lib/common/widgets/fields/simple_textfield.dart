import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly = false,
    this.autoFocus = false,
    this.labelText,
    this.focus,
    this.prefixIcon,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool? readOnly;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 55,
        child: TextFormField(
          controller: controller,
          readOnly: readOnly!,
          keyboardType: keyboardType,
          focusNode: focus,
          autofocus: autoFocus,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          cursorColor: mblack,
          style: AppTheme().stylish1(16, mblack),
          // style: StyleText().googleTitre.copyWith(color: mblack),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            filled: true,
            fillColor: AppTheme.primaryColor.withOpacity(.09),
            hintStyle: AppTheme().stylish1(
              15,
              mgrey,
              isBold: false,
            ),
            labelText: labelText,
            // labelStyle: StyleText().googleTitre.copyWith(color: mgrey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}





class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly = false,
    this.autoFocus = false,
    this.labelText,
    this.focus,
    this.prefixIcon,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool? readOnly;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 55,
        child: TextFormField(
          controller: controller,
          readOnly: readOnly!,
          keyboardType: keyboardType,
          focusNode: focus,
          autofocus: autoFocus,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          cursorColor: mblack,
          style: AppTheme().stylish1(16, mblack),
          // style: StyleText().googleTitre.copyWith(color: mblack),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            labelText: labelText,
            // filled: true,
            // fillColor: AppTheme.primaryColor.withOpacity(.09),
            hintStyle: AppTheme().stylish1(
              15,
              mgrey,
              isBold: false,
            ),
            labelStyle: AppTheme().stylish1(
              13,
              mgrey,
              isBold: false,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: mwhite),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: mgrey),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: mred),
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
