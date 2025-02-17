import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
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
        // height: 55,
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
            focusedErrorBorder: OutlineInputBorder(
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
          style: AppTheme().stylish1(15, mblack),
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
              borderSide: BorderSide(color: AppTheme.primaryColor),
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

// class DecoratedField extends StatelessWidget {
//   const DecoratedField({
//     super.key,
//     this.validator,
//     this.onChanged,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.inputFormatters,
//     this.keyboardType,
//     this.readOnly = false,
//     this.autoFocus = false,
//     this.labelText,
//     this.focus,
//     this.prefixIcon,
//     required this.hintText,
//     required this.controller,
//   });

//   final String hintText;
//   final String? labelText;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool obscureText;
//   final bool? readOnly;
//   final bool autoFocus;
//   final TextInputType? keyboardType;
//   final FocusNode? focus;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final void Function(String)? onChanged;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {

//     return Card(
//       elevation: 10,
//       color: mwhite,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: SizedBox(
//         height: 60,
//         width: context.width,
//         child: Center(
//           child: TextFormField(
//             controller: controller,
//             readOnly: readOnly!,
//             keyboardType: keyboardType,
//             focusNode: focus,
//             autofocus: autoFocus,
//             inputFormatters: inputFormatters,
//             obscureText: obscureText,
//             cursorColor: mblack,
//             style: AppTheme().stylish1(15, mblack),
//             // style: StyleText().googleTitre.copyWith(color: mblack),
//             decoration: InputDecoration(
//               suffixIcon: suffixIcon,
//               prefixIcon: prefixIcon,
//               hintText: hintText,
//               labelText: labelText,
//               // filled: true,
//               // fillColor: AppTheme.primaryColor.withOpacity(.09),
//               hintStyle: AppTheme().stylish1(
//                 15,
//                 mgrey,
//                 isBold: false,
//               ),
//               labelStyle: AppTheme().stylish1(
//                 13,
//                 mgrey,
//                 isBold: false,
//               ),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: AppTheme.primaryColor),
//               ),
//               enabledBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: mgrey),
//               ),
//               errorBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: mred),
//               ),
//             ),
//             onChanged: onChanged,
//             validator: validator,
//           ),
//         ),
//       ),
//     );
//   }
// }

class DecoratedField extends StatefulWidget {
  const DecoratedField({
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
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  State<DecoratedField> createState() => _DecoratedFieldState();
}

class _DecoratedFieldState extends State<DecoratedField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _hasFocus ? 10 : 0,
      color: mwhite,
      shape: _hasFocus
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Center(
          child: TextFormField(
            controller: widget.controller,
            readOnly: widget.readOnly!,
            keyboardType: widget.keyboardType,
            focusNode: _focusNode,
            autofocus: widget.autoFocus,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscureText,
            cursorColor: mblack,
            style: AppTheme().stylish1(15, mblack),
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              labelText: widget.labelText,
              hintStyle: AppTheme().stylish1(15, mgrey, isBold: false),
              labelStyle: AppTheme().stylish1(13, mgrey, isBold: false),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: _hasFocus ? Colors.transparent : mgrey,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: _hasFocus ? Colors.transparent : mgrey,
                ),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: mred),
              ),
            ),
            onChanged: widget.onChanged,
            validator: widget.validator,
          ),
        ),
      ),
    );
  }
}

class PhoneFieldDecorated extends StatefulWidget {
  const PhoneFieldDecorated({
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
    this.prefixIcon,
    required this.hintText,
    required this.controller,
    this.onCodeChanged,
  });

  final String hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool? readOnly;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(CountryCode)? onCodeChanged;
  final TextEditingController controller;

  @override
  State<PhoneFieldDecorated> createState() => _PhoneFieldDecoratedState();
}

class _PhoneFieldDecoratedState extends State<PhoneFieldDecorated> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          elevation: _hasFocus ? 10 : 0,
          color: _hasFocus ? mwhite : const Color.fromRGBO(0, 0, 0, 0),
          shape: _hasFocus
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          child: SizedBox(
            height: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(),
              color: mwhite.withOpacity(0.2),
              child: CountryCodePicker(
                textStyle: AppTheme().stylish1(14, mblack),
                onChanged: widget.onCodeChanged,
                initialSelection: 'US',
                showFlagDialog: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DecoratedField(
            controller: widget.controller,
            inputFormatters: inputFormaters,
            keyboardType: TextInputType.number,
            hintText: widget.hintText,
            labelText: widget.labelText,
            prefixIcon: const Icon(
              CupertinoIcons.phone_circle_fill,
              color: mgrey,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return mPhoneNumberNullError;
              } else if (value.length < 8) {
                return mPhoneNumberInvalide;
              } else {
                return null;
              }
            },
          ),
        ),
        // Card(
        //   elevation: _hasFocus ? 10 : 0,
        //   color: _hasFocus ? mwhite : Colors.transparent,
        //   shape: _hasFocus ? RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ) : null,
        //   child: SizedBox(
        //     height: 60,
        //     width: double.infinity,
        //     child: Center(
        //       child: TextFormField(
        //         controller: widget.controller,
        //         readOnly: widget.readOnly!,
        //         keyboardType: widget.keyboardType,
        //         focusNode: _focusNode,
        //         autofocus: widget.autoFocus,
        //         inputFormatters: widget.inputFormatters,
        //         obscureText: widget.obscureText,
        //         cursorColor: mblack,
        //         style: AppTheme().stylish1(15, mblack),
        //         decoration: InputDecoration(
        //           suffixIcon: widget.suffixIcon,
        //           prefixIcon: widget.prefixIcon,
        //           hintText: widget.hintText,
        //           labelText: widget.labelText,
        //           hintStyle: AppTheme().stylish1(15, mgrey, isBold: false),
        //           labelStyle: AppTheme().stylish1(13, mgrey, isBold: false),
        //           focusedBorder: UnderlineInputBorder(
        //             borderSide: BorderSide(
        //               color: _hasFocus ? Colors.transparent : mgrey,
        //             ),
        //           ),
        //           enabledBorder: UnderlineInputBorder(
        //             borderSide: BorderSide(
        //               color: _hasFocus ? Colors.transparent : mgrey,
        //             ),
        //           ),
        //           errorBorder: const UnderlineInputBorder(
        //             borderSide: BorderSide(color: mred),
        //           ),
        //         ),
        //         onChanged: widget.onChanged,
        //         validator: widget.validator,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
